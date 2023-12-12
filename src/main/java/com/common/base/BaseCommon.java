package com.common.base;

import com.common.utils.ConverterUtils;

import java.util.List;
import java.util.Map;

/**
 * @AUTO
 * @Author Fit
 * @DATE 2018/5/21
 */
public class BaseCommon {

    /**
     * <将Object转换为Map<String, Object>>
     *
     * @param obj 需要转换的对象
     */
    protected Map<String, Object> Obj2Map(Object obj) throws Exception {
        return ConverterUtils.Obj2Map(obj);
    }

    /**
     * <将List<Object>转换为List<Map<String, Object>>>
     *
     * @param list 需要转换的list
     */
    protected List<Map<String, Object>> converterForMapList(List<Object> list) throws Exception {
        return ConverterUtils.converterForMapList(list);
    }

    /**
     * 对象转换为字符串
     *
     * @param obj     转换对象
     * @param charset 字符集
     */
    protected String convertToString(Object obj, String charset) throws Exception {
        return ConverterUtils.convertToString(obj, charset);
    }
}
