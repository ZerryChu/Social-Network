package group.zerry.api_server.service;

public interface FriendService {
	public String[] showFriendsByGroupname(String username, String group);
	
	public String[] showGroupsByUsername(String username);
		
}
