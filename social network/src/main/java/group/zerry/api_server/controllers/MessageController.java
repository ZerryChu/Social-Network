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

@Controller
@RequestMapping(value="/message")
public class MessageController {

	@Autowired
	MessageService messageService;

	private static SimplePropertyPreFilter messageFilter = new SimplePropertyPreFilter(Message.class, "author",
			"content", "create_time");

	private static Logger logger = Logger.getLogger(MessageController.class);

	/*
	 * 发帖子 type: 1 所有人可见 2 好友可见
	 * 
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String post_message(String username, String content, int type) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(messageService.send_message(username, content, type));
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", produces = "text/html;charset=UTF-8")
	public String delete_message(String username, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(messageService.delete_message(id));
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}

	/*
	 * type 1 好友可见
	 * 
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show", produces = "text/html;charset=UTF-8")
	public String show_messages(String nickname, int type, int page) {
		page--;
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		Message[] messages;
		Message[] messagesInUse;
		try {
			messages = messageService.show_messages(nickname, type);
			messagesInUse = new Message[10];
			int index = 0;
			for (int i = page * 10; i < (page + 1) * 10; i++) {
				if(i + 1 <= messages.length)
					messagesInUse[index++] = messages[i];
				else
					break;
			}
		} catch (Exception e) {
			regMsg.append(MessageStatusEnum.SMF);
			regMsg.append("\"}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(messagesInUse, messageFilter));
		regMsg.append("\"}");
		logger.info(regMsg.toString());
		return regMsg.toString();
	}

	//待选添加： 查看自己的帖子
}
