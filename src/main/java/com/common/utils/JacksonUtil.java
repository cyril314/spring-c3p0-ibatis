package com.common.utils;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

/**
 * @AUTO 基于Jackson的JSON工具类
 * @Author AIM
 * @DATE 2019/4/11
 */
public class JacksonUtil {

	private static ObjectMapper mapper = new ObjectMapper();

	public static String bean2Json(Object obj) {
		try {
			String result = mapper.writeValueAsString(obj);
			return result;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static <T> T json2Bean(String jsonStr, Class<T> objClass) {
		try {
			return mapper.readValue(jsonStr, objClass);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
