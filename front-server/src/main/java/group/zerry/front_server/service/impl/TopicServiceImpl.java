package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.service.TopicService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service("TopicService")
public class TopicServiceImpl implements TopicService {

	@Autowired
	HttpTarget httpTarget;
	
	@Autowired
	FetchUrlTools fetchURlTool;
	
	@Override
	public String showTopicsByType(int id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "topic/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("id", String.valueOf(id));
		paramsMap.put("page", String.valueOf(page));
		return fetchURlTool.doPost(url, paramsMap);
	}

	@Override
	public String showTopicById(int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "topic/show_topic";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("id", String.valueOf(id));
		return fetchURlTool.doPost(url, paramsMap);	
	}

	@Override
	public String showCommentsByTopicId(int id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "topic/show_comment";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("id", String.valueOf(id));
		paramsMap.put("page", String.valueOf(page));
		return fetchURlTool.doPost(url, paramsMap);	
	}

	@Override
	public String showTopicByName(String name) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "topic/show_topicByName";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("name", name);
		return fetchURlTool.doPost(url, paramsMap);	
	}
	
	
}
