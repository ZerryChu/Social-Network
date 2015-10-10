package group.zerry.front_server.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class defaultController {
	@RequestMapping(value="/aaa")
	public String Check() {
		 return "message/send";
	}
	
	
}
