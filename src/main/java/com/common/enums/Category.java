package com.common.enums;

import java.util.HashMap;
import java.util.Map;

/**
 * @AUTO 威胁类型
 * @FILE ThreatType.java
 * @DATE 2021年3月18日 下午5:52:15
 * @Author Fit
 * @Version 2.0
 */
public enum Category {

	phishing("网页仿冒", "phishing", 1), porn("色情", "porn", 2), gambling("赌博", "gambling", 3), hack("黑客", "hack", 4), malware("恶意软件", "malware", 5), ransomware("勒索软件",
			"ransomware", 6), trojan("木马", "trojan", 7), spam("垃圾邮件", "spam", 8), maliciousMail("恶意邮件", "malicious_mail", 9), c2("C&C节点", "c2", 10), botnet("僵尸网络",
			"botnet", 11), scanner("扫描器节点", "scanner", 12), tor("tor节点", "tor", 13), proxy("proxy代理", "proxy", 14), apt("APT情报", "apt", 15), web_trojan("网页放马",
			"web_trojan", 16);

	private String name;
	private String ename;
	private int i;

	private Category(String name, String ename, int i) {
		this.name = name;
		this.ename = ename;
		this.i = i;
	}

	public static Map<String, String> getMaps() {
		Map<String, String> map = new HashMap<String, String>();
		for (Category c : Category.values()) {
			map.put(c.ename, c.name);
		}
		return map;
	}

	public static String getName(int i) {
		for (Category c : Category.values()) {
			if (c.getI() == i) {
				return c.name;
			}
		}
		return null;
	}

	public static String getName(String ename) {
		for (Category c : Category.values()) {
			if (c.getEname().equals("ename")) {
				return c.name;
			}
		}
		return null;
	}

	public String getEname() {
		for (Category c : Category.values()) {
			if (c.getI() == i) {
				return c.ename;
			}
		}
		return null;
	}

	public void setEname(String ename) {
		this.ename = ename;
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
