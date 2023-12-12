package com.common.bean;

import lombok.Data;

/**
 * ztree 插件的节点
 */
@Data
public class ZTreeNode {

    /**
     * 节点id
     */
    private Long id;

    /**
     * 父节点id
     */
    private Long parentId;

    /**
     * 节点名称
     */
    private String title;

    /**
     * 自定义码
     */
    private String code;

    /**
     * 自定义层级
     */
    private Integer level = 0;

    /**
     * 是否打开节点
     */
    private Boolean open;

    /**
     * 是否被选中
     */
    private Boolean checked;

    /**
     * 节点图标  single or group
     */
    private String iconSkin;

    /**
     * 创建ztree的父级节点
     */
    public static ZTreeNode createParent() {
        return createParent("顶级", 0L);
    }

    /**
     * 创建ztree的父级节点
     */
    public static ZTreeNode createParent(String zname, Long zid) {
        ZTreeNode zTreeNode = new ZTreeNode();
        zTreeNode.setChecked(false);
        zTreeNode.setId(zid);
        zTreeNode.setTitle(zname);
        zTreeNode.setOpen(true);
        zTreeNode.setParentId(0L);
        zTreeNode.setLevel(0);
        return zTreeNode;
    }
}
