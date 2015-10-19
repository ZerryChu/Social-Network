package group.zerry.api_server.dao;

import group.zerry.api_server.entity.Friend;

public interface FriendDao {
	public Friend[] selectFriendsByNickname(String nickname);

}
