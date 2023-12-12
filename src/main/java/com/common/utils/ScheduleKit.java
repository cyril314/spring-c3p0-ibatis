package com.common.utils;

import org.quartz.*;

public class ScheduleKit {

	private final static String JOB_KEY = "JOB_";

	private final static Scheduler scheduler;

	static {
		scheduler = SpringContextUtil.getBean(Scheduler.class);
	}

	public static void create(Long jobId, String cronExpression, Class<? extends Job> jobClass) {
		if (scheduler != null) {
			try {
				JobKey jobKey = getJobKey(jobId);
				// 构建job信息
				JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(jobKey).build();
				// 表达式调度构建器(即任务执行的时间)
				CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);
				// 按新的cronExpression表达式构建一个新的trigger
				CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(getTriggerKey(jobId)).withSchedule(scheduleBuilder).build();
				// 传入参数
				scheduler.scheduleJob(jobDetail, trigger);
				System.out.println(String.format("%s ----- %s 创建定时任务成功!", DateUtils.getNowTime(), jobKey.getName()));
				// 启动调度器
				if (!scheduler.isShutdown()) {
					scheduler.start();
				}
			} catch (SchedulerException e) {
				throw new RuntimeException("创建定时任务失败");
			}
		}
	}

	public static boolean start() {
		if (scheduler != null) {
			try {
				if (!scheduler.isShutdown()) {
					scheduler.start();
					return true;
				}
			} catch (SchedulerException e) {
				throw new RuntimeException("启动定时任务失败");
			}
		}
		return false;
	}

	public static void pause(Long jobId) {
		if (scheduler != null) {
			try {
				scheduler.pauseJob(getJobKey(jobId));
			} catch (SchedulerException e) {
				throw new RuntimeException("暂停定时任务失败");
			}
		}
	}

	public static void resume(Long jobId) {
		try {
			scheduler.resumeJob(getJobKey(jobId));
		} catch (SchedulerException e) {
			throw new RuntimeException("恢复启动定时任务失败");
		}
	}

	public static void update(Long jobId, String cronExpression) {
		try {
			JobKey jobKey = getJobKey(jobId);
			TriggerKey triggerKey = getTriggerKey(jobId);
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			// 按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
			System.out.println(String.format("%s ----- %s 更新定时任务成功!", DateUtils.getNowTime(), jobKey.getName()));
		} catch (SchedulerException e) {
			throw new RuntimeException("更新定时任务失败");
		}
	}

	public static void delete(Long jobId) {
		try {
			scheduler.pauseTrigger(getTriggerKey(jobId));
			scheduler.unscheduleJob(getTriggerKey(jobId));
			scheduler.deleteJob(getJobKey(jobId));
		} catch (SchedulerException e) {
			throw new RuntimeException("删除定时任务失败");
		}
	}

	public static boolean checkExists(Long jobId) {
		try {
			return scheduler.checkExists(getJobKey(jobId));
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static JobKey getJobKey(Long jobId) {
		return JobKey.jobKey(JOB_KEY + jobId);
	}

	public static TriggerKey getTriggerKey(Long jobId) {
		return TriggerKey.triggerKey(JOB_KEY + jobId);
	}
}
