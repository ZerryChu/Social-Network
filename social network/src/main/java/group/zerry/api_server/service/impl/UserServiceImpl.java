package group.zerry.api_server.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.UserService;
import group.zerry.api_server.utils.EncodeTools;

@Service(value="UserService")
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDao userDao;
	
	@Override
	public UserStatusEnum login(String username, String password) {
		// TODO Auto-generated method stub
		if(username == null || password == null)
			return UserStatusEnum.UNV;
		username = username.trim();
		password = password.trim();
		if(username == "" || password == "")
			return UserStatusEnum.UNV;
		String temp = userDao.selectUserByUsername(username).getPassword();
		if(temp.equals(EncodeTools.encoder(password, temp.substring(0, 4))))
			return UserStatusEnum.LS;
		else
			return UserStatusEnum.PI;
	}
	
	@Override
	public UserStatusEnum Reg(User user) {
		// TODO Auto-generated method stub
		if(user == null)
			return UserStatusEnum.UNV;
		else {
			try {
				userDao.addUser(user);
				return UserStatusEnum.RS;
			} catch(Exception e) {
				return UserStatusEnum.AUF;
			}
		}
	}
	
	@Override
	public User showUserInfo(String username) {
		// TODO Auto-generated method stub
		return null;
	}
}
