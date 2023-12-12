package com.common.service;

import com.common.bean.ZTreeNode;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @AUTO 获取ztree节点服务
 * @Author AIM
 * @DATE 2019/4/28
 */
@Service
public class ZtreeNodeService {

    @Resource
    private JdbcTemplate jdbcTemplate;

    /**
     * 获取部门树节点集合
     */
    public List<ZTreeNode> deptZtree() {
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT id, pid AS parentId,`FULL_NAME` AS title,`LEVEL`,");
        sb.append("(CASE WHEN (PID = 0 OR PID IS NULL) THEN 'true' ELSE 'false' END ) AS OPEN ");
        sb.append(" FROM sys_dept");
        return jdbcTemplate.query(sb.toString(), BeanPropertyRowMapper.newInstance(ZTreeNode.class));
    }

    /**
     * 获取栏目树节点集合
     */
    public List<ZTreeNode> menuZtree() {
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT sm.`id`, IFNULL(ms.`id`,0) AS parentId, sm.`NAME`, sm.`LEVEL`,");
        sb.append("(CASE WHEN (sm.`pid` = 0 OR sm.`pid` IS NULL) THEN 'true' ELSE 'false' END ) AS OPEN");
        sb.append(" FROM `sys_menu` sm LEFT JOIN `sys_menu` ms ON sm.`pid` = ms.`id`");
        return jdbcTemplate.query(sb.toString(), BeanPropertyRowMapper.newInstance(ZTreeNode.class));
    }
}
