package group.zerry.front_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import group.zerry.front_server.service.TopicService;

@Controller
@RequestMapping(value="/topic")
public class TopicController {

	@Autowired
	TopicService topicService;
	
	@ResponseBody
	@RequestMapping(value="/show", produces = "text/html;charset=UTF-8")
	public String showTopicsByType(int id, int page) {
		return topicService.showTopicsByType(id, page);
	}
	
	@ResponseBody
	@RequestMapping(value="/show_topic", produces = "text/html;charset=UTF-8")
	public String showTopicById(int id) {
		return topicService.showTopicById(id);
	}
	
	@ResponseBody
	@RequestMapping(value="/show_comment", produces = "text/html;charset=UTF-8")
	public String showCommentsByTopicId(int id, int page) {
		return topicService.showCommentsByTopicId(id, page);
	}
	
	@ResponseBody
	@RequestMapping(value="/show_topicByName", produces = "text/html;charset=UTF-8")
	public String showTopicByName(String name) {
		return topicService.showTopicByName(name);
	}
}
