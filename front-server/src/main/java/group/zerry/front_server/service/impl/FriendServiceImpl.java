package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
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
	
	//check api
	@Override
	public boolean ifAllowChat(String username, String userToken, String friendNickname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "ifchat";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("friendNickname", friendNickname);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchUrlTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals("1"))
			return true;
		else
			return false;
	}

	@Override
	public boolean judgeIfFriendsOrNot(String username, String targetUsername) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/iffriends";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("targetUsername", targetUsername);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchUrlTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals("1")) {
			return true;
		} else
			return false;
	}

	@Override
	public String showFavoritesNickname(String username, String userToken, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/favorites";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("page", String.valueOf(page));
		return fetchUrlTool.doPost(url, paramsMap);	
	}

	@Override
	public String showFollowersNickname(String username, String userToken, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/followers";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("page", String.valueOf(page));
		return fetchUrlTool.doPost(url, paramsMap);
	}

	@Override
	public String showCommonFriendsByTargetUsername(String username, String userToken, String targetUsername) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "friend/show/common_friends";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("targetUsername", targetUsername);
		return fetchUrlTool.doPost(url, paramsMap);
	}

}
