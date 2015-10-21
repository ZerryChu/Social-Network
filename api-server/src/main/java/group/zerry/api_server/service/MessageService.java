package group.zerry.api_server.service;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.enumtypes.MessageStatusEnum;

public interface MessageService {
	public MessageStatusEnum send_message(String username, String content, int type);
	
	public MessageStatusEnum delete_message(String username, int id);
	
	public Message[] show_messages(String username, int type);
	
	public Message[] show_ownMessages(String nickname);

	public Message[] show_announcements();

	public MessageStatusEnum addRepost(String username, int id);  //转发
	
	public MessageStatusEnum addComment(String username, String content, int id); //评论
	
	public MessageStatusEnum addSupport(String username, int id); //点赞
	
}
