package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.Message;

@Repository
public interface MessageDao {
	public void addMessage(Message message);
	
	public Message getMessageById(int id);
	
	public Message[] getMessages(String[] friend);
	
	public void deleteMessageByID(int id);
	
	/* 获取自己的帖子 */
	//public Message getMessagesByAuthor(String authorName);
}
