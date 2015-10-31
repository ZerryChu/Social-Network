package group.zerry.front_server.service;

public interface FriendService {
	public String showFriendsByGroupname(String username, String groupname);
	
	public String showGroupsByUsername(String username);
	
}
