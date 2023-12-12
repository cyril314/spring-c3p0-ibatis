package com.common.base;

import java.util.List;
import java.util.Map;

/**
 * @AUTO DAO支持类接口
 * @FILE BaseCrudDao.java
 * @DATE 2018-3-23 下午2:38:38
 * @Author Fit
 */
public interface BaseCrudDao<T> {

    /**
     * 获取单条数据
     */
    public T getById(Long id);

    /**
     * 获取单条数据
     */
    public T get(T entity);

    /**
     * 查询全部数据列表
     */
    public List<T> findList();

    /**
     * 查询数据列表
     */
    public List<T> findList(T entity);

    public List<T> findList(Map<String, Object> map);

    /**
     * 列表数量
     */
    public Long findCount(T entity);

    public Long findCount(Map<String, Object> map);

    /**
     * 插入数据
     */
    public Long save(T entity);

    /**
     * 更新数据
     */
    public Long update(T entity);

    /**
     * 删除数据
     */
    public Long delete(Long id);

    /**
     * 删除数据（一般为逻辑删除，更新del_flag字段为1）
     */
    public Long delete(T entity);

    /**
     * 批量删除
     */
    public Long batchDelete(String[] ids);

}
