package group.zerry.api_server.utils;

import java.security.interfaces.RSAKey;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
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

public final class BatchHandleWrapperForLabel {

	private LinkedBlockingQueue<Object> usr_queue;
	private LinkedBlockingQueue<Object> lbl_queue;
	private boolean running = true;
	private ExecutorService exec;
	private int batchSize = 10; // 根据用户数量、用户操作频繁程度增加
	private int queueSize = Integer.MAX_VALUE;
	private int timeout = 5000;
	private int taskCount = 1;
	private BatchHandler<Object> batchHandler;
	private EnqueueHandler<Object> enqueueHandler;

	public BatchHandleWrapperForLabel() throws Exception {
		BatchHandler<Object> batchHandler = new BatchHandler<Object>() {
			@Override
			public void handle(List<Object> list_usrId, List<Object> list_lblId, Runnable task) { // 需要算法关联三个参数
				for (int i = 0; i < list_usrId.size(); i++) {
					String sql1 = "select count(*) from label_heat where user_id=";
					sql1 += String.valueOf(list_usrId.get(i));
					sql1 += " and label_id=";
					sql1 += String.valueOf(list_lblId.get(i));
					int num = excuteQuery(sql1);
					System.out.println(sql1);
					String sql2 = null;
					if (num == 0) {
						sql2 = "insert into label_heat values(";
						sql2 += String.valueOf(list_usrId.get(i));
						sql2 += ",";
						sql2 += String.valueOf(list_lblId.get(i));
						sql2 += ",1)";
					} else if (num == 1) {
						sql2 = "update label_heat set times=times+1";
						sql2 += " where user_id=";
						sql2 += String.valueOf(list_usrId.get(i));
						sql2 += " and label_id=";
						sql2 += String.valueOf(list_lblId.get(i));
					}
					excuteUpdate(sql2);
				}
				
				/*
				 * on duplicate key update
				 */
				// 发送sql请求
			}
		};

		EnqueueHandler<Object> enqueueHandler = new EnqueueHandler<Object>() {
			@Override
			public void handle(BlockingQueue<Object> queue1, Object obj1, BlockingQueue<Object> queue2, Object obj2) {
				queue1.offer(obj1);
				queue2.offer(obj2);
			}
		};

		this.batchHandler = batchHandler;
		this.enqueueHandler = enqueueHandler;
		start();
	}

	public BatchHandleWrapperForLabel batchSize(int size) {
		if (size > 0) {
			this.batchSize = size;
		}
		return this;
	}

	public BatchHandleWrapperForLabel queueSize(int size) {
		if (size > 0) {
			this.queueSize = size;
		}
		return this;
	}

	public BatchHandleWrapperForLabel timeout(int timeout, TimeUnit unit) {
		if (timeout > 0) {
			this.timeout = (int) unit.toMillis(timeout);
		}
		return this;
	}

	public BatchHandleWrapperForLabel taskCount(int count) {
		if (count > 0) {
			this.taskCount = count;
		}
		return this;
	}

	public BatchHandleWrapperForLabel enqueueHandler(EnqueueHandler<Object> enqueueHandler) {
		this.enqueueHandler = enqueueHandler;
		return this;
	}

	public BatchHandleWrapperForLabel start() {
		check();
		usr_queue = new LinkedBlockingQueue<Object>(queueSize);
		lbl_queue = new LinkedBlockingQueue<Object>(queueSize);
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

	private BatchHandleWrapperForLabel(BatchHandler<Object> batchHandler) {
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
	public BatchHandleWrapperForLabel(BatchHandler<Object> batchHandler, int batchSize, int timeoutMs, int taskCount) {
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
	public BatchHandleWrapperForLabel(BatchHandler<Object> batchHandler, int queueSize, int batchSize, int timeoutMs,
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
	public BatchHandleWrapperForLabel(BatchHandler<Object> batchHandler, int queueSize, int batchSize, int timeoutMs,
			int taskCount, EnqueueHandler<Object> enqueueHandler) {
		if (batchHandler == null || batchSize < 1 || timeoutMs < 0 || taskCount < 0) {
			throw new RuntimeException("参数错误：BatchHandler不能为null，batchSize必须大于0，timeout必须大于0，taskCount必须大于0");
		}
		this.usr_queue = new LinkedBlockingQueue<Object>(queueSize);
		this.lbl_queue = new LinkedBlockingQueue<Object>(queueSize);
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

	public void add(Object usr_id, Object lbl_id) {
		try {
			if (enqueueHandler != null) {
				enqueueHandler.handle(usr_queue, usr_id, lbl_queue, lbl_id);
			} else {
				usr_queue.put(usr_id);
				lbl_queue.put(lbl_id);
			}
		} catch (Exception e) {
			// TODO
		}
	}

	public void add(Object usr_id, Object lbl_id, int timeoutMs) {
		try {
			if (enqueueHandler != null) {
				enqueueHandler.handle(usr_queue, usr_id, lbl_queue, lbl_id);
			} else {
				usr_queue.offer(usr_id, timeoutMs, TimeUnit.MILLISECONDS);
				lbl_queue.offer(lbl_id, timeoutMs, TimeUnit.MILLISECONDS);
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
		void handle(List<E> list, List<E> _list, Runnable task);
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
		void handle(BlockingQueue<E> queue1, E obj1, BlockingQueue<E> queue2, E obj2);

	}

	/**
	 * @author lzy 批量处理任务
	 */
	private class BatchTask implements Runnable {

		@Override
		public void run() {
			ArrayList<Object> list_usrId = new ArrayList<Object>(batchSize);
			ArrayList<Object> list_lblId = new ArrayList<Object>(batchSize);
			while (running && !Thread.interrupted()) { //改
				try {
					Object usr_id = null;
					while(usr_id == null) {
						usr_id = usr_queue.poll(timeout, TimeUnit.MILLISECONDS);
						Thread.sleep(100);
					}
					Object lbl_id = null;
					while(lbl_id == null) {
						lbl_id = lbl_queue.poll(timeout, TimeUnit.MILLISECONDS);
						Thread.sleep(100);
					}
					//if (usr_id == null) {
					//	batch(list_usrId, list_lblId);
					//} else {
						list_usrId.add(usr_id);
						list_lblId.add(lbl_id);
						if (list_usrId.size() == batchSize) {
							batch(list_usrId, list_lblId);
						}
					//}
				} catch (Exception e) {
					// TODO
				}
			}
			// 停止处理后，批量处理内存中存在的数据
			while (usr_queue.size() > 0) {
				Object usr_id = usr_queue.poll();
				Object lbl_id = lbl_queue.poll();
				if (usr_id != null) {
					list_usrId.add(usr_id);
					list_lblId.add(lbl_id);
					if (list_usrId.size() == batchSize) {
						batch(list_usrId, list_lblId);
					}
				}
			}
			batch(list_usrId, list_lblId);
		}

		private void batch(ArrayList<Object> list_usrId, ArrayList<Object> list_lblId) {
			if (list_usrId.size() > 0) {
				try {
					batchHandler.handle(list_usrId, list_lblId, this);
				} finally {
					// 处理数据后，不管成功与否，均清空当前数据
					list_usrId.clear();
					list_lblId.clear();
				}
			}
		}
	}

	public int excuteQuery(String sql) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/social network", "root", "486579");
			java.sql.Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			int num = rs.getInt(1);
			rs.close();
			return num;
			// 返回值处理
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
	
	public void excuteUpdate(String sql) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/social network", "root", "486579");
			java.sql.Statement stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			// 返回值处理
		} catch (Exception e) {
			e.printStackTrace();
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