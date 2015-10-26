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
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.DMS.getValue())) {
			return true;
		} else {
			return false;
		}
	}

	public String show_messages(String username, String userToken, int page, int type) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("page", String.valueOf(page));
		paramsMap.put("type", String.valueOf(type));
		//List<Message> messages = JSON.parseArray(fetchURLTool.doPost(url, paramsMap), Message.class);
		return fetchURLTool.doPost(url, paramsMap);
	}

	public String show_userOwnMessages(String nickname, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_ownmessages";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("nickname", nickname);
		paramsMap.put("page", String.valueOf(page));
		return fetchURLTool.doPost(url, paramsMap);
	}

	public String show_announcement() {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_announcements";
		Map<String, String> paramsMap = new HashMap<String, String>();
		//无参
		return fetchURLTool.doPost(url, paramsMap);
	}

	/**
	 * @return 1:点赞成功 0：操作异常 2：已点过赞
	 */
	public int addSupportTimes(String username, String userToken, int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/support";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("id", String.valueOf(id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if(returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OF.getValue())) {
			return 0;
		}
		else if(returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.SS.getValue()))
			return 1;
		else
			return 2;
	}
	
	/**
	 * @return 1:取消点赞成功 0：操作异常 2：没点过赞
	 */
	public int decreaseSupportTimes(String username, String userToken, int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/_support";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("id", String.valueOf(id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if(returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OF.getValue())) {
			return 0;
		}
		else if(returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OS.getValue()))
			return 1;
		else
			return 2;
	}

	public String judgeIfSupport(String username, int message_id, String userToken) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/judge_ifsupport";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("id", String.valueOf(message_id));
		paramsMap.put("userToken", userToken);
		return fetchURLTool.doPost(url, paramsMap);
	}

	public boolean send_comment(String username, String userToken, int id, String content) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/comment";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("id", String.valueOf(id));
		paramsMap.put("content", content);
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.CS.getValue())) {
			return true;
		} else
			return false;
	}

}
