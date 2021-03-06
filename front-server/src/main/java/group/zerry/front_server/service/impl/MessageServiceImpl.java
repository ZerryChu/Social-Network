package group.zerry.front_server.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.dto.ReturnMsgDto;
import group.zerry.front_server.enumtypes.MessageStatusEnum;
import group.zerry.front_server.service.MessageService;
import group.zerry.front_server.utils.FetchUrlTools;
import group.zerry.front_server.utils.HttpTarget;

@Service(value = "MessageService")
public class MessageServiceImpl implements MessageService {

	@Autowired
	HttpTarget httpTarget;

	@Autowired
	FetchUrlTools fetchURLTool;

	Logger logger = Logger.getLogger(MessageService.class);

	/**
	 * @content 图片存储位置
	 */
	//private String path = "/root/apache-tomcat-7.0.65/webapps/weibo/message/";
	private String path = "/Users/zhuzirui/GitHub/Social-Network/front-server/src/main/webapp/message/";
	
	private boolean fileUpload(MultipartFile pic, UUID uuid) {
		// 图片大小，像素等的处理
		if (pic == null || pic.getSize() >= 5242880)
			return false;
		String filePath = path + uuid.toString() + ".jpg";
		System.out.println(filePath);
		File file = new File(filePath);
		try {
			pic.transferTo(file);
			file.createNewFile();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error(e.getMessage());
			return false;
		}
		return true;
	}

	public boolean send_message(String username, String userToken, String content, int type,
			MultipartFile pic, String label) {
		// TODO Auto-generated method stub
		try {
			logger.error("content: " + content);
			UUID uuid = UUID.randomUUID();
			String url = httpTarget.getHostname() + httpTarget.getPath() + "message/send";
			Map<String, String> paramsMap = new HashMap<String, String>();
			paramsMap.put("username", username);
			paramsMap.put("userToken", userToken);
			paramsMap.put("content", content);
			paramsMap.put("type", String.valueOf(type));
			paramsMap.put("label", label);
			if(!pic.isEmpty())
				paramsMap.put("pic", uuid.toString());
			ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
			if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.AMS.getValue())) {
				if(!pic.isEmpty() && false == fileUpload(pic, uuid))
					logger.error("图片上传失败");
				return true;
			} else
				return false;

		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			logger.error(e.getMessage());
			e.printStackTrace();
			return false;
		}
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

	public String show_messages(String username, String userToken, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("page", String.valueOf(page));
		// List<Message> messages = JSON.parseArray(fetchURLTool.doPost(url,
		// paramsMap), Message.class);
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
		// 无参
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
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OF.getValue())) {
			return 0;
		} else if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.SS.getValue()))
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
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OF.getValue())) {
			return 0;
		} else if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.OS.getValue()))
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

	public boolean add_repost(String username, String userToken, String content, int id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/repost";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("content", content);
		paramsMap.put("id", String.valueOf(id));
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.RS.getValue())) {
			return true;
		} else
			return false;
	}

	@Override
	public String show_messageById(String username, String userToken, int message_id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_message";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("message_id", String.valueOf(message_id));
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String show_messagesByLabel(String username, String userToken, int label_id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_by_label";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("label_id", String.valueOf(label_id));
		paramsMap.put("page", String.valueOf(page));
		// List<Message> messages = JSON.parseArray(fetchURLTool.doPost(url,
		// paramsMap), Message.class);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String show_messagesByLabelAndHeat(String username, String userToken, int label_id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_by_labelAndHeat";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("label_id", String.valueOf(label_id));
		paramsMap.put("page", String.valueOf(page));
		// List<Message> messages = JSON.parseArray(fetchURLTool.doPost(url,
		// paramsMap), Message.class);
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public String showWeiboByTopicId(String username, int topic_id, int page) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/show_topicWeibo";
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("topic_id", String.valueOf(topic_id));
		paramsMap.put("page", String.valueOf(page));
		return fetchURLTool.doPost(url, paramsMap);
	}

	@Override
	public boolean send_topicWeibo(String username, String userToken, String content, MultipartFile pic, int topic_id) {
		// TODO Auto-generated method stub
		String url = httpTarget.getHostname() + httpTarget.getPath() + "message/send_topicWeibo";
		UUID uuid = UUID.randomUUID();
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("username", username);
		paramsMap.put("userToken", userToken);
		paramsMap.put("content", content);
		paramsMap.put("topic_id", String.valueOf(topic_id));
		if(!pic.isEmpty())
			paramsMap.put("pic", uuid.toString());
		ReturnMsgDto returnMsgDto = JSON.parseObject(fetchURLTool.doPost(url, paramsMap), ReturnMsgDto.class);
		if (returnMsgDto.getReturnMsg().trim().equals(MessageStatusEnum.AMS.getValue())) {
			if(!pic.isEmpty() && false == fileUpload(pic, uuid))
				logger.error("图片上传失败");
			return true;
		} else
			return false;
	}

}
