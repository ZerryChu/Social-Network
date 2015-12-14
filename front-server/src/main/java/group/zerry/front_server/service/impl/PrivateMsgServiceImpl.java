package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.front_server.service.PrivateMsgService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value="PrivateMsgService")
public class PrivateMsgServiceImpl implements PrivateMsgService {

	@Autowired
	HttpTarget    httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;
	
	@Override
	public String getALLPrivateMsgList(String username, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "privateMsg/getInfo";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);		
		paramsMap.put("userToken", userToken);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String getMsg(String username, String userToken, String targetUsername) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "privateMsg/getMsg";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);		
		paramsMap.put("userToken", userToken);
		paramsMap.put("targetUsername", targetUsername);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String addPrivateMessage(String username, String userToken, String targetUsername, String content) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "privateMsg/addMsg";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);		
		paramsMap.put("userToken", userToken);
		paramsMap.put("targetUsername", targetUsername);
		paramsMap.put("content", content);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String readPrivateMessage(String username, String userToken, String targetUsername) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "privateMsg/readMsg";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);		
		paramsMap.put("userToken", userToken);
		paramsMap.put("targetUsername", targetUsername);
		return fetchURLTool.doPost(url, paramsMap);
	}

}
