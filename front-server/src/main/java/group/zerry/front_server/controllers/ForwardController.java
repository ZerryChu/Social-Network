package group.zerry.front_server.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/*
 * 页面跳转控制器
 * author: ZerryChu
 * date: 2015.10.11 Sun 11:40pm
 */
@Controller
public class ForwardController {

	@RequestMapping(value = "/main", produces = "text/html;charset=UTF-8")
	public ModelAndView forwardMainPage(String username, String userToken) {
		//username=" + username + "&userToken=" + userToken
	    ModelAndView mav = new ModelAndView("mainpage"); 
		mav.addObject("username", username);
		mav.addObject("userToken", userToken);
		return mav;
	}
}
