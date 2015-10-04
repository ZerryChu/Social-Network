package group.zerry.api_server.service;

import org.springframework.stereotype.Service;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.enumtypes.MessageStatusEnum;

public interface MessageService {
	public MessageStatusEnum send_message(Message message);
	
	public MessageStatusEnum delete_message(int id);
	
	public Message[] show_message(String username, int type, int page);
}
