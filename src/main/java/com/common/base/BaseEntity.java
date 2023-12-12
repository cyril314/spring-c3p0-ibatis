package com.common.base;

import java.io.Serializable;
import java.util.Date;

/**
 * @AUTO 实体基类
 * @FILE BaseEntity.java
 * @DATE 2017-9-8 上午10:04:22
 * @Author Fit
 */
public abstract class BaseEntity<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 是否被禁用 0禁用1正常  (默认值为: 0)
     */
    protected Boolean enabled = true;
    /**
     * 创建人 (无默认值)
     */
    protected Long createUser;

    /**
     * 创建时间 (无默认值)
     */
    protected Date createTime;

    /**
     * 修改人 (无默认值)
     */
    protected Long updateUser;

    /**
     * 修改时间 (无默认值)
     */
    protected Date updateTime;

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public Long getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Long createUser) {
        this.createUser = createUser;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(Long updateUser) {
        this.updateUser = updateUser;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
