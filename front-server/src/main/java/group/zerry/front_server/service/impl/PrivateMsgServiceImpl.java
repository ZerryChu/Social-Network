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

}
