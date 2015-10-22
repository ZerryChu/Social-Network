package group.zerry.api_server.service;

import group.zerry.api_server.entity.Friend;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.UserStatusEnum;

public interface UserService {
	public UserStatusEnum login(String username, String password);
		
	public UserStatusEnum Reg(User user);
	
	public User showUserInfo(String username);

	public User showTargetInfoByNickname(String nickname);
	
	public Friend[] showFriendsByNickname(String nickname);

	public UserStatusEnum addFriend(String username, String friendUsername, String group);

}
