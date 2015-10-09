package group.zerry.api_server.service;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.enumtypes.MessageStatusEnum;

public interface MessageService {
	public MessageStatusEnum send_message(String username, String content, int type);
	
	public MessageStatusEnum delete_message(int id);
	
	public Message[] show_messages(String nickname, int type);
}
