package com.common.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Semaphore;

public class JdbcUtil {

	private static final String driverClassName = "com.mysql.jdbc.Driver"; // 连接类型
	private static String URL = "jdbc:mysql://192.168.28.128:3306/census?rewriteBatchedStatements=true&useSSL=false";
	private static String USERNAME = "root";
	private static String PASSWORD = "root";
	private static final int MAX_MYSQL_SIZE = 10;
	private static ConcurrentLinkedQueue<Connection> pools = new ConcurrentLinkedQueue<>();
	private static Semaphore semaphore = new Semaphore(MAX_MYSQL_SIZE);

	static {
		Properties properties = new Properties();
		try (InputStream ism = JdbcUtil.class.getClassLoader().getResourceAsStream("jdbc.properties")) {
			properties.load(ism);
			URL = properties.getProperty("jdbc.url");
			USERNAME = properties.getProperty("jdbc.username");
			PASSWORD = properties.getProperty("jdbc.password");
		} catch (Exception e) {
			System.out.println("Failed to read configuration file jdbc.properties");
		}
		try {
			Class.forName(driverClassName);
			for (int i = 0; i < MAX_MYSQL_SIZE; i++) {
				pools.add(DriverManager.getConnection(String.format("%s&useServerPrepStmts=false&rewriteBatchedStatements=true", URL), USERNAME, PASSWORD));
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			System.out.println(String.format("Number of connection pools created: %s", pools.size()));
		}
	}

	public static Connection getConn() {
		Connection conn = null;
		while (true) {
			try {
				if (semaphore.tryAcquire()) {
					conn = pools.poll();
					break;
				} else {
					Thread.sleep(500);
					semaphore.release();
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}

	public static void releaseConn(Connection conn) {
		if (conn != null) {
			pools.offer(conn);
			semaphore.release(); // 释放连接时释放信号量
		}
	}

	/**
	 * 插入数据
	 * 
	 * @param sql
	 * @param data
	 */
	public static void insertData(String sql, ArrayList<Object> data) {
		Connection conn = getConn();
		if (conn != null) {
			long begin = System.currentTimeMillis();
			try (PreparedStatement pst = conn.prepareStatement(sql)) {
				if (data.size() > 0) {
					int i = 1;
					for (Object obj : data) {
						pst.setObject(i, obj);
						i++;
					}
				}
				pst.executeUpdate();
				long diffTime = (System.currentTimeMillis() - begin) / 1000;
				System.out.println(String.format("线程ID：%s 结束时间为： %s秒", Thread.currentThread().getId(), diffTime));
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				releaseConn(conn);
				data = null;
			}
		}
	}

	/**
	 * 批量插入
	 * 
	 * @param sql
	 * @param dataList
	 */
	public static void batchInsert(String sql, ArrayList<ArrayList<Object>> dataList) {
		Connection conn = getConn();
		if (conn != null) {
			long begin = System.currentTimeMillis();
			try (PreparedStatement pst = conn.prepareStatement(sql)) {
				conn.setAutoCommit(false); // 设置手动提交
				int batchSize = 10000; // 批量插入的每组数据大小
				int count = 1;
				for (ArrayList<Object> data : dataList) {
					if (data.size() > 0) {
						int i = 1;
						for (Object obj : data) {
							pst.setObject(i, obj);
							i++;
						}
					}
					pst.addBatch();
					if (count % batchSize == 0) {
						pst.executeBatch();
						pst.clearBatch();
						count = 0;
					}
					count++;
				}
				pst.executeBatch();
				pst.clearBatch();
				pst.close();
				conn.commit();
				System.out.println(String.format("线程ID：%s 结束时间为： %s秒", Thread.currentThread().getId(), (System.currentTimeMillis() - begin) / 1000));
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				releaseConn(conn);
				dataList.clear();
				System.gc();
			}
		}
	}

	public static String getUUID() {
		return UUID.randomUUID().toString().replace("-", "");
	}

	public static void main(String[] args) throws InterruptedException {
		final String sql = "INSERT IGNORE INTO `domain_c2`(`id`,`ioc_value`,`ioc_type`,`score`,`source_ref`,`category`,`first_time`,`first_time_long`,`last_time`,`last_time_long`) VALUES(?,?,?,?,?,?,?,?,?,?)";
		ArrayList<ArrayList<Object>> dataList = new ArrayList<>();
		boolean toBatch = true;
		ExecutorService executorService = Executors.newFixedThreadPool(MAX_MYSQL_SIZE);
		for (int i = 0; i < 12500000; i++) {
			ArrayList<Object> data = new ArrayList<>();
			data.add(getUUID());
			data.add("xxxx.com");
			data.add("feed_domain");
			data.add("70.00");
			data.add("xxxx");
			data.add("c2");
			data.add("2016-05-28T16:00:00Z");
			data.add("1464451200000");
			data.add("2016-05-28T16:00:00Z");
			data.add("1464451200000");
			if (toBatch) {
				dataList.add(data);
				if (dataList.size() == 100000) {
					final ArrayList<ArrayList<Object>> finalDataList = new ArrayList<>(dataList); // 创建副本以防止并发修改
					final int j = i;
					executorService.submit(new Runnable() {
						@Override
						public void run() {
							System.out.println(String.format("线程ID：%s 执行任务循环次数: %s", Thread.currentThread().getId(), j));
							JdbcUtil.batchInsert(sql, finalDataList);
						}
					});
					dataList.clear();
				}
			} else {
				JdbcUtil.insertData(sql, data);
			}
		}
		executorService.shutdown(); // 关闭线程池
		System.out.println("Data inserted successfully.");
	}
}
