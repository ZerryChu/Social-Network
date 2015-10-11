package group.zerry.front_server.service;

import group.zerry.front_server.entity.User;

public interface UserService {

	public boolean login(String username, String password, String userToken);

	public boolean reg(User user);

	public String showUserInfo(String username);

	public boolean addFriend(String username, String friendUsername, String group);
}
