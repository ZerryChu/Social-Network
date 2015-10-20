package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
import group.zerry.front_server.entity.Message;
import group.zerry.front_server.enumtypes.MessageStatusEnum;
import group.zerry.front_server.enumtypes.UserStatusEnum;
import group.zerry.front_server.service.MessageService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "MessageService")
public class MessageServiceImpl implements MessageService {

	@Autowired
	HttpTarget    httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;

	public boolean send_message(String username, String userToken, String content, int type) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/send";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("content", content);
		paramsMap.put("type", String.valueOf(type));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.AMS.getValue())) {
			return true;
		} else
			return false;
	}

	public boolean delete_message(String username, String userToken, int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/delete";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("id", String.valueOf(id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.DMS)) {
			return true;
		} else
			return false;
	}

	public String show_messages(String username, String userToken, int type) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("type", String.valueOf(type));
		//List<Message> messages = JSON.parseArray(fetchURLTool.doPost(url, paramsMap), Message.class);
		return fetchURLTool.doPost(url, paramsMap);
	}

	public String show_userOwnMessages(String nickname) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_ownmessages";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("nickname", nickname);
		return fetchURLTool.doPost(url, paramsMap);
	}

}
