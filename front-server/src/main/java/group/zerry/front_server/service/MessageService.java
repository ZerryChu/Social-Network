package group.zerry.front_server.service;

import org.springframework.web.multipart.MultipartFile;

public interface MessageService {
	
	public boolean send_message(String username, String userToken, String content, int type, MultipartFile pic, String label);
	
	public boolean send_comment(String username, String userToken, int id, String content);
	
	//to extend: delete type2 mes
	public boolean delete_message(String username, String userToken, int id);
	
	public boolean add_repost(String username, String userToken, String content, int id);
	
	public int addSupportTimes(String username, String userToken, int id);
	public int decreaseSupportTimes(String username, String userToken, int id);
	
	public String show_messages(String username, String userToken, int page);
	
	public String show_messagesByLabel(String username, String userToken, int label_id, int page);
	
	public String show_messagesByLabelAndHeat(String username, String userToken, int label_id, int page);
	
	public String show_userOwnMessages(String nickname, int page);
	
	public String show_announcement();
	
	public String show_messageById(String username, String userToken, int message_id);
	
	public String judgeIfSupport(String username, int message_id, String userToken);
	
	public String showWeiboByTopicId(String username, int topic_id, int page);
	
	public boolean send_topicWeibo(String username, String userToken, String content, MultipartFile pic, int topic_id);
}
