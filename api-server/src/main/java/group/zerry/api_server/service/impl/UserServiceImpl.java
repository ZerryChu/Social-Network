package group.zerry.api_server.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import group.zerry.api_server.dao.FriendDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Friend;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.UserStatusEnum;
import group.zerry.api_server.service.UserService;
import group.zerry.api_server.utils.EncodeTools;
import group.zerry.api_server.utils.Recommender;
/**
 * @author ZerryChu
 * @since  2015.10.3
 *
 */
@Service(value = "UserService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao               userDao;

	@Autowired
	private FriendDao             friendDao;
	
	@Autowired
	private Recommender           recommender;
	
	private static Logger         logger = Logger.getLogger(UserServiceImpl.class);
	
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
		if (user == null)
			return UserStatusEnum.UNV;
		else {
			try {
				User temp = userDao.selectUserByUsername(user.getUsername());
				if(temp != null) {
					return UserStatusEnum.UE;
				}
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
		User user1 = userDao.selectUserByUsername(username.trim());
		User user2 = userDao.selectUserByUsername(friendUsername.trim());
		if (user1 == null || user2 == null || user1 == user2)
			return UserStatusEnum.PNV;
		else {
			try {
				userDao.addFriend(user1.getId(), user2.getId(), group);
				//userDao.addFriend(user2.getId(), user1.getId(), group);
			} catch (Exception e) {
				System.out.println(e.getMessage());
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

	@Override
	public User showTargetInfoByNickname(String nickname) {
		// TODO Auto-generated method stub
		User user = null;
		try {
			user = userDao.selectUserByNickname(nickname);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		return user;
	}

	@Override
	public UserStatusEnum deleteFriend(String username, String friendUsername) {
		// TODO Auto-generated method stub
		User user1 = userDao.selectUserByUsername(username.trim());
		User user2 = userDao.selectUserByUsername(friendUsername.trim());
		if (user1 == null || user2 == null || user1 == user2)
			return UserStatusEnum.PNV;
		else {
			try {
				userDao.deleteFriend(user1.getId(), user2.getId());
				//userDao.addFriend(user2.getId(), user1.getId(), group);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				return UserStatusEnum.DFE;
			}
			return UserStatusEnum.DFS;
		}
	}

	@Override
	public User[] showRecommendedUsers(String username) {
		User user = userDao.selectUserByUsername(username);
		long[] recs = recommender.getRecommendedUser(user.getId(), 10);
		User[] users = new User[4];
		if (recs.length <= 4) {
			for (int i = 0;i < 4; i++) {
				users[i] = userDao.selectUserById((int)recs[i]);
			}
		} else {
			Random random = new Random();
			int index = 0;
			int flag[] = new int[recs.length];
			for (int i = 0;i < flag.length; i++)
				flag[i] = 0; // 初始话
			for (int i = 0;i < 4; i++) {
				index = 0;
				while(index == 0) {
					int num = random.nextInt(recs.length);
					if (flag[num] == 0) {
						flag[num] = 1;
						index = num;
					} else {
						continue;
					}
				}
				users[i] = userDao.selectUserById((int)recs[index]);
			}
		}
		return users;
			
	}
	
	/*
	@Override
	public Friend[] showFriendsByNickname(String nickname) {
		// TODO Auto-generated method stub
		Friend[] friends = null;
		try {
			friends = friendDao.selectFriendsByNickname(nickname);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		return friends;
	}
	*/
}
