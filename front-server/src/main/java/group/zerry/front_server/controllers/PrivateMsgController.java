package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.PrivateMsgService;

@Controller
@RequestMapping(value = "/privateMsg")
public class PrivateMsgController {
	
	@Autowired
	PrivateMsgService privateMsgService;
	
	@ResponseBody
	@RequestMapping(value = "/getInfo", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showPrivateMessagesInfo(String username, String userToken) {
		return privateMsgService.getALLPrivateMsgList(username, userToken);
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMessage", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String showMessage(String username, String userToken, int id) {
		return null;
	}
}
