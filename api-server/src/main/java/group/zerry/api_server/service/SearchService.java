package group.zerry.api_server.service;

import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;

public interface SearchService {
	public Message[] searchMessagesLikeContent(String username, String content, int page);
	
	public User[] searchUsersLikeNickname(String nickname, int page);
}
