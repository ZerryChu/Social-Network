package group.zerry.api_server.service;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.Topic;
import group.zerry.api_server.enumtypes.MessageStatusEnum;

public interface MessageService {
	public MessageStatusEnum send_message(String username, String content, int type, String pic, String label);
	
	public MessageStatusEnum delete_message(String username, int id);
	
	public Message[] show_messages(String username, int page);
	
	public Message[] show_messagesByLabel(String username, int label_id, int page);
	
	public Message[] showMessagesByLabelAndHeat(String username, int label_id, int page);

	public Message[] show_ownMessages(String nickname, int page);

	public Message[] show_announcements();

	public Message show_messageById(String username, int message_id);
	
	public boolean judgeIfSupport(String username, int id);
	
	public MessageStatusEnum addRepost(String username, String _content, int id);  //转发
	
	public MessageStatusEnum addComment(String username, String content, int id); //评论
	
	public MessageStatusEnum addSupport(String username, int id); //点赞
	
	public MessageStatusEnum decreaseSupport(String username, int id);
	
	/* Dao层操作频繁，交由队列批量处理，取消此接口
	public void addLabelHeat(String username, long id, int timeoutMS);
	*/
	
	public Message[] showWeiboByTopicId(String username, int topic_id, int page);
	
	public MessageStatusEnum send_topicMessage(String username, String content, String pic, int topic_id);
	
}
