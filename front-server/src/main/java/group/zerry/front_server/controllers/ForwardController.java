package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import group.zerry.front_server.service.FriendService;

/*
 * 页面跳转控制器
 * author: ZerryChu
 * date: 2015.10.11 Sun 11:40pm
 */
@Controller
public class ForwardController {

	@Autowired
	FriendService friendService;
	
	@RequestMapping(value = "/main", produces = "text/html;charset=UTF-8")
	public ModelAndView forwardMainPage(String username, String userToken) {
		//username=" + username + "&userToken=" + userToken
	    ModelAndView mav = new ModelAndView("mainpage"); 
		mav.addObject("username", username);
		mav.addObject("userToken", userToken);
		return mav;
	}
	
	@RequestMapping(value = "/chat", produces = "text/html;charset=UTF-8")
	public ModelAndView chat(String username, String userToken, String friendNickname) {
		ModelAndView  mav = null;
		if(friendService.ifAllowChat(username, userToken, friendNickname)) {
			mav = new ModelAndView("chatbar.jsp"); 
			mav.addObject("username", username);
			mav.addObject("userToken", userToken);
			mav.addObject("friendNickname", friendNickname);
		} else {
			// turn to error page
			// 没写error.jsp
			mav = new ModelAndView("error.jsp"); 
		}
		return mav;
	}
}
