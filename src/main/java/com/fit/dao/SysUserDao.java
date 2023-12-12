package com.fit.dao;

import com.common.base.BaseCrudDao;
import com.fit.bean.SysUser;
import org.apache.ibatis.annotations.Mapper;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2023/12/10
 */
@Mapper
public interface SysUserDao extends BaseCrudDao<SysUser> {
}