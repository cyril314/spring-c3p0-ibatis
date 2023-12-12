package com.common.enums;

/**
 * @AUTO 判断枚举
 * @Author AIM
 * @DATE 2019/4/25
 */
public enum JudgeEnum {

    Y(true, "是", 1),
    N(false, "否", 0);

    private Boolean flag;
    private String desc;
    private Integer code;

    private JudgeEnum(Boolean flag, String desc, Integer code) {
        this.flag = flag;
        this.desc = desc;
        this.code = code;
    }

    public static String valueOf(Integer status) {
        if (status == null) {
            return "";
        } else {
            JudgeEnum[] judge = values();
            for (int i = 0; i < judge.length; ++i) {
                JudgeEnum s = judge[i];
                if (s.getCode().equals(status)) {
                    return s.getDesc();
                }
            }
            return "";
        }
    }

    public Boolean getFlag() {
        return this.flag;
    }

    public String getDesc() {
        return this.desc;
    }

    public Integer getCode() {
        return this.code;
    }
}
