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
    public List<Long> getUserRoles(Long uid) {
        if (ObjectUtil.isEmpty(uid)) {
            return new ArrayList<Long>();
        } else {
            StringBuffer sb = new StringBuffer();
            sb.append("SELECT u.`ROLE_ID` FROM `sys_user` u WHERE u.`id`=?");
            return jdbcTemplate.queryForList(sb.toString(), new Object[]{uid}, Long.class);
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
}
