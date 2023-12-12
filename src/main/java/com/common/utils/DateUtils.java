package com.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.TimeZone;

/**
 * 日期处理工具类
 *
 * @Description: 工具类，可以用作获取系统日期、订单编号等(该代码仅供学习和研究支付宝接口使用，只是提供一个参考)
 */
public class DateUtils {

    /**
     * 完整时间 <yyyy-MM-dd HH:mm:ss>
     */
    public static final String DATE_FULL_STR = "yyyy-MM-dd HH:mm:ss";
    /**
     * 完整时间 <yyyy-MM-dd HH:mm:ss.SSS>
     */
    public static final String DATE_LONG_STR = "yyyy-MM-dd HH:mm:ss.SSS";
    /**
     * 年月日 <yyyy-MM-dd>
     */
    public static final String DATE_SMALL_STR = "yyyy-MM-dd";
    /**
     * 年月 <yyyy-MM>
     */
    public static final String DATE_TINY_STR = "yyyy-MM";
    /**
     * 年月日时分秒 <yyMMddHHmmss>
     */
    public static final String DATE_KEY_STR = "yyMMddHHmmss";
    /**
     * 年月日时分秒 <yyyyMMddHHmmss>
     */
    public static final String DATE_All_KEY_STR = "yyyyMMddHHmmss";
    /**
     * 年月日(无下划线) <yyyyMMdd>
     */
    public static final String DATE_KEY_SHORT = "yyyyMMdd";
    /**
     * 完整时间 <yyyy/MM/dd HH:mm:ss>
     */
    public static final String STR_DATE_SLASH = "yyyy/MM/dd HH:mm:ss";
    /**
     * 年月日 <yyyy/MM/dd>
     */
    public static final String STR_DATE_SLASH_SMALL = "yyyy/MM/dd";
    /**
     * 国际时间格式 <yyyy-MM-dd'T'HH:mm:ss.SSS'Z'>
     */
    public static final String DATE_LONG_STR_UTC = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    /**
     * 国际时间格式 <"yyyy-MM-dd'T'HH:mm:ss'Z'>
     */
    public static final String DATE_FULL_STR_UTC = "yyyy-MM-dd'T'HH:mm:ss'Z'";

    /**
     * 给指定的日期加上(减去)月份
     *
     * @param date    指定时间
     * @param pattern 输出时间格式
     * @param num     增减月数
     */
    public static String addMoth(Date date, String pattern, int num) {
        Calendar calender = Calendar.getInstance();
        calender.setTime(date);
        calender.add(Calendar.MONTH, num);
        return format(calender.getTime(), pattern);
    }

    /**
     * 给制定的时间加上(减去)天
     *
     * @param date    指定时间
     * @param pattern 输出时间格式
     * @param num     增减天数
     */
    public static String addDay(Date date, String pattern, int num) {
        Calendar calender = Calendar.getInstance();
        calender.setTime(date);
        calender.add(Calendar.DATE, num);
        return format(calender.getTime(), pattern);
    }

    /**
     * 获取系统当前时间格式为yyyy-MM-dd HH:mm:ss
     */
    public static String getNowTimeUTC() {
        return format(DATE_FULL_STR_UTC);
    }

    /**
     * 获取系统当前时间格式为yyyy-MM-dd HH:mm:ss
     */
    public static String getNowTime() {
        return format(DATE_FULL_STR);
    }

    /**
     * 获取系统当前时间格式为yyyy-MM-dd HH:mm:ss
     */
    public static String getNowDate() {
        return format(DATE_All_KEY_STR);
    }

    /**
     * 获取系统当前时间
     */
    public static Date nowDate() {
        return new Date();
    }

    /**
     * @param pattern 转换格式
     * @return 转换指定格式字符串
     */
    public static String format(String pattern) {
        return format(nowDate(), pattern);
    }

    /**
     * @return 转换指定<yyyy-MM-dd HH:mm:ss>格式字符串
     */
    public static String format(Date date) {
        return format(date, DATE_FULL_STR);
    }

    /**
     * @param date    时间字符串
     * @param pattern 转换格式
     * @return 转换指定格式字符串
     */
    public static String format(String date, String pattern) {
        if (ObjectUtil.isEmpty(date)) {
            return date;
        }
        return format(parse(date, null, false), pattern);
    }

    /**
     * @param date    时间字符串
     * @param pattern 转换格式
     * @return 转换指定格式字符串
     */
    public static String format(Date date, String pattern) {
        SimpleDateFormat df = new SimpleDateFormat(pattern);
        return df.format(date);
    }

    /**
     * 使用预设格式提取字符串日期
     *
     * @param date 日期字符串
     */
    public static Date parse(String date) {
        return parse(date, DATE_FULL_STR, false);
    }

    /**
     * 指定指定日期字符串
     *
     * @param date    时间字符串
     * @param pattern 时间格式
     */
    public static Date parse(String date, String pattern, boolean isLong) {
        Date time = null;
        String[] formats = {DATE_LONG_STR, DATE_FULL_STR, STR_DATE_SLASH, STR_DATE_SLASH_SMALL, DATE_All_KEY_STR, DATE_LONG_STR_UTC, DATE_FULL_STR_UTC,
                DATE_SMALL_STR};
        try {
            SimpleDateFormat df = new SimpleDateFormat(pattern);
            time = df.parse(date);
        } catch (Exception e) {
            for (String format : formats) {
                try {
                    SimpleDateFormat df = new SimpleDateFormat(format);
                    if (format.contains("'T'")) {
                        df.setTimeZone(TimeZone.getTimeZone("GMT"));
                    }
                    time = df.parse(date);
                    if (time != null) {
                        break;
                    }
                } catch (ParseException pe) {
                    continue;
                }
            }
            try {
                if (time == null && isLong) {
                    long times = Long.parseLong(date);
                    time = new Date(times);
                }
            } catch (NumberFormatException e1) {
            }
        }
        if (time == null) {
            System.out.println("时间解析失败，返回null");
        }
        return time;
    }

    /**
     * 两个时间比较
     */
    public static int compareDateWithNow(Date date) {
        Date now = new Date();
        int rnum = date.compareTo(now);
        return rnum;
    }

    /**
     * 两个时间比较(时间戳比较)
     *
     * @param
     * @return
     */
    public static int compareDateWithNow(long date) {
        long now = dateToUnixTimestamp();
        if (date > now) {
            return 1;
        } else if (date < now) {
            return -1;
        } else {
            return 0;
        }
    }

    /**
     * 将指定的日期转换成Unix时间戳
     *
     * @param date 需要转换的日期 yyyy-MM-dd HH:mm:ss
     * @return long 时间戳
     */
    public static long dateToUnixTimestamp(String date) {
        return dateToUnixTimestamp(date, DATE_FULL_STR);
    }

    /**
     * 将指定的日期转换成Unix时间戳
     *
     * @param date       需要转换的日期
     * @param dateFormat 转换格式
     */
    public static long dateToUnixTimestamp(String date, String dateFormat) {
        return parse(date, dateFormat, false).getTime();
    }

    /**
     * 将当前日期零点转换成Unix时间戳
     *
     * @return long 时间戳
     */
    public static long dateZeroToUnixTimestamp() {
        String nowDay = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        nowDay += " 00:00:00";
        return dateToUnixTimestamp(nowDay);
    }

    /**
     * 将当前时间日期转换成Unix时间戳
     *
     * @return long 时间戳
     */
    public static long dateToUnixTimestamp() {
        long timestamp = new Date().getTime();
        return timestamp;
    }

    /**
     * 将Unix时间戳转换成日期
     *
     * @param timestamp 时间戳
     * @return String 日期字符串
     */
    public static String unixTimestampToDate(long timestamp) {
        SimpleDateFormat sd = new SimpleDateFormat(DATE_FULL_STR);
        sd.setTimeZone(TimeZone.getTimeZone("GMT+8"));
        return sd.format(new Date(timestamp));
    }

    /**
     * 将Unix时间戳转换成日期
     *
     * @param timestamp 时间戳
     * @return String 日期字符串
     */
    public static String TimeStamp2Date(long timestamp, String dateFormat) {
        String date = new SimpleDateFormat(dateFormat).format(new Date(timestamp));
        return date;
    }

    /**
     * 将Unix时间戳转换成日期
     *
     * @param timestamp 时间戳
     * @return String 日期字符串
     */
    public static String TimeStamp2Date(long timestamp) {
        return format(new Date(timestamp));
    }

    /**
     * 返回系统当前时间(精确到毫秒),作为一个唯一的订单编号
     *
     * @return 以yyyyMMddHHmmss为格式的当前系统时间
     */
    public static String getOrderNum() {
        return format(getTime(), DATE_All_KEY_STR);
    }

    /**
     * 获取系统当期年月日(精确到天)，格式：yyyyMMdd
     */
    public static String getDate() {
        return format(getTime(), DATE_KEY_SHORT);
    }

    /**
     * 获取系统时间
     */
    public static Date getTime() {
        return new Date();
    }

    /**
     * 产生随机的三位数
     */
    public static String getThree() {
        Random rad = new Random();
        return rad.nextInt(1000) + "";
    }

    /**
     * @MethodName: getMonthFirstDay
     * @Descb: 获取当月的第一天
     */
    public static String getMonthFirstDay() {
        Calendar cal = Calendar.getInstance();
        Calendar f = (Calendar) cal.clone();
        f.clear();
        f.set(Calendar.YEAR, cal.get(Calendar.YEAR));
        f.set(Calendar.MONTH, cal.get(Calendar.MONTH));
        String firstday = format(f.getTime(), DATE_SMALL_STR);
        firstday = firstday + " 00:00:00";
        return firstday;

    }

    /**
     * @MethodName: getMonthLastDay
     * @Descb: 获取当月的最后一天
     */
    public static String getMonthLastDay() {
        Calendar cal = Calendar.getInstance();
        Calendar l = (Calendar) cal.clone();
        l.clear();
        l.set(Calendar.YEAR, cal.get(Calendar.YEAR));
        l.set(Calendar.MONTH, cal.get(Calendar.MONTH) + 1);
        l.set(Calendar.MILLISECOND, -1);
        String lastday = format(l.getTime(), DATE_SMALL_STR);
        lastday = lastday + " 23:59:59";
        return lastday;
    }

    /**
     * @MethodName: getYesterDay
     * @Descb: 获取昨天日期
     */
    public static Date getYesterDay() {
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -1);// 把日期往后增加一天.整数往后推,负数往前移动
        return calendar.getTime();
    }

    /**
     * @param year
     * @Descb 当前时间加上 年份 所得的 日期
     */
    public static String getYear(int year) {
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.YEAR, +year);
        String theday = format(calendar.getTime(), DATE_FULL_STR);
        return theday;
    }

    /**
     * 获取昨天零点的时间戳
     */
    public static long getYesterDayZeroUnixTimestamp() {
        String yesterDay = format(getYesterDay(), DATE_SMALL_STR);
        yesterDay += " 00:00:00";
        return dateToUnixTimestamp(yesterDay);
    }

    /**
     * 获取昨天23:59:59的时间戳
     */
    public static long getYesterDayUnixTimestamp() {
        String yesterDay = format(getYesterDay(), DATE_SMALL_STR);
        yesterDay += " 23:59:59";
        return dateToUnixTimestamp(yesterDay);
    }

    /**
     * 获取昨天零点的时间戳
     */
    public static long getNowZeroDate() {
        String now = format(new Date(), DATE_SMALL_STR);
        now += " 00:00:00";
        return dateToUnixTimestamp(now);
    }

    /**
     * 获取昨天23:59:59的时间戳
     */
    public static long getYesterDayDate() {
        String now = format(new Date(), DATE_SMALL_STR);
        now += " 23:59:59";
        return dateToUnixTimestamp(now);
    }

    /**
     * 获取指定日期的零点的时间戳
     */
    public static long getEnactZeroDate(Date date) {
        String now = format(date, DATE_SMALL_STR);
        now += " 00:00:00";
        return dateToUnixTimestamp(now);
    }

    /**
     * 获取指定日期的23:59:59的时间戳
     */
    public static long getEnactDate(Date date) {
        String now = format(date, DATE_SMALL_STR);
        now += " 23:59:59";
        return dateToUnixTimestamp(now);
    }

    /**
     * 获取指定日期与当天的相差天数
     */
    public static long daysBetween(Date before) {
        return daysBetween(getTime(), before);
    }

    /**
     * 获取两个时间相差天数
     *
     * @param now    新时间
     * @param before 旧时间
     * @return
     */
    public static long daysBetween(Date now, Date before) {
        long difference = (now.getTime() - before.getTime()) / 86400000;
        return Math.abs(difference);
    }

    public static void main(String[] args) {
        System.out.println(getYesterDayUnixTimestamp());
    }
}
