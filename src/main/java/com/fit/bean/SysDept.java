package com.fit.bean;

import com.common.base.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2023/12/10
 */
@Data
@Builder
@NoArgsConstructor //无参数的构造方法
@AllArgsConstructor //包含所有变量构造方法
public class SysDept extends BaseEntity<SysDept> {
    private static final long serialVersionUID = 1L;

    /** 主键id (主健ID) (无默认值) */
    private Long id;

    /** 父部门id  (默认值为: 0) */
    private Long pid;

    /** 父级ids (无默认值) */
    private String pids;

    /** 简称 (无默认值) */
    private String simpleName;

    /** 全称 (无默认值) */
    private String fullName;

    /** 描述 (无默认值) */
    private String description;

    /** 层级 (无默认值) */
    private Integer level;

    /** 版本（乐观锁保留字段） (无默认值) */
    private Integer version;

    /** 排序 (无默认值) */
    private Integer sort;
}