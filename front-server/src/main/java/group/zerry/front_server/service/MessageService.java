package group.zerry.front_server.service;

import group.zerry.front_server.entity.Message;

public interface MessageService {
	
	public boolean send_message(String username, String content, int type);
	
	public boolean delete_message(String username, int id);
	
	public String show_messages(String nickname, int type, int page);
}
