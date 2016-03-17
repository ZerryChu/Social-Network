package group.zerry.api_server.utils;

import java.util.List;

import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.CityBlockSimilarity;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.model.JDBCDataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

/**
 *  @content mahout itemBasedRecommender 
 */
public class Recommender {
	private static JDBCDataModel model ;
	
	public void init() {
		try {
			model = getJDBCDataModel("localhost", "root", "486579", "social network");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public MySQLJDBCDataModel getJDBCDataModel(String serverName, String username, String pwd, String database) throws ClassNotFoundException {
		MysqlDataSource dataSource = new MysqlDataSource();
		//Class.forName("com.mysql.jdbc.Driver"); 
		dataSource.setServerName(serverName);
		dataSource.setUser(username);
		dataSource.setPassword(pwd);
		dataSource.setDatabaseName(database);
		return new MySQLJDBCDataModel(dataSource, "label_heat", "user_id", "label_id", "times", null);
	}
	
	public List<RecommendedItem> myItemBasedRecommender(long userID, int size) {
		List<RecommendedItem> recommendedItems = null;
		try {
           // DataModel model = new FileDataModel(new File("/Users/zhuzirui/Documents/workspace/LabelBasedRS/RS/WebContent/label_preferences.csv"));//构造数据模型，File-based  
            ItemSimilarity similarity = new PearsonCorrelationSimilarity(model);
			org.apache.mahout.cf.taste.recommender.Recommender recommender = new GenericItemBasedRecommender(model, similarity);
            recommendedItems = recommender.recommend(userID, size);
		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return recommendedItems;
	}
	
	public long[] getRecommendedUser(long userID, int size) {
		try {
			UserSimilarity us = new  CityBlockSimilarity(model);
			UserNeighborhood unb = new NearestNUserNeighborhood(size, us, model);
			return unb.getUserNeighborhood(userID);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public long[] recommend(int userId, int recommendCount) {
		Recommender rs = new Recommender();
		List<RecommendedItem> recommendedItems = rs.myItemBasedRecommender(userId, recommendCount);
		long[] labels = new long[recommendedItems.size()];
		for (int i = 0;i < recommendedItems.size(); i++)
			labels[i] = recommendedItems.get(i).getItemID();
		return labels;
	}
	
	/*
	TEST
	
    public static void main(String[] args) {
		LabelRecommender lr = new LabelRecommender();
		long[] nums = lr.recommend(2, 5);
		for (int i = 0;i < nums.length; i++)
			System.out.println("id: " + nums[i]);
			
		LabelRecommender lr = new LabelRecommender();
		long[] users = lr.getRecommendedUser(1, 3);
		for (int i = 0;i < users.length; i++) {
			System.out.println(users[i]);
		}
	}
	*/
	
}

