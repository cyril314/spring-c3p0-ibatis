package com.common.utils;

import com.common.bean.MenuNode;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @AUTO 自定义实体复制赋值工具类
 * @FILE BeanUtils.java
 * @DATE 2018-3-7 下午10:09:52
 * @Author Fit
 */
public abstract class BeanUtils extends org.springframework.beans.BeanUtils {

    /**
     * 复制提交内容到原有实体内
     *
     * @param source 新的对象
     * @param target 原有对象
     */
    public static void copyProperties(Object source, Object target) throws BeansException {
        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");
        Class<?> actualEditable = target.getClass();
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        for (PropertyDescriptor targetPd : targetPds) {
            if (targetPd.getWriteMethod() != null) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null && sourcePd.getReadMethod() != null) {
                    try {
                        Method readMethod = sourcePd.getReadMethod();
                        if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                            readMethod.setAccessible(true);
                        }
                        Object value = readMethod.invoke(source);
                        // 这里判断以下value是否为空 当然这里也能进行一些特殊要求的处理 例如绑定时格式转换等等
                        if (value != null) {
                            Method writeMethod = targetPd.getWriteMethod();
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                            writeMethod.invoke(target, value);
                        }
                    } catch (Throwable ex) {
                        throw new FatalBeanException("Could not copy properties from source to target", ex);
                    }
                }
            }
        }
    }

    /**
     * 去掉bean中所有属性为字符串的前后空格
     */
    public static void beanAttributeValueTrim(Object bean) {
        if (bean != null) {
            try {
                // 获取所有的字段包括public,private,protected,private
                Field[] fields = bean.getClass().getDeclaredFields();
                for (int i = 0; i < fields.length; i++) {
                    Field f = fields[i];
                    if (f.getType().getName().equals("java.lang.String")) {
                        String key = f.getName();// 获取字段名
                        Object value = getFieldValue(bean, key);

                        if (value == null)
                            continue;

                        setFieldValue(bean, key, value.toString().trim());
                    }
                }
            } catch (Exception e) {
                throw new RuntimeException();
            }
        }
    }

    /**
     * 利用反射通过get方法获取bean中字段fieldName的值
     *
     * @param bean      对象实体
     * @param fieldName 字段名
     */
    private static Object getFieldValue(Object bean, String fieldName) throws Exception {
        StringBuffer result = new StringBuffer();
        String methodName = result.append("get").append(fieldName.substring(0, 1).toUpperCase()).append(fieldName.substring(1)).toString();

        Object rObject = null;
        Method method = null;

        Class<?>[] classArr = new Class[0];
        method = bean.getClass().getMethod(methodName, classArr);
        rObject = method.invoke(bean, new Object[0]);

        return rObject;
    }

    /**
     * 利用发射调用bean.set方法将value设置到字段
     *
     * @param bean      对象实体
     * @param fieldName 字段名
     * @param value     字段值
     */
    private static void setFieldValue(Object bean, String fieldName, Object value) throws Exception {
        StringBuffer result = new StringBuffer();
        String methodName = result.append("set").append(fieldName.substring(0, 1).toUpperCase()).append(fieldName.substring(1)).toString();
        //利用发射调用bean.set方法将value设置到字段
        Class<?>[] classArr = new Class[1];
        classArr[0] = "java.lang.String".getClass();
        Method method = bean.getClass().getMethod(methodName, classArr);
        method.invoke(bean, value);
    }

    /**
     * List<Map>对象转化成 List<JavaBean>对象
     *
     * @param clazz JavaBean实例对象
     * @param maps  Map对象
     */
    public static <T> List<T> map2JavaList(Class<T> clazz, List<Map<String, Object>> maps) {
        List<T> list = new ArrayList<T>();
        for (Map<String, Object> map : maps) {
            list.add(map2Bean(clazz, map));
        }
        return list;
    }

    /**
     * Map对象转化成 JavaBean对象
     *
     * @param clazz JavaBean实例对象
     * @param map   Map对象
     */
    public static <T> T map2Bean(Class<T> clazz, Map<String, Object> map) {
        try {
            // 获取javaBean属性
            T bean = clazz.newInstance();
            BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass(), Object.class);
            // 创建 JavaBean 对象
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            if (propertyDescriptors != null && propertyDescriptors.length > 0) {
                for (PropertyDescriptor pro : propertyDescriptors) {
                    String key = pro.getName();
                    if (map.containsKey(key)) {
                        Object value = map.get(key);
                        String t = pro.getPropertyType().getName();
                        if (!t.equals("java.lang.String") && (value == null || "".equals(value))) {
                            continue;
                        }
                        Method setter = pro.getWriteMethod();
                        if (setter != null) {
                            System.out.println(String.format("Reflected key %s value %s", t, value.toString()));
                            if (t.equals("java.lang.Long")) {
                                setter.invoke(bean, Long.valueOf(String.valueOf(value)));
                            } else if (t.equals("java.lang.Integer")) {
                                setter.invoke(bean, Integer.valueOf(String.valueOf(value)));
                            } else {
                                setter.invoke(bean, value);
                            }
                        }
                    }
                }
                return bean;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static <T> MenuNode buildTree(List<T> data, Class<T> clazz) {
        Map<Long, MenuNode> nodeMap = new HashMap<>();
        // 创建节点并添加到节点映射中
        for (T node : data) {
            MenuNode menu = new MenuNode();
            copyProperties(node, menu);
            nodeMap.put(menu.getId(), menu);
        }
        // 构建树结构
        MenuNode root = null;
        for (MenuNode node : nodeMap.values()) {
            if (node.getPid() == 0) {
                root = node;
            } else {
                MenuNode parentNode = nodeMap.get(node.getPid());
                if (parentNode != null) {
                    parentNode.getChildren().add(node);
                    if (!parentNode.isOpen() && parentNode.getLevel() < 2) {
                        parentNode.setOpen(true);
                    }
                }
            }
        }
        return root;
    }
}