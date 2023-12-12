package com.common.enums;

/**
 * @AUTO 数据类型
 * @FILE DataType.java
 * @DATE 2021年3月18日 下午5:52:21
 * @Author Fit
 * @Version 2.0
 */
public enum IocType {

    DOMAIN("domain", 1), URL("url", 2), IP("ip", 3), MD5("md5", 4), EMAIL("email", 5), SHA1("sha1", 6), SHA256("sha256", 7);

    private String name;
    private int i;

    private IocType(String name, int i) {
        this.name = name;
        this.i = i;
    }

    public static String getName(int i) {
        for (IocType c : IocType.values()) {
            if (c.getI() == i) {
                return c.name;
            }
        }
        return null;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }
}
