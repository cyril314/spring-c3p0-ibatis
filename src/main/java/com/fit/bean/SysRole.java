package com.fit.bean;

import com.common.base.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2023/12/13
 */
@Data
@Builder
@NoArgsConstructor //无参数的构造方法
@AllArgsConstructor //包含所有变量构造方法
public class SysRole extends BaseEntity<SysRole> {
    /** 主键 (主健ID) (无默认值) */
    private Long id;

    /** 上级ID (无默认值) */
    private Long pid;

    /** 角色名字 (无默认值) */
    private String name;

    /** 角色说明 (无默认值) */
    private String notes;

    /** 是否是超级权限 0非1是  (默认值为: 0) */
    private Integer isys;
}