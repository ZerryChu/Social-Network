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
	
	@Autowired
	UserDao       userDao;

	Logger logger = Logger.getLogger(DataSearchController.class);

	private static SimplePropertyPreFilter userFilter = new SimplePropertyPreFilter(User.class, "nickname", "username",
			"age", "type", "habit", "friend_num", "focus_num", "message_num");

	private static SimplePropertyPreFilter messageFilter = new SimplePropertyPreFilter(Message.class, "id", "author",
			"content", "create_time", "repost_times", "comment_times", "support_times");

	@ResponseBody
	@RequestMapping(value = "/users", produces = "text/html;charset=UTF-8")
	public String searchUsersLikeNickname(String nickname, int page) {
		int pageSize = 15;
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		User[] users = null;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
			users = searchService.searchUsersLikeNickname(nickname);
			Page<User> myPage = PageHelperInterceptor.endPage();
			List<User> list = myPage.getResult();
			users = (User[]) list.toArray(new User[list.size()]);
		} catch (Exception e) {
			regMsg.append(UserStatusEnum.UNE.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		for (int i = 0;i < users.length; i++) {
			int id = users[i].getId();
			int user_fans_num = userDao.getUserFansNumById(id);
			int user_focus_num = userDao.getUserFocusNumById(id);
			users[i].setFocus_num(user_focus_num);
			users[i].setFriend_num(user_fans_num);
		}
		regMsg.append(JSON.toJSONString(users, userFilter));
		regMsg.append("}");
		return regMsg.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/messages", produces = "text/html;charset=UTF-8")
	public String searchMessagesLikeContent(String content, int page) {
		int pageSize = 4;
		StringBuilder regMsg = new StringBuilder("{\"returndata\":");
		Message[] messages;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
			messages = searchService.searchMessagesLikeContent(content);
			Page<Message> myPage = PageHelperInterceptor.endPage();
			List<Message> list = myPage.getResult();
			messages = (Message[]) list.toArray(new Message[list.size()]);
		} catch (Exception e) {
			logger.error(e.getMessage());
			regMsg.append(MessageStatusEnum.SMF.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}
		regMsg.append(JSON.toJSONString(messages, messageFilter));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}
}
