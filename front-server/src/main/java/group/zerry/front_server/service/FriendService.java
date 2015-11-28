package group.zerry.front_server.service;

public interface FriendService {
	public String  showFriendsByGroupname(String username, String userToken, String groupname);
	
	public String  showCommonFriendsByTargetUsername(String username, String userToken, String targetUsername);
	
	public String  showGroupsByUsername(String username, String userToken);
	
	public String  showFavoritesNickname(String username, String userToken, int page);
	
	public String  showFollowersNickname(String username, String userToken, int page);
	
	public boolean ifAllowChat(String username, String usertoken, String friendNickname);

	public boolean  judgeIfFriendsOrNot(String username, String targetUsername);
	
}
