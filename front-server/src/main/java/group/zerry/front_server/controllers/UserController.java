package group.zerry.front_server.controllers;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.service.UserService;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@ResponseBody
	@RequestMapping(value = "/login", produces = "text/html;charset=UTF-8")
	public String login(HttpServletRequest request, String username, String password) {
		//for AJAX
		UUID uuid = UUID.randomUUID();
		logger.error(uuid.toString());
		if(userService.login(username, password, uuid.toString())) {
			request.getSession().setAttribute(username, uuid.toString());
			return "{\"msg\" : \"" + uuid.toString() + "\"}";
			//返回userToken
		}
		else
			return "{\"msg\" : 0}";
	}
	
	@ResponseBody
	@RequestMapping(value="/reg", produces = "text/html;charset=UTF-8")
	public String reg(User user) {
		//for AJAX
		if(userService.reg(user)) {
			return "{\"msg\" : 1}";
		}
		else
			return "{\"msg\" : 0}";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getinfo", produces = "text/html;charset=UTF-8")
	public String showUserInfo(String username) {
		return userService.showUserInfo(username); //json data
	}
	
	// 考虑验证好友请求
	@AuthPass
	@RequestMapping(value = "/addfriend", produces = "text/html;charset=UTF-8")
	public String addFriend(String username, String userToken, String friendUsername, String group) {
		if(userService.addFriend(username, userToken, friendUsername, group))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/insert_icon", produces = "text/html;charset=UTF-8")
	public String insertIcon(HttpServletRequest request, String username, String usertoken) {
		if(userService.fileUpload(request, username)) {
			return "{\"msg\" : 1}";
		}
		else {
			return "{\"msg\" : 0}";	
		}
	}
	
}
