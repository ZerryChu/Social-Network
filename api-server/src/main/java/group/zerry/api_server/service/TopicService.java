package group.zerry.api_server.service;

import group.zerry.api_server.entity.Topic;
import group.zerry.api_server.entity.TopicComment;

public interface TopicService {
	public Topic[] showTopicsByType(int id, int page);
	
	public Topic showTopicById(int id);
	
	public TopicComment[] showCommentsById(int id, int page);
	
	public Topic showTopicByName(String name);

}
