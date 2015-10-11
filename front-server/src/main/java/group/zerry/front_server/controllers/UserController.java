package group.zerry.front_server.controllers;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.entity.User;
import group.zerry.front_server.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@ResponseBody
	@RequestMapping(value = "/user/login", produces = "text/html;charset=UTF-8")
	public String login(HttpServletRequest request, String username, String password) {
		//for AJAX
		UUID uuid = UUID.randomUUID();
		if(userService.login(username, password, uuid.toString())) {
			request.getSession().setAttribute(username, uuid.toString());
			return "{\"msg\" : 1}";
		}
		else
			return "{\"msg\" : 0}";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/reg", produces = "text/html;charset=UTF-8")
	public String reg(User user) {
		//for AJAX
		if(userService.reg(user)) {
			return "{\"msg\" : 1}";
		}
		else
			return "{\"msg\" : 0}";
	}
	
	@AuthPass
	@RequestMapping(value = "/user/getinfo", produces = "text/html;charset=UTF-8")
	public String showUserInfo(String username) {
		return userService.showUserInfo(username); //json data
	}
	
	@AuthPass
	@RequestMapping(value = "/user/addfriend", produces = "text/html;charset=UTF-8")
	public String addFriend(String username, String friendUsername, String group) {
		if(userService.addFriend(username, friendUsername, group))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}
	
}
