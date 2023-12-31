package com.fit.bean;

import com.common.base.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2023/12/15
 */
@Data
@Builder
@NoArgsConstructor //无参数的构造方法
@AllArgsConstructor //包含所有变量构造方法
public class SysMenu extends BaseEntity<SysMenu> {
    /** 主键 (主健ID) (无默认值) */
    private Long id;

    /** 父ID  (默认值为: 0) */
    private Long pid;

    /** 名称 (无默认值) */
    private String name;

    /** 图标 (无默认值) */
    private String icon;

    /** 类型,1:url 2:method  (默认值为: 0) */
    private Integer mold;

    /** 链接 (无默认值) */
    private String url;

    /** 优先权 (无默认值) */
    private Integer sort;

    /** 描述 (无默认值) */
    private String notes;

    /** 层级  (默认值为: 0) */
    private Integer level;

    /** 是否是超级权限 0非1是  (默认值为: 0) */
    private Integer isys;
}