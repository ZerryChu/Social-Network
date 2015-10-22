package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.service.MessageService;

@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	@Autowired
	MessageService messageService;
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String post_message(String username, String userToken, String content, int type) {
		if(messageService.send_message(username, userToken, content, type))
			return "{\"msg\" : 1}";
		else 
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String delete_message(String username, String userToken, int id) {
		if(messageService.delete_message(username, userToken, id))
			return "{\"msg\" : 1}";
		else 
			return "{\"msg\" : 0}";
	}
	
	/**
	 * @return 1:点赞成功 0：操作异常 3：已点过赞
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/support", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String addSupportTimes(String username, int id) {
		StringBuilder regMsg = new StringBuilder("{\"msg\": ");
		regMsg.append(messageService.addSupportTimes(username, id) + "}");
		return regMsg.toString();
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_messages(String username, String userToken, int type) {
		return messageService.show_messages(username, userToken, type);
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_announcements", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_announcements() {
		return messageService.show_announcement();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_ownmessages", produces = "text/html;charset=UTF-8")
	public String show_ownMessages(String nickname) {
		return messageService.show_userOwnMessages(nickname);
	}
}
