package group.zerry.front_server.service;


public interface MessageService {
	
	public boolean send_message(String username, String userToken, String content, int type);
	
	public boolean send_comment(String username, String userToken, int id, String content);
	
	public boolean delete_message(String username, String userToken, int id);
	
	public int addSupportTimes(String username, int id);
	
	public String show_messages(String username, String userToken, int type);
	
	public String show_userOwnMessages(String nickname);
	
	public String show_announcement();
	
	public String judgeIfSupport(String username, int message_id, String userToken);
}
