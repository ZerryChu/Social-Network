package group.zerry.api_server.controllers;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.service.MessageService;

/**
 * @author  ZerryChu
 * @since   2015 10 3
 * @version 2.0
 *
 */
@Controller
@RequestMapping(value="/message")
public class MessageController {

	@Autowired
	MessageService messageService;

	private static SimplePropertyPreFilter messageFilter = new SimplePropertyPreFilter(Message.class, "id", "author",
			"content", "create_time", "repost_times", "comment_times", "support_times");

	private static Logger logger = Logger.getLogger(MessageController.class);

	/*
	 * 发送微博
	 * @return type: 1 普通微博 2： 转发的微博
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String post_message(String username, String userToken, String content, int type) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(messageService.send_message(username, content, type).getValue());
		regMsg.append("\"}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", produces = "text/html;charset=UTF-8")
	public String delete_message(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(messageService.delete_message(username, id).getValue());
		regMsg.append("\"}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}

	/*
	 * @param type 2: 转发的微博
	 * 分页 pagesize=10
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show", produces = "text/html;charset=UTF-8")
	public String show_messages(String username, String userToken, int page, int type) {
		//page--;
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		//Message[] messagesInUse;
		try {
			messages = messageService.show_messages(username, page, type);
			/*
			messagesInUse = new Message[10];
			int index = 0;
			for (int i = page * 10; i < (page + 1) * 10; i++) {
				if(i + 1 <= messages.length)
					messagesInUse[index++] = messages[i];
				else
					break;
			}
			*/
		} catch (Exception e) {
			regMsg.append(MessageStatusEnum.SMF);
			regMsg.append("}");
			return regMsg.toString();
		}
		//regMsg.append(JSON.toJSONString(messagesInUse, messageFilter));
		regMsg.append(JSON.toJSONString(messages, messageFilter));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/repost", produces = "text/html;charset=UTF-8")
	public String repost_message(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		MessageStatusEnum status = messageService.addRepost(username, id);
		regMsg.append(status.getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/comment", produces = "text/html;charset=UTF-8")
	public String comment_message(String username, String userToken, int id, String content) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		MessageStatusEnum status = messageService.addComment(username, content, id);
		regMsg.append(status.getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/support", produces = "text/html;charset=UTF-8")
	public String support_message(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		MessageStatusEnum status = messageService.addSupport(username, id);
		regMsg.append(status.getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/_support", produces = "text/html;charset=UTF-8")
	public String decreseSupport(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		MessageStatusEnum status = messageService.decreaseSupport(username, id);
		regMsg.append(status.getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}
	
	/**
	 * 获取目标对象发的微博
	 * @分页 pagesize=10
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/show_ownmessages", produces = "text/html;charset=UTF-8")
	public String show_userOwnMessages(String nickname, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		//Message[] messagesInUse;
		try {
			messages = messageService.show_ownMessages(nickname, page);
			/*
			messagesInUse = new Message[10];
			int index = 0;
			for (int i = page * 10; i < (page + 1) * 10; i++) {
				if(i + 1 <= messages.length)
					messagesInUse[index++] = messages[i];
				else
					break;
			}
			*/
		} catch (Exception e) {
			regMsg.append(MessageStatusEnum.SMF.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		//regMsg.append(JSON.toJSONString(messagesInUse, messageFilter));
		regMsg.append(JSON.toJSONString(messages, messageFilter));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_announcements", produces = "text/html;charset=UTF-8")
	public String show_announcements() {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		//Message[] messagesInUse;
		try {
			messages = messageService.show_announcements();
			/*
			messagesInUse = new Message[10];
			int index = 0;
			for (int i = page * 10; i < (page + 1) * 10; i++) {
				if(i + 1 <= messages.length)
					messagesInUse[index++] = messages[i];
				else
					break;
			}
			*/
		} catch (Exception e) {
			regMsg.append(MessageStatusEnum.SMF.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		//regMsg.append(JSON.toJSONString(messagesInUse, messageFilter));
		regMsg.append(JSON.toJSONString(messages, messageFilter));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
	/**
	 * 
	 * @param username
	 * @param id
	 * @return 1: 允许点赞 0: 不允许点赞
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/judge_ifsupport", produces = "text/html;charset=UTF-8")
	public String findIfSupportedByUsername(String username, int id, String userToken) {
		StringBuilder regMsg = new StringBuilder("{\"msg\":");
		if(true == messageService.judgeIfSupport(username, id)) {
			regMsg.append(" 1");
		} //可以点赞
		else {
			regMsg.append(" 0");
		} //不能点赞
		regMsg.append("}");
		return regMsg.toString();
	}
}
