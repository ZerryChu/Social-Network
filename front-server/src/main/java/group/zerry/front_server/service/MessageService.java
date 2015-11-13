package group.zerry.front_server.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;


public interface MessageService {
	
	public boolean send_message(HttpServletRequest request, String username, String userToken, String content, int type, MultipartFile pic);
	
	public boolean send_comment(String username, String userToken, int id, String content);
	
	//to extend: delete type2 mes
	public boolean delete_message(String username, String userToken, int id);
	
	public boolean add_repost(String username, String userToken, String content, int id);
	
	public int addSupportTimes(String username, String userToken, int id);
	public int decreaseSupportTimes(String username, String userToken, int id);
	
	public String show_messages(String username, String userToken, int page);
	
	public String show_userOwnMessages(String nickname, int page);
	
	public String show_announcement();
	
	public String show_messageById(String username, String userToken, int message_id);
	
	public String judgeIfSupport(String username, int message_id, String userToken);
}
