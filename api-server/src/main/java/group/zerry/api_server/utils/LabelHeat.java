package group.zerry.api_server.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mysql.jdbc.Statement;

public class LabelHeat implements Runnable {
	private static HashMap<Long, Long> map;
	private static List<Long> list;
	
	public List<Long> getLabelList() {
		return list;
	}
	
	public long getHeatByID(long id) {
		return map.get(id);
	}
	
	private void executeSQL() throws Exception {//修改
		map = new HashMap<Long, Long>();
		list = new ArrayList<Long>();
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/social network", "root", "486579");
		Statement stmt = (Statement) conn.createStatement();
		String sql = "SELECT * FROM (SELECT label_id,sum(times) AS times FROM label_heat GROUP BY label_id) AS a ORDER BY times DESC LIMIT 0,10";
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next()) {
			long id = rs.getLong(1);
			long heat = rs.getLong(2);
			list.add(id);
			map.put(id, heat);
		}
		rs.close();
		conn.close();
	}
	
	public void init() {
		LabelHeat lh = new LabelHeat();
		Thread thread = new Thread(lh);
		thread.start();
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			while(true) {
				executeSQL();
				Thread.sleep(600000);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	
}
