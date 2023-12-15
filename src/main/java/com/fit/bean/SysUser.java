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
public class SysUser extends BaseEntity<SysUser> {
    /** 主键 (主健ID) (无默认值) */
    private Long id;

    /** 角色ID  (默认值为: 0) */
    private Long roleId;

    /** 部门ID  (默认值为: 0) */
    private Long deptId;

    /** 用户姓名 (无默认值) */
    private String name;

    /** 登陆用户名(登陆号) (无默认值) */
    private String account;

    /** 用户密码 (无默认值) */
    private String password;

    /** 用户生日 (无默认值) */
    private String birthday;

    /** 用户邮箱 (无默认值) */
    private String email;

    /** 用户性别: 0-女,1-男  (默认值为: 0) */
    private Integer sex;

    /** 用户电话 (无默认值) */
    private String phone;

    /** 描述 (无默认值) */
    private String notes;

    /** 是否是超级用户 0非1是  (默认值为: 0) */
    private Integer isys;
}