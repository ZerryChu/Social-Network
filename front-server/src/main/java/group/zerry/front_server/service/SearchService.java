package group.zerry.front_server.service;

public interface SearchService {
	public String searchUsersLikeNickname(String nickname, int page);
	
	public String searchMessagesLikeContent(String content, int page);

}
