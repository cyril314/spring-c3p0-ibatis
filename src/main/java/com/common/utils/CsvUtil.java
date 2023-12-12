package com.common.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Date;
import java.util.List;

/**
 * @AUTO CSV工具类
 * @FILE CsvUtil.java
 * @DATE 2021年3月31日 下午6:11:30
 * @Author Fit
 * @Version 1.0
 */
public class CsvUtil {

	public static final String UTF8 = "utf-8";
	public static final String GBK = "gbk";
	public static final String ENCODE = GBK;

	/**
	 * CSV文件生成方法
	 * 
	 * @param head
	 *            文件头部数据
	 * @param dataList
	 *            数据
	 * @param outFilePath
	 *            输出路径
	 * @param filename
	 *            文件名
	 */
	public static void createCSVFile(List<String> head, List<List<String>> dataList, String outFilePath, String filename) {
		try {
			File csvFile = null;
			csvFile = new File(outFilePath + File.separator + filename + ".csv", ENCODE);
			File parent = csvFile.getParentFile();
			if (parent != null && !parent.exists()) {
				parent.mkdirs();
			}
			csvFile.createNewFile();
			// GB2312使正确读取分隔符","
			createListToCSV(new FileOutputStream(csvFile), head, dataList);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param outputStream
	 *            输出字节流
	 * @param head
	 *            文件头部数据
	 * @param dataList
	 *            数据
	 */
	public static void createListToCSV(OutputStream ops, List<String> head, List<List<String>> dataList) {
		BufferedWriter csvWtriter = null;
		try {
			csvWtriter = new BufferedWriter(new OutputStreamWriter(ops, ENCODE), 1024);
			// 写入文件头部
			if (!(head == null || head.size() == 0)) {
				writeRow(head, csvWtriter);
			}
			// 写入文件内容
			for (List<String> row : dataList) {
				writeRow(row, csvWtriter);
			}
			csvWtriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				csvWtriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @param outputStream
	 *            输出字节流
	 * @param head
	 *            文件头部数据
	 * @param dataList
	 *            数据
	 */
	public static <T> void createBeanToCSV(OutputStream ops, List<String> head, List<T> dataList, Class<T> clazz) {
		BufferedWriter csvWtriter = null;
		try {
			csvWtriter = new BufferedWriter(new OutputStreamWriter(ops, ENCODE), 1024);
			if (!(head == null || head.size() == 0)) {
				// 写入文件头部
				writeRow(head, csvWtriter);
			}
			// 写入文件内容
			for (T row : dataList) {
				beanToStr(row, csvWtriter);
			}
			csvWtriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} finally {
			try {
				csvWtriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 写入文件头部
	 */
	private static void writeRow(List<String> row, BufferedWriter csvWriter) throws IOException {
		StringBuffer sb = new StringBuffer();
		for (String data : row) {
			sb.append("\"").append(data).append("\",");
		}
		sb.deleteCharAt(sb.length() - 1);
		csvWriter.write(new String(sb.toString()));
		csvWriter.newLine();
	}

	private static void beanToStr(Object obj, BufferedWriter csvWriter) throws IllegalAccessException, IOException {
		StringBuffer buffer = new StringBuffer();
		Class<? extends Object> clazz = obj.getClass();
		Field[] declaredFields = clazz.getDeclaredFields();
		Field.setAccessible(declaredFields, true);
		for (Field field : declaredFields) {
			if (Modifier.isStatic(field.getModifiers())) {
				continue;// 匹配是否为静态常量
			}
			Object object = field.get(obj);
			if (object == null) {
				continue;
			} else {
				Class<? extends Object> fieldclass = object.getClass();
				String simpleName = fieldclass.getSimpleName();
				if (simpleName.equals("String")) {
					buffer.append(field.get(obj)).append(",");
				} else if (isContains(simpleName)) {
					buffer.append(field.get(obj)).append(",");
				} else if (simpleName.equals("Date")) {
					Date date = (Date) object;
					buffer.append(DateUtils.format(date)).append(",");
				} else {
					continue;
				}
			}
		}
		buffer.deleteCharAt(buffer.length() - 1);
		csvWriter.write(buffer.toString());
		csvWriter.newLine();
	}

	/**
	 * 判断字符串是否符合基础类型名称
	 */
	private static boolean isContains(String simpleName) {
		return simpleName.equals("Boolean") || simpleName.equals("Integer") || simpleName.equals("Double")
				|| simpleName.equals("Float") || simpleName.equals("Long");
	}
}
