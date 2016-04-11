package group.zerry.api_server.controllers;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.Target;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
import group.zerry.api_server.service.SearchService;

/**
 * @author ZerryChu
 * @since 2015 10 19
 * @content 数据库检索
 */
@Controller
@RequestMapping(value = "/search")
public class DataSearchController {

	@Autowired
	SearchService searchService;

	Logger logger = Logger.getLogger(DataSearchController.class);

	private static SimplePropertyPreFilter userFilter = new SimplePropertyPreFilter(User.class, "nickname", "username",
			"age", "type", "habit", "friend_num", "focus_num", "message_num");

	@ResponseBody
	@RequestMapping(value = "/users", produces = "text/html;charset=UTF-8")
	public String searchUsersLikeNickname(String nickname, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User[] users = null;
		try {
			users = searchService.searchUsersLikeNickname(nickname, page);
		} catch (Exception e) {
			regMsg.append(UserStatusEnum.UNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(users, userFilter));
		regMsg.append("}");
		return regMsg.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/messages", produces = "text/html;charset=UTF-8")
	public String searchMessagesLikeContent(String username, String content, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		try {
			messages = searchService.searchMessagesLikeContent(username, content, page);
		} catch (Exception e) {
			e.printStackTrace();
			regMsg.append(MessageStatusEnum.SMF.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(messages));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
}
