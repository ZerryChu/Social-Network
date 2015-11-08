package group.zerry.api_server.service.impl;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.FriendDao;
import group.zerry.api_server.entity.Friend;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.service.FriendService;
import group.zerry.api_server.utils.CacheTools;

@Service(value = "FriendService")
public class FriendServiceImpl implements FriendService {

	@Autowired
	FriendDao friendDao;

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
	public String[] showFriendsByGroupname(String username, String group) {
		// TODO Auto-generated method stub
		try {
			String[] friends = friendDao.selectFriendsByGroupname(username, group);
			ArrayList<String> friendsOnline = new ArrayList<String>();
			for (int i = 0; i < friends.length; i++) {
				/*
				 * if(cacheTools.get(friends[i]) == null) { continue; } else {
				 * friendsOnline.add(friends[i]); }
				 * 测试注掉！ 
				 * 
				 */
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
		}
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

}
