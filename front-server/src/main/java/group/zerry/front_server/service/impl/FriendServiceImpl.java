package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.service.FriendService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "FriendService")
public class FriendServiceImpl implements FriendService{

	@Autowired
	HttpTarget    httpTarget;
	
	@Autowired
	FetchUrlTools fetchUrlTool;
	
	@Override
	public String showFriendsByGroupname(String username, String userToken, String groupname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/show/friends";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("groupname", groupname);
		return fetchUrlTool.doPost(url, paramsMap);
	}

	@Override
	public String showGroupsByUsername(String username, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/show/groups";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		return fetchUrlTool.doPost(url, paramsMap);
	}

}
