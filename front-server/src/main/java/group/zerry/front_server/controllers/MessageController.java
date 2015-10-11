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
	public String post_message(String username, String content, int type) {
		if(messageService.send_message(username, content, type))
			return "{\"msg\" : 1}";
		else 
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String delete_message(String username, int id) {
		if(messageService.delete_message(username, id))
			return "{\"msg\" : 1}";
		else 
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_messages(String nickname, int type, int page) {
		return messageService.show_messages(nickname, type, page);
	}
	
}
