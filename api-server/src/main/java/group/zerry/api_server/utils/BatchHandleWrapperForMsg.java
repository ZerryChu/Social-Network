package group.zerry.api_server.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

import org.apache.ibatis.annotations.Update;
import org.apache.taglibs.standard.tag.common.core.CatchTag;

import com.mysql.jdbc.Statement;

public final class BatchHandleWrapperForMsg {

	private LinkedBlockingQueue<Object> queue;
	private boolean running = true;
	private ExecutorService exec;
	private int batchSize = 10; // 根据用户数量、用户操作频繁程度增加
	private int queueSize = Integer.MAX_VALUE;
	private int timeout = 5000;
	private int taskCount = 1;
	private BatchHandler<Object> batchHandler;
	private EnqueueHandler<Object> enqueueHandler;

	public BatchHandleWrapperForMsg() throws Exception {
		BatchHandler<Object> batchHandler = new BatchHandler<Object>() {
			@Override
			public void handle(List<Object> list, Runnable task) {
				HashMap<Long, Integer> map = new HashMap<Long, Integer>();
				for (int i = 0; i < list.size(); i++) {
					long key = Long.parseLong(String.valueOf(list.get(i)));
					//int count = map.get(key);
					if (map.get(key) == null) {
						map.put(key, 1);
					} else {
						int count = map.get(key);
						map.put(key, count + 1);
					}
				}
				for (int i = 0; i < list.size(); i++) {
					int num = map.get(Long.parseLong(String.valueOf(list.get(i))));
					if (num == 0) {
						continue;
					} else {
						// sql请求
						String sql = "update weibo_heat set times=times+";
						sql += num;
						sql += " where id=";
						sql += list.get(i);
						excuteSQL(sql);
						map.put(Long.parseLong(String.valueOf(list.get(i))), 0);
					}
				}
				// 发送sql请求
			}
		};
		

		EnqueueHandler<Object> enqueueHandler = new EnqueueHandler<Object>() {
			@Override
			public void handle(BlockingQueue<Object> queue, Object obj) {
				queue.offer(obj);
			}
		};

		this.batchHandler = batchHandler;
		this.enqueueHandler = enqueueHandler;
		start();
	}

	public BatchHandleWrapperForMsg batchSize(int size) {
		if (size > 0) {
			this.batchSize = size;
		}
		return this;
	}

	public BatchHandleWrapperForMsg queueSize(int size) {
		if (size > 0) {
			this.queueSize = size;
		}
		return this;
	}

	public BatchHandleWrapperForMsg timeout(int timeout, TimeUnit unit) {
		if (timeout > 0) {
			this.timeout = (int) unit.toMillis(timeout);
		}
		return this;
	}

	public BatchHandleWrapperForMsg taskCount(int count) {
		if (count > 0) {
			this.taskCount = count;
		}
		return this;
	}

	public BatchHandleWrapperForMsg enqueueHandler(EnqueueHandler<Object> enqueueHandler) {
		this.enqueueHandler = enqueueHandler;
		return this;
	}

	public BatchHandleWrapperForMsg start() {
		check();
		queue = new LinkedBlockingQueue<Object>(queueSize);
		exec = Executors.newFixedThreadPool(taskCount);
		BatchTask task = new BatchTask();
		for (int i = 0; i < taskCount; i++) {
			exec.execute(task);
		}
		return this;
	}

	private void check() {
		if (batchHandler == null) {
			throw new RuntimeException("BatchHandler不能为空");
		}
	}

	private BatchHandleWrapperForMsg(BatchHandler<Object> batchHandler) {
		this.batchHandler = batchHandler;
		check();
	}

	/**
	 * 队列大小为{@link Integer#MIN_VALUE}的批量操作包装器
	 * 
	 * @param batchHandler
	 *            批量处理器
	 * @param batchSize
	 *            批量操作上限
	 * @param timeoutMs
	 *            超时时间(单位：毫秒)
	 * @param taskCount
	 *            处理线程数量
	 */
	public BatchHandleWrapperForMsg(BatchHandler<Object> batchHandler, int batchSize, int timeoutMs, int taskCount) {
		this(batchHandler, Integer.MAX_VALUE, batchSize, timeoutMs, taskCount);
	}

	/**
	 * 具有指定队列大小的批量操作包装器
	 * 
	 * @param batchHandler
	 *            批量处理器
	 * @param queueSize
	 *            队列大小
	 * @param batchSize
	 *            批量操作大小
	 * @param timeoutMs
	 *            取出元素超时时间(单位：毫秒)
	 * @param taskCount
	 *            处理线程数量
	 */
	public BatchHandleWrapperForMsg(BatchHandler<Object> batchHandler, int queueSize, int batchSize, int timeoutMs,
			int taskCount) {
		this(batchHandler, queueSize, batchSize, timeoutMs, taskCount, null);
	}

	/**
	 * 具有指定队列大小和入队失败处理器的批量操作包装器
	 * 
	 * @param batchHandler
	 *            批量处理器
	 * @param queueSize
	 *            队列大小
	 * @param batchSize
	 *            批量操作大小
	 * @param timeoutMs
	 *            超时时间(单位：毫秒)
	 * @param taskCount
	 *            处理线程数量
	 * @param enqueueHandler
	 *            入队处理器
	 */
	public BatchHandleWrapperForMsg(BatchHandler<Object> batchHandler, int queueSize, int batchSize, int timeoutMs,
			int taskCount, EnqueueHandler<Object> enqueueHandler) {
		if (batchHandler == null || batchSize < 1 || timeoutMs < 0 || taskCount < 0) {
			throw new RuntimeException("参数错误：BatchHandler不能为null，batchSize必须大于0，timeout必须大于0，taskCount必须大于0");
		}
		this.queue = new LinkedBlockingQueue<Object>(queueSize);
		this.batchSize = batchSize;
		this.timeout = timeoutMs;
		this.batchHandler = batchHandler;
		this.enqueueHandler = enqueueHandler;
		exec = Executors.newFixedThreadPool(taskCount);
		BatchTask task = new BatchTask();
		for (int i = 0; i < taskCount; i++) {
			exec.execute(task);
		}
	}

	public void add(Object data) {
		try {
			if (enqueueHandler != null) {
				enqueueHandler.handle(queue, data);
			} else {
				queue.put(data);
			}
		} catch (Exception e) {
			// TODO
		}
	}

	public void add(Object data, int timeoutMs) {
		try {
			if (enqueueHandler != null) {
				enqueueHandler.handle(queue, data);
			} else {
				if (!queue.offer(data, timeoutMs, TimeUnit.MILLISECONDS)) {
					// TODO
				}
			}
		} catch (Exception e) {
			// TODO
		}
	}

	public void stop() {
		running = false;
		exec.shutdownNow();
	}

	/**
	 * @author lzy 批量处理器
	 */
	public static interface BatchHandler<E> {
		/**
		 * 批量方法
		 * 
		 * @param list
		 *            待处理的数据列表
		 * @param task
		 *            负责处理数据的线程
		 */
		void handle(List<E> list, Runnable task);
	}

	/**
	 * @author lzy 数据入队处理器
	 */
	public static interface EnqueueHandler<E> {
		/**
		 * 处理方法
		 * 
		 * @param queue
		 *            保存数据的队列
		 * @param obj
		 *            待保存数据
		 * @param e
		 *            异常
		 */
		void handle(BlockingQueue<E> queue, E obj);
	}

	/**
	 * @author lzy 批量处理任务
	 */
	private class BatchTask implements Runnable {

		@Override
		public void run() {
			ArrayList<Object> list = new ArrayList<Object>(batchSize);
			while (running && !Thread.interrupted()) {
				try {
					Object data = queue.poll(timeout, TimeUnit.MILLISECONDS);
					if (data == null) {
						batch(list);
					} else {
						list.add(data);
						if (list.size() == batchSize) {
							batch(list);
						}
					}
				} catch (Exception e) {
					// TODO
				}
			}
			// 停止处理后，批量处理内存中存在的数据
			while (queue.size() > 0) {
				Object data = queue.poll();
				if (data != null) {
					list.add(data);
					if (list.size() == batchSize) {
						batch(list);
					}
				}
			}
			batch(list);
		}

		private void batch(ArrayList<Object> list) {
			if (list.size() > 0) {
				try {
					batchHandler.handle(list, this);
				} finally {
					// 处理数据后，不管成功与否，均清空当前数据
					list.clear();
				}
			}
		}
	}

	public void excuteSQL(String sql) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/social network", "root", "486579");
			java.sql.Statement stmt = conn.createStatement();
			int count = stmt.executeUpdate(sql);
			// 返回值处理
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/*
	 * public static void main(String[] args) {
	 * 
	 * //final BatchHandleWrapper<Object> bhw =
	 * BatchHandleWrapper.batchHandler(batchHandler) //.batchSize(10)
	 * //.timeout(5, TimeUnit.SECONDS) //.taskCount(1)
	 * //.enqueueHandler(enqueueHandler) // ;
	 * 
	 * //Thread t = new Thread(){ // public void run() { BatchHandleWrapper bhw
	 * = new BatchHandleWrapper(); for(int i=1;i<=150;i++){ bhw.add("第"+i,50); }
	 * System.err.println("我放完了"); bhw.stop(); // }; //}; // t.start(); }
	 */
}