package com.fit.dao;

import com.common.base.BaseCrudDao;
import com.fit.bean.SysRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2023/12/10
 */
@Mapper
public interface SysRoleDao extends BaseCrudDao<SysRole> {
}