package com.common.service;

import com.common.bean.MenuNode;
import com.common.utils.ObjectUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @AUTO 菜单节点服务
 * @Author AIM
 * @DATE 2019/4/25
 */
@Service
public class MenuNodeService {

    @Resource
    private JdbcTemplate jdbcTemplate;

    /**
     * 获取用户权限集合
     */
    public List<Long> getUserRoles(String userName) {
        if (ObjectUtil.isEmpty(userName)) {
            return new ArrayList<Long>();
        } else {
            StringBuffer sb = new StringBuffer();
            sb.append("SELECT u.`ROLE_ID` FROM `sys_user` u WHERE u.`USERNAME`=?");
            return jdbcTemplate.queryForList(sb.toString(), new Object[]{userName}, Long.class);
        }
    }

    /**
     * 获取栏目列表
     */
    public List<MenuNode> getUserMenuNodes(List<Long> roleIds) {
        if (roleIds == null || roleIds.size() == 0) {
            return new ArrayList<MenuNode>();
        } else {
            StringBuffer sb = new StringBuffer();
            sb.append("SELECT m.`id`,m.`pid`,m.`icon`,m.`name`,m.`url`,m.`mold`,m.`sort`,m.`level` FROM `sys_menu` m ");
            sb.append(" INNER JOIN `sys_role_menu` r ON r.`MENU_ID`=m.`ID` WHERE r.`ROLE_ID` IN (");
            for (int i = 0; i < roleIds.size(); i++) {
                sb.append("?,");
            }
            if (sb.toString().endsWith(",")) {
                sb.deleteCharAt(sb.length() - 1);
            }
            sb.append(" ) AND m.`mold`!=2 AND m.`enabled`=1 ORDER BY m.`level`,m.`sort` ASC");
            List<MenuNode> menus = jdbcTemplate.query(sb.toString(), roleIds.toArray(), BeanPropertyRowMapper.newInstance(MenuNode.class));
            return MenuNode.buildTitle(menus);
        }
    }

    /**
     * 根据配置文件设置过滤接口文档信息
     *
     * @param nodes    查询到的数据
     * @param menuName 指定的栏目名称
     */
    private static List<MenuNode> filterMenuByName(List<MenuNode> nodes, String menuName) {
        List<MenuNode> menuNodesCopy = new ArrayList<>(nodes.size());
        for (MenuNode menuNode : nodes) {
            if (!menuName.equals(menuNode.getName())) {
                menuNodesCopy.add(menuNode);
            }
            List<MenuNode> childrenList = menuNode.getChildren();
            if (childrenList != null && childrenList.size() > 0) {
                menuNode.setChildren(filterMenuByName(childrenList, menuName));
            }
        }
        return menuNodesCopy;
    }

    /**
     * 栏目列表
     *
     * @param condition 查询条件
     * @param level     菜单层级
     */
    public List<Map<String, Object>> getMenuTreeList(String condition, String level) {
        List<String> params = new LinkedList<String>();
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT id, CODE AS code, PCODE AS pcode, NAME AS name, ICON AS icon,");
        sb.append("URL AS url, SORT AS sort, LEVELS AS levels, MENU_FLAG AS ismenu, DESCRIPTION AS description,");
        sb.append("STATUS AS status, NEW_PAGE_FLAG AS newPageFlag, OPEN_FLAG AS openFlag, CREATE_TIME AS createTime, ");
        sb.append("UPDATE_TIME AS updateTime, CREATE_USER AS createUser, UPDATE_USER AS updateUser ");
        sb.append(" FROM sys_menu WHERE STATUS = 'ENABLE' ");
        if (ObjectUtil.isNotEmpty(condition)) {
            sb.append(" AND (NAME LIKE CONCAT('%',?,'%') OR CODE LIKE CONCAT('%',?,'%')) ");
            params.add(condition);
            params.add(condition);
        }
        if (ObjectUtil.isNotEmpty(level)) {
            sb.append("AND LEVELS = ? ");
            params.add(level);
        }

        List<Map<String, Object>> list = jdbcTemplate.queryForList(sb.toString(), params.toArray());

        return this.getTreeList(list);
    }

    private List<Map<String, Object>> getTreeList(List<Map<String, Object>> list) {
        List<Map<String, Object>> listParentRecord = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> listNotParentRecord = new ArrayList<Map<String, Object>>();
        // 第一步：遍历找出所有的根节点和非根节点
        if (list != null && list.size() > 0) {
            for (Map<String, Object> map : list) {
                if (map.get("level").toString().trim().equals("1")) {
                    listParentRecord.add(map);
                } else {
                    listNotParentRecord.add(map);
                }
            }
        }
        // 第二步： 递归获取所有子节点
        if (listParentRecord.size() > 0) {
            for (Map<String, Object> record : listParentRecord) {
                // 添加所有子级
                record.put("children", this.getChildList(listNotParentRecord, record.get("code").toString().trim()));
            }
        } else {
            listParentRecord.addAll(listNotParentRecord);
        }
        return listParentRecord;
    }

    private List<Map<String, Object>> getChildList(List<Map<String, Object>> childList, String parentCode) {
        List<Map<String, Object>> listParentOrgs = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> listNotParentOrgs = new ArrayList<Map<String, Object>>();
        // 遍历childList，找出所有的根节点和非根节点
        if (childList != null && childList.size() > 0) {
            for (Map<String, Object> record : childList) {
                // 对比找出父节点
                if (record.get("pcode").toString().equals(parentCode)) {
                    listParentOrgs.add(record);
                } else {
                    listNotParentOrgs.add(record);
                }
            }
        }
        // 查询子节点
        if (listParentOrgs.size() > 0) {
            for (Map<String, Object> record : listParentOrgs) {
                // 递归查询子节点
                record.put("children", getChildList(listNotParentOrgs, record.get("code").toString().trim()));
            }
        }
        return listParentOrgs;
    }
}
