package group.zerry.api_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.entity.Topic;
import group.zerry.api_server.entity.TopicComment;
import group.zerry.api_server.enumtypes.TopicStatusEnum;
import group.zerry.api_server.service.TopicService;

@Controller
@RequestMapping("/topic")
public class TopicController {
	
	@Autowired
	TopicService topicService;
	
	private static SimplePropertyPreFilter topicFilter = new SimplePropertyPreFilter(Topic.class, "id", "name", "read_num", "comment_num", "weibo_num");
	
	@ResponseBody
	@RequestMapping(value = "/show", produces = "text/html;charset=UTF-8")
	public String showTopicsByType(int id, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Topic[] topics = topicService.showTopicsByType(id, page);
		if (null == topics) {
			regMsg.append(TopicStatusEnum.TNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(topics, topicFilter));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/show_topic", produces = "text/html;charset=UTF-8")
	public String showTopicById(int id) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Topic topic = topicService.showTopicById(id);
		if (null == topic) {
			regMsg.append(TopicStatusEnum.TNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(topic));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/show_comment", produces="text/html;charset=UTF-8")
	public String showComment(int id, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		TopicComment[] comments = topicService.showCommentsById(id, page);
		if (null == comments) {
			regMsg.append(TopicStatusEnum.CNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(comments));
		regMsg.append("}");
		return regMsg.toString();
	}
	

	@ResponseBody
	@RequestMapping(value = "/show_topicByName", produces = "text/html;charset=UTF-8")
	public String showTopicByName(String name) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Topic topic = topicService.showTopicByName(name);
		if (null == topic) {
			regMsg.append(TopicStatusEnum.TNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(topic));
		regMsg.append("}");
		return regMsg.toString();
	}
}
