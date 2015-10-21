package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.Message;

@Repository
public interface MessageDao {
	public void addMessage(Message message);
	
	public Message getMessageById(int id);
	
	public Message[] getMessages(String[] friend);
	
	public Message[] getOwnMessages(String nickname);
	
	public void deleteMessageByID(int id);
	
	public void addRepostTimes(int id);

	public void addCommentTimes(int id);
	
	public void addSupportTimes(int id);

	public Message[] searchMessagesLikeContent(String content);
}
