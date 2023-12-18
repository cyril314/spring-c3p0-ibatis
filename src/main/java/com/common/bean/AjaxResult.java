package com.common.bean;

import java.util.HashMap;

/**
 * @AUTO 消息返回体
 * @Author AIM
 * @DATE 2020/7/22
 */
public class AjaxResult extends HashMap<String, Object> {

    private static final long serialVersionUID = 1L;

    /**
     * 初始化一个新创建的 Message 对象
     *
     * @param code 信息码
     * @param msg  内容
     * @param obj  返回数据
     */
    public static AjaxResult getInstance(int code, String msg, Object obj) {
        AjaxResult json = new AjaxResult();
        json.put("message", msg);
        json.put("code", code);
        json.put("data", obj);
        return json;
    }

    /**
     * 返回成功消息
     *
     * @param key   键值
     * @param value 内容
     */
    @Override
    public AjaxResult put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    /**
     * 返回消息
     *
     * @param code  信息码
     * @param msg   内容
     * @param count 分页总数量
     * @param obj   返回数据
     */
    public static AjaxResult results(int code, String msg, Long count, Object obj) {
        AjaxResult json = tables(code, msg, count, obj);
        json.put("recordsTotal", count);
        json.put("recordsFiltered", count);
        return json;
    }

    /**
     * 返回列表信息
     *
     * @param total 页码总数
     * @param rows  返回数据
     */
    public static AjaxResult tables(Long total, Object rows) {
        return tables(0, "查询成功", total, rows);
    }

    /**
     * 返回列表信息
     *
     * @param code  状态码
     * @param msg   消息
     * @param total 页码总数
     * @param rows  返回数据
     */
    public static AjaxResult tables(int code, String msg, Long total, Object rows) {
        return tree(code, msg, rows).put("count", total);
    }

    public static AjaxResult tree(int code, String msg, Object rows) {
        return getInstance(code, msg, rows);
    }

    /**
     * 返回错误消息
     */
    public static AjaxResult error() {
        return error("操作失败");
    }

    /**
     * 返回错误消息
     *
     * @param msg 内容
     */
    public static AjaxResult error(String msg) {
        return error(-1, msg);
    }

    /**
     * 返回错误消息
     *
     * @param code 错误码
     * @param msg  内容
     */
    public static AjaxResult error(int code, String msg) {
        return getInstance(code, msg, null);
    }

    /**
     * 返回成功消息
     */
    public static AjaxResult success() {
        return success(null);
    }

    /**
     * 返回成功消息
     *
     * @param obj 返回数据
     */
    public static AjaxResult success(Object obj) {
        return success("操作成功", obj);
    }

    /**
     * 返回成功消息
     *
     * @param msg 内容
     * @param obj 返回数据
     */
    public static AjaxResult success(String msg, Object obj) {
        return getInstance(0, msg, obj);
    }
}
