package group.zerry.api_server.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.UserService;
import group.zerry.api_server.utils.EncodeTools;
/**
 * @author ZerryChu
 * @since  2015.10.3
 *
 */
@Service(value = "UserService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao userDao;

	private static Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Override
	public UserStatusEnum login(String username, String password) {
		// TODO Auto-generated method stub
		if (username == null || password == null)
			return UserStatusEnum.UNV;
		username = username.trim();
		password = password.trim();
		if (username == "" || password == "")
			return UserStatusEnum.UNV;
		User user = userDao.selectUserByUsername(username);
		if(user != null && user.getPassword().equals(EncodeTools.encoder(password, user.getPassword().substring(0, 4)))) {
				return UserStatusEnum.LS;
		}
		else
			return UserStatusEnum.PI;
	}

	@Override
	public UserStatusEnum Reg(User user) {
		// TODO Auto-generated method stub
		// habit 中文乱码
		if (user == null)
			return UserStatusEnum.UNV;
		else {
			try {
				user.setPassword(EncodeTools.encoder(user.getPassword(),EncodeTools.giveMeSalt()));
				userDao.addUser(user);
				return UserStatusEnum.RS;
			} catch (Exception e) {
				System.out.println(e.getMessage());
				return UserStatusEnum.AUF;
			}
		}
	}

	@Override
	public UserStatusEnum addFriend(String username, String friendUsername, String group) {
		// TODO Auto-generated method stub
		User user1 = userDao.selectUserByUsername(friendUsername.trim());
		User user2 = userDao.selectUserByUsername(friendUsername.trim());
		if (user1 == null || user2 == null || user1 == user2)
			return UserStatusEnum.PNV;
		else {
			try {
				userDao.addFriend(user1.getId(), user2.getId(), group);
			} catch (Exception e) {
				return UserStatusEnum.AFE;
			}
			return UserStatusEnum.AFS;
		}

	}

	@Override
	public User showUserInfo(String username) {
		// TODO Auto-generated method stub
		User user = null;
		try {
			user = userDao.selectUserByUsername(username);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		return user;
	}

}
