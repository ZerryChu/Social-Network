package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.Message;

@Repository
public interface MessageDao {
	public void addMessage(Message message);
	
	public Message getMessageById(int id);
	
	public Message[] getMessages(String[] friend);
	
	public Message[] getMessagesByLabelAndHeat(int label_id);
	
	public Message[] getMessagesByLabel(int label_id);
	
	public Message[] getOwnMessages(String nickname);
	
	public Message[] getAnnouncements();
	
	public Message[] selectWeiboByTopicName(String name);

	public void deleteMessageById(int id);
	
	public void addRepost(Message message);
	
	public void addRepostTimes(int id);

	public void addSupportInfo(int id, String username);
	
	public void decreaseSupportInfo(int id, String username);
	
	public Message[] searchMessagesLikeContent(String content);

	/**
	 * 
	 * @param username
	 * @param id
	 * @return 查询结果条数
	 */
	public Count findIfSupportedByUsername(String username, int id);
}
