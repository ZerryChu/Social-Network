package group.zerry.api_server.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.xml.crypto.Data;

import org.codehaus.jackson.map.util.Comparators;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.PrivateMsgDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.PrivateMsg;
import group.zerry.api_server.entity.PrivateMsgInfo;
import group.zerry.api_server.entity.User;
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
			if(hotMessage.isHas_read() == false)
				has_noRead = true;
			User target = userDao.selectUserById(idList[i]);
			PrivateMsgInfo privateMsgInfo = new PrivateMsgInfo();
			privateMsgInfo.setTargetUsername(target.getUsername());
			privateMsgInfo.setTargetId(idList[i]);
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
					return new Date(o1.getTime()).compareTo(new Date(o2.getTime()));
				}
			}
			
		});
		return privateMsgInfoList;
	}
	

}
