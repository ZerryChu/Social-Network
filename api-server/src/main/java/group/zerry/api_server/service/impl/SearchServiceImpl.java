package group.zerry.api_server.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.LabelDao;
import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.SourceMessagae;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
import group.zerry.api_server.service.MessageService;
import group.zerry.api_server.service.SearchService;

/**
 * 
 * @author zhuzirui
 * 待开发垂直搜索引擎
 */
@Service(value="SearchService")
public class SearchServiceImpl implements SearchService {

	@Autowired
	UserDao        userDao;
	
	@Autowired
	MessageDao     messageDao;
	
	@Autowired
	LabelDao       labelDao;
	
	@Autowired
	MessageService messageService;
	
	@Override
	public Message[] searchMessagesLikeContent(String username, String content, int page) {
		// TODO Auto-generated method stub
		int pageSize = 4;
		content = '%' + content + '%';
		Message[] messages = null;
		PageHelperInterceptor.startPage(page, pageSize);
		messages = messageDao.searchMessagesLikeContent(content);
		Page<Message> myPage = PageHelperInterceptor.endPage();
		List<Message> list = myPage.getResult();
		messages = (Message[]) list.toArray(new Message[list.size()]);
		
		if (username != null || !username.equals("")) {
			messageCompletion(messages, username);
		}
		return messages;
	}

	@Override
	public User[] searchUsersLikeNickname(String nickname, int page) {
		// TODO Auto-generated method stub
		int pageSize = 15;
		nickname = '%' + nickname + '%';
		User[] users = null;
		PageHelperInterceptor.startPage(page, pageSize);
		users = userDao.searchUsersLikeNickname(nickname);
		Page<User> myPage = PageHelperInterceptor.endPage();
		List<User> list = myPage.getResult();
		users = (User[]) list.toArray(new User[list.size()]);
		
		for (int i = 0;i < users.length; i++) {
			int id = users[i].getId();
			int user_fans_num = userDao.getUserFansNumById(id);
			int user_focus_num = userDao.getUserFocusNumById(id);
			users[i].setFocus_num(user_focus_num);
			users[i].setFriend_num(user_fans_num);
		}
		return users;
	}
	
	public void messageCompletion(Message[] message, String username) {
		User author = null;
		for (int i = 0; i < message.length; i++) {
			author = userDao.selectUserByNickname(message[i].getAuthor().getNickname());
			// 屏蔽密码
			author.setPassword("");
			message[i].setAuthor(author);
			message[i].setSupported(messageService.judgeIfSupport(username, message[i].getId()));
			message[i].setLabel_name(messageDao.findLabel(message[i].getId()));
		}
	}

}
