package group.zerry.api_server.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.SearchService;

/**
 * @author  ZerryChu
 * @since   2015 10 19
 * @content 数据库检索
 */
@Controller
@RequestMapping(value="/search")
public class DataSearchController {
	
	@Autowired
	SearchService                          searchService;
	
	private static SimplePropertyPreFilter userFilter   = new SimplePropertyPreFilter(User.class, "nickname",
            "age", "type", "habit", "friend_num", "message_num");
	
	private static SimplePropertyPreFilter messageFilter = new SimplePropertyPreFilter(Message.class, "id", "author",
			"content", "create_time", "repost_times", "comment_times", "support_times");
	
	@ResponseBody
	@RequestMapping(value = "/users", produces = "text/html;charset=UTF-8")
	public String searchUsersLikeNickname(String nickname) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User[] users = null;
		try {
			users = searchService.searchUsersLikeNickname(nickname);

		} catch (Exception e) {
			regMsg.append(UserStatusEnum.UNE);
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(users, userFilter));
		regMsg.append("}");
		return regMsg.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/messages", produces = "text/html;charset=UTF-8")
	public String searchMessagesLikeContent(String content) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		try {
			messages = searchService.searchMessagesLikeContent(content);

		} catch (Exception e) {
			regMsg.append(MessageStatusEnum.SMF);
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(messages, messageFilter));
		regMsg.append("}");
		return regMsg.toString();
	}
}
