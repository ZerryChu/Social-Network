package group.zerry.api_server.dao;

import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.Target;
import group.zerry.api_server.entity.User;

public interface FriendDao {
	//public Friend[] selectFriendsByNickname(String nickname);

	public User[]   selectFriendsByGroupname(String username, String group);
	
	public String[] selectGroupsByUsername(String username);
	
	public Target[] selectCommonFriendsByTargerUsername(String username, String targetUsername);

	public Target[] selectFavorites(String username);
	
	public Target[] selectFollowers(String username);
	
	public Count    judgeIfFocusOrNot(int userId, int targetUserId);
}
