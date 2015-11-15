package group.zerry.api_server.service;

import group.zerry.api_server.entity.Target;

public interface FriendService {
	public String[] showFriendsByGroupname(String username, String group);
	
	public String[] showGroupsByUsername(String username);
		
	public boolean  judgeIfFriendsOrNot(String username, String targetUsername);
	
	public Target[] showFavorites(String username, int page);
	
	public Target[] showFollowers(String username, int page);
}
