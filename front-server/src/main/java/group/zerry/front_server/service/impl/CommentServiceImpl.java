package group.zerry.front_server.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
import group.zerry.front_server.enumtypes.CommentStatusEnum;
import group.zerry.front_server.service.CommentService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value="CommentService")
public class CommentServiceImpl implements CommentService{

	@Autowired
	HttpTarget    httpTarget;
	
	@Autowired
	FetchUrlTools fetchUrlTool;
	
	public String show_comments(int id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "comment/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("id", String.valueOf(id));
		paramsMap.put("page", String.valueOf(page));
		return fetchUrlTool.doPost(url, paramsMap);
	}
	
	public boolean delete_comment(String username, String userToken, String nickname, int message_id, int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "comment/delete";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("nickname", nickname);
		paramsMap.put("message_id", String.valueOf(message_id));
		paramsMap.put("id", String.valueOf(id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchUrlTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if(returnMsgDto.getReturnMsg().trim().equals(CommentStatusEnum.OS.getValue())) {
			return true;
		} else
			return false;
	}

	@Override
	public boolean insertCommentByTopicId(String username, String userToken, String comment, int topic_id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "comment/add_topicComment";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("comment", comment);
		paramsMap.put("topic_id", String.valueOf(topic_id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchUrlTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if(returnMsgDto.getReturnMsg().trim().equals(CommentStatusEnum.ATCS.getValue())) {
			return true;
		} else
			return false;
	}
	
	//评论点赞
}
