package group.zerry.api_server.service.impl;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.FriendDao;
import group.zerry.api_server.service.FriendService;

@Service(value = "FriendService")
public class FriendServiceImpl implements FriendService{

	@Autowired
	FriendDao      friendDao;
	
	private Logger logger = Logger.getLogger(FriendServiceImpl.class);

	@Override
	public String[] showFriendsByGroupname(String username, String group) {
		// TODO Auto-generated method stub
		try {
			return friendDao.selectFriendsByGroupname(username, group);
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
