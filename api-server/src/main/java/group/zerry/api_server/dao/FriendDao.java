package group.zerry.api_server.dao;

import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.Target;

public interface FriendDao {
	//public Friend[] selectFriendsByNickname(String nickname);

	public String[] selectFriendsByGroupname(String username, String group);
	
	public String[] selectGroupsByUsername(String username);
	
	public Target[] selectCommonFriendsByTargerUsername(String username, String targetUsername);

	public Target[] selectFavorites(String username);
	
	public Target[] selectFollowers(String username);
	
	public Count    judgeIfFriendsOrNot(int userId, int targetUserId);
}
