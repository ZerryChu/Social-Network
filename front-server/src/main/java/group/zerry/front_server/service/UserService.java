package group.zerry.front_server.service;

import javax.servlet.http.HttpServletRequest;

import group.zerry.front_server.entity.User;

public interface UserService {

	public boolean login(String username, String password, String userToken);

	public boolean logout(String username, String userToken);
	
	public int reg(User user);

	public String showUserInfo(String username);

	public String showUserInfoByNickname(String nickname);

	public String showTargetInfoByNickname(String username, String nickname);

	public String showFriendsByNickname(String nickname);
	
	public boolean addFriend(String username, String userToken, String friendUsername, String group);
	
	public boolean deleteFriend(String username, String userToken, String friendUsername);
	
	public boolean fileUpload(HttpServletRequest request, String username);
	
	public String showRecommendedUsers(String username);
	
	public String getMastersByLabelId(int label_id, int num);
}
