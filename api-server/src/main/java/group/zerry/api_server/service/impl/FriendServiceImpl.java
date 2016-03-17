package group.zerry.api_server.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.FriendDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Target;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
import group.zerry.api_server.service.FriendService;
import group.zerry.api_server.utils.CacheTools;

@Service(value = "FriendService")
public class FriendServiceImpl implements FriendService {

	@Autowired
	FriendDao  friendDao;

	@Autowired
	UserDao    userDao;
	
	@Autowired
	CacheTools cacheTools;

	private Logger logger = Logger.getLogger(FriendServiceImpl.class);

	/**
	 * @notice 只显示在线好友
	 * @param username
	 * @param group
	 * @return friendName
	 */
	@Override
	public User[] showFriendsByGroupname(String username, String group) {
		// TODO Auto-generated method stub
		/*  显示在线好友
		try {
			User[] friends = friendDao.selectFriendsByGroupname(username, group);
			ArrayList<String> friendsOnline = new ArrayList<String>();
			for (int i = 0; i < friends.length; i++) {
				if (cacheTools.get(friends[i]) != null) {
					continue;
				} else {
					friendsOnline.add(friends[i]);
				}
			}
			return friendsOnline.toArray(new String[friendsOnline.size()]);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}*/
		User[] friends = friendDao.selectFriendsByGroupname(username, group);
		return friends;
	}

	@Override
	public String[] showGroupsByUsername(String username) {
		// TODO Auto-generated method stub
		try {
			return friendDao.selectGroupsByUsername(username);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
	}

	// 判断双方是否好友关系
	@Override
	public boolean judgeIfFocusOrNot(String username, String targetUsername) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByUsername(username);
		User target = userDao.selectUserByUsername(targetUsername);
		if(friendDao.judgeIfFocusOrNot(user.getId(), target.getId()).getNumber() > 0)
			return true;
		else
			return false;
	}

	/**
	 * 分页  15人一页
	 */
	@Override
	public Target[] showFavorites(String username, int page) {
		// TODO Auto-generated method stub
		int pageSize = 15;
		Target[] favorites = null;
		PageHelperInterceptor.startPage(page, pageSize);
		favorites = friendDao.selectFavorites(username);
		Page<Target> myPage = PageHelperInterceptor.endPage();
		List<Target> list = myPage.getResult();
		favorites = (Target[]) list.toArray(new Target[list.size()]);
		for (int i = 0;i < favorites.length; i++) {
			int target_id = favorites[i].getId();
			Integer integer = userDao.getUserFansNumById(target_id);
			favorites[i].setFriend_num(integer);
			integer = userDao.getUserFocusNumById(target_id);
			favorites[i].setFocus_num(integer);
		}
		return favorites;
	}
	
	/**
	 * 分页  15人一页
	 */
	@Override
	public Target[] showFollowers(String username, int page) {
		// TODO Auto-generated method stub
		int pageSize = 15;
		Target[] followers = null;
		PageHelperInterceptor.startPage(page, pageSize);
		followers = friendDao.selectFollowers(username);
		Page<Target> myPage = PageHelperInterceptor.endPage();
		List<Target> list = myPage.getResult();
		followers = (Target[]) list.toArray(new Target[list.size()]);
		for (int i = 0;i < followers.length; i++) {
			int target_id = followers[i].getId();
			Integer integer = userDao.getUserFansNumById(target_id);
			followers[i].setFriend_num(integer);
			integer = userDao.getUserFocusNumById(target_id);
			followers[i].setFocus_num(integer);
		}
		return followers;
	}

	@Override
	public Target[] showCommonFriendsByTargetUsername(String username, String targetUsername) {
		// TODO Auto-generated method stub
		try {
			Target[] friends = friendDao.selectCommonFriendsByTargerUsername(username, targetUsername);
			return friends;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
	}

}
