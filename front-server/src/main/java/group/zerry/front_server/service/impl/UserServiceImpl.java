package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.enumtypes.UserStatusEnum;
import group.zerry.front_server.service.UserService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "UserService")
public class UserServiceImpl implements UserService {
	@Autowired
	HttpTarget httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;

	private static Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	public boolean login(String username, String password, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/login";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("password", password);
		paramsMap.put("userToken", userToken);
		//logger.error(fetchURLTool.doPost(url, paramsMap));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(UserStatusEnum.LS.getValue())) {
			return true;
		} else
			return false;
	}

	public boolean reg(User user) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/reg";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", user.getUsername());
		paramsMap.put("password", user.getPassword());
		paramsMap.put("nickname", user.getNickname());
		paramsMap.put("age", String.valueOf(user.getAge()));
		paramsMap.put("habit", user.getHabit());
		paramsMap.put("type", "1");
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(UserStatusEnum.RS.getValue())) {
			return true;
		} else
			return false;
	}

	public String showUserInfo(String username) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/getinfo";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		//User user = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), User.class);
		//return user;
		return fetchURLTool.doPost(url, paramsMap);
	}

	public boolean addFriend(String username, String userToken, String friendUsername, String group) {
		String url = httpTarget.getHostname() + httpTarget.getPath() + "user/addfriend";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("friendUsername", friendUsername);
		paramsMap.put("group", group);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().equals(UserStatusEnum.AFS.getValue()))
			return true;
		else
			return false;
	}

}
