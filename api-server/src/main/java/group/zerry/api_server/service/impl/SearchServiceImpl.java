package group.zerry.api_server.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.service.SearchService;

@Service(value="SearchService")
public class SearchServiceImpl implements SearchService {

	@Autowired
	UserDao    userDao;
	
	@Autowired
	MessageDao messageDao;
	
	@Override
	public Message[] searchMessagesLikeContent(String content) {
		// TODO Auto-generated method stub
		content = '%' + content + '%';
		return messageDao.searchMessagesLikeContent(content);
	}

	@Override
	public User[] searchUsersLikeNickname(String nickname) {
		// TODO Auto-generated method stub
		System.out.println("nickname: " + nickname);
		nickname = '%' + nickname + '%';
		return userDao.searchUsersLikeNickname(nickname);
	}

}
