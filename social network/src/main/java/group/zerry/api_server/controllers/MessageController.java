package group.zerry.api_server.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.service.MessageService;
import group.zerry.api_server.service.UserService;
import redis.clients.jedis.Jedis;

@Controller(value="/massage")
public class MessageController {

	@Autowired
	MessageService                         messageService;
		
	private static Jedis                   jedis = new Jedis("localhost", 6379);

	private static SimplePropertyPreFilter userFilter   = new SimplePropertyPreFilter(Message.class, "author",
            "content", "create_time");
	
    private static Logger                  logger = Logger.getLogger(UserController.class);

	/*
	 * 发帖子
	 * type: 1 所有人可见 2 好友可见
	 * 
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String post_message(HttpServletRequest request, String username, String content, int type) {
        StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        String userToken = (String) request.getSession().getAttribute("usertoken");
		if(null == userToken || null == jedis.get("username") || !jedis.get("username").equals(userToken)) {
			regMsg.append(MessageStatusEnum.ACF);
			regMsg.append("\"}");
	        logger.info(regMsg.toString());
			return regMsg.toString();
		}
		Message message = new Message();
		message.setAuthor(username);
		message.setContent(content);
		message.setType(type);
		regMsg.append(messageService.send_message(message));
		regMsg.append("\"}");
        logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", produces = "text/html;charset=UTF-8")
	public String delete_message(HttpServletRequest request, String username, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        String userToken = (String) request.getSession().getAttribute("usertoken");
		if(null == userToken || null == jedis.get("username") || !jedis.get("username").equals(userToken)) {
			regMsg.append(MessageStatusEnum.ACF);
			regMsg.append("\"}");
	        logger.info(regMsg.toString());
			return regMsg.toString();
		}
		regMsg.append(messageService.delete_message(id));
		regMsg.append("\"}");
        logger.info(regMsg.toString());
		return regMsg.toString();
	}
	
	/* 
	 * type 1 所有帖子 2 好友可见 
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/show", produces = "text/html;charset=UTF-8")
	public String show_message(HttpServletRequest request, String username, int type, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        String userToken = (String) request.getSession().getAttribute("usertoken");
		if(null == userToken || null == jedis.get("username") || !jedis.get("username").equals(userToken)) {
			regMsg.append(MessageStatusEnum.ACF);
			regMsg.append("\"}");
	        logger.info(regMsg.toString());
			return regMsg.toString();
		}
        logger.info(regMsg.toString());
		return null;
	}
}
