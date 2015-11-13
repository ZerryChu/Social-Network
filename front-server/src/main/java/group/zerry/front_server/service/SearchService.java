package group.zerry.front_server.service;

public interface SearchService {
	public String searchUsersLikeNickname(String nickname);
	
	public String searchMessagesLikeContent(String content);

}
