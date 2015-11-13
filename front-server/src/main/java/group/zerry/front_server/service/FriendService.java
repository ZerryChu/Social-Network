package group.zerry.front_server.service;

public interface FriendService {
	public String  showFriendsByGroupname(String username, String userToken, String groupname);
	
	public String  showGroupsByUsername(String username, String userToken);
	
	public boolean ifAllowChat(String username, String usertoken, String friendNickname);

	public boolean  judgeIfFriendsOrNot(String username, String targetUsername);
}
