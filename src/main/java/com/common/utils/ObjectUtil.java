package com.common.utils;

import java.util.*;

/**
 * @version v2.0
 * @AUTO 对象工具类
 * @DATE 2018-11-5 下午6:12:48
 * @Author Fit
 * @Company 天际友盟
 */
public class ObjectUtil {

    /**
     * 判断对象是不是空
     *
     * @param obj
     */
    public static boolean isEmpty(Object obj) {
        if (obj == null)
            return true;
        if (obj instanceof String) {
            if (!"".equals(obj))
                return false;
        } else if (obj instanceof StringBuffer) {
            return isEmpty(obj.toString());
        } else if (obj instanceof Map) {
            if (!isEmpty(((Map<?, ?>) obj).values()))
                return false;
        } else if (obj instanceof Enumeration) {
            Enumeration<?> enumeration = (Enumeration<?>) obj;
            while (enumeration.hasMoreElements()) {
                if (!isEmpty(enumeration.nextElement()))
                    return false;
            }
        } else if (obj instanceof Iterable) {
            if (obj instanceof List && obj instanceof RandomAccess) {
                List<?> objList = (List<?>) obj;
                for (int i = 0; i < objList.size(); i++) {
                    if (!isEmpty(objList.get(i)))
                        return false;
                }
            } else if (!isEmpty(((Iterable<?>) obj).iterator()))
                return false;
        } else if (obj instanceof Iterator) {
            Iterator<?> it = (Iterator<?>) obj;
            while (it.hasNext()) {
                if (!isEmpty(it.next()))
                    return false;
            }
        } else if (obj instanceof Object[]) {
            Object[] objs = (Object[]) obj;
            for (Object elem : objs) {
                if (!isEmpty(elem))
                    return false;
            }
        } else if (obj instanceof int[]) {
            for (Object elem : (int[]) obj) {
                if (!isEmpty(elem))
                    return false;
            }
        } else {
            return false;
        }
        return true;
    }

    public static boolean isNotEmpty(Object o) {
        return !isEmpty(o);
    }

    public static boolean isBlank(CharSequence cs) {
        int strLen;
        if (cs == null || (strLen = cs.length()) == 0) {
            return true;
        }
        for (int i = 0; i < strLen; i++) {
            if (Character.isWhitespace(cs.charAt(i)) == false) {
                return false;
            }
        }
        return true;
    }
}
