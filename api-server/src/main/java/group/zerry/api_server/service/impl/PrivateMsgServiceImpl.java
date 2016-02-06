package group.zerry.api_server.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.xml.crypto.Data;

import org.apache.log4j.lf5.util.DateFormatManager;
import org.codehaus.jackson.map.util.Comparators;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.PrivateMsgDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.PrivateMsg;
import group.zerry.api_server.entity.PrivateMsgInfo;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.PrivateMsgStatusEnum;
import group.zerry.api_server.service.PrivateMsgService;

@Service(value="PrivateMsgService")
public class PrivateMsgServiceImpl implements PrivateMsgService {

	@Autowired
	UserDao       userDao;
	
	@Autowired
	PrivateMsgDao privateMsgDao;
	/*
	@Override
	public int getMessagesCount(int id1, int id2) {
		// TODO Auto-generated method stub
		Count count = privateMsgDao.getMessagesCount(id1, id2);
		return count.getNumber();
	}
	
	@Override
	public int[] getAllIdTalkedToUser(int id) {
		// TODO Auto-generated method stub
		int[] idList = privateMsgDao.selectAllIdTalkedToUser(id);
		return idList;
	}
	*/
	@Override
	public List<PrivateMsgInfo> getALLPrivateMsgList(String username) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByUsername(username);
		int id = user.getId();
		Integer[] idList = privateMsgDao.selectAllIdTalkedToUser(id);
		List<PrivateMsgInfo> privateMsgInfoList = new ArrayList<PrivateMsgInfo>();
		for(int i = 0;i < idList.length; i++) {
			boolean has_noRead = false;
			int count = privateMsgDao.getMessagesCount(id, idList[i]).getNumber();
			PrivateMsg hotMessage = privateMsgDao.getHotMsg(id, idList[i]);
			if (hotMessage != null && hotMessage.isHas_read() == false)
				has_noRead = true;
			User target = userDao.selectUserById(idList[i]);
			System.out.println(idList[i]);
			PrivateMsgInfo privateMsgInfo = new PrivateMsgInfo();
			privateMsgInfo.setTargetUsername(target.getUsername());
			privateMsgInfo.setTargetId(idList[i]);
			if (hotMessage != null)
				privateMsgInfo.setTime(hotMessage.getTime());
			privateMsgInfo.setTargetNickname(target.getNickname());
			privateMsgInfo.setHas_noRead(has_noRead);
			privateMsgInfo.setCount(count);
			privateMsgInfoList.add(privateMsgInfo);
		}
		// 排序，未读的消息排前，其次，时间越近的消息排越前
		Collections.sort(privateMsgInfoList, new Comparator<PrivateMsgInfo>() {

			@Override
			public int compare(PrivateMsgInfo o1, PrivateMsgInfo o2) {
				// TODO Auto-generated method stub
				if (o1.isHas_noRead() == true && o2.isHas_noRead() == false) {
					return -1;
				} else if(o2.isHas_noRead() == true && o1.isHas_noRead() == false) {
					return 1;
				} else {
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					try {
						if (o1.getTime() == null) {
							return 1;
						}
						if (o2.getTime() == null) {
							return -1;
						}
						Date date1 = sf.parse(o1.getTime());
						Date date2 = sf.parse(o2.getTime());
						if (date1.compareTo(date2) < 0)
							return 1;
						else
							return -1;
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						return -1;
					}
				}
			}
			
		});
		return privateMsgInfoList;
	}
	
	@Override
	public PrivateMsg[] getPrivateMsg(String username, String targetUsername) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByUsername(username);
		User target = userDao.selectUserByUsername(targetUsername);
		PrivateMsg[] msg = privateMsgDao.getMsg(user.getId(), target.getId());
		for(int i = 0;i < msg.length; i++) {
			if (msg[i].getSdr_id() == target.getId()) {
				msg[i].setIs_target(true);
			} else {
				msg[i].setIs_target(false);
			}
		}
		return msg;
	}
	
	@Override
	public PrivateMsgStatusEnum addPrivateMessage(String username, String targetUsername, String content) {
		// TODO Auto-generated method stub
		try {
			User user = userDao.selectUserByUsername(username);
			User target = userDao.selectUserByUsername(targetUsername);
			privateMsgDao.insertPrivateMessage(user.getId(), target.getId(), content);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return PrivateMsgStatusEnum.AMF;
		}
		return PrivateMsgStatusEnum.AMS;
	}

	@Override
	public PrivateMsgStatusEnum readPrivateMsg(String username, String targetUsername) {
		// TODO Auto-generated method stub
		try {
			User user = userDao.selectUserByUsername(username);
			User target = userDao.selectUserByUsername(targetUsername);
			privateMsgDao.readPrivateMsg(user.getId(), target.getId());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return PrivateMsgStatusEnum.RMF;
		}
		return PrivateMsgStatusEnum.RMS;
	}
	

}
