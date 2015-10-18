package group.zerry.front_server.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import group.zerry.front_server.entity.User;

public interface UserService {

	public boolean login(String username, String password, String userToken);

	public boolean reg(User user);

	public String showUserInfo(String username);

	public boolean addFriend(String username, String userToken, String friendUsername, String group);
	
	public boolean fileUpload(HttpServletRequest request, String username);
	
}
