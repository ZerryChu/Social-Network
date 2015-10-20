package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.entity.Message;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.service.SearchService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value="SearchService")
public class SearchServiceImpl implements SearchService{

	@Autowired
	HttpTarget    httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;
	
	public String searchUsersLikeNickname(String nickname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/send";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("nickname", nickname);		
		return fetchURLTool.doPost(url, paramsMap);
	}

	public String searchMessagesLikeContent(String content) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/send";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("content", content);
		return fetchURLTool.doPost(url, paramsMap);
	}

}
