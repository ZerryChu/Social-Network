package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.SearchService;

@Controller
@RequestMapping(value="/search")
public class SearchController {
	@Autowired
	SearchService searchService;
	
	@ResponseBody
	@RequestMapping(value = "/users", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String searchUsersLikeNickname(String nickname) {
		return searchService.searchUsersLikeNickname(nickname);
	}
	
	@ResponseBody
	@RequestMapping(value = "/messages", produces = "text/html;charset=UTF-8")
	public String searchMessagesLikeContent(String content) {
		return searchService.searchMessagesLikeContent(content);
	}
}
