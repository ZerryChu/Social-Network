package group.zerry.front_server.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/*
 * 页面跳转控制器
 * author: ZerryChu
 * date: 2015.10.11 Sun 11:40pm
 */
@Controller
public class ForwardController {

	@RequestMapping(value = "main")
	public String forwardMainPage() {
		return "mainpage";
	}
}
