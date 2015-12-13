package group.zerry.api_server.service;

import java.util.List;

import group.zerry.api_server.entity.PrivateMsgInfo;

public interface PrivateMsgService {
	/*
	public int getMessagesCount(int id1, int id2);
	
	public int[] getAllIdTalkedToUser(int id);
	*/
	public List<PrivateMsgInfo> getALLPrivateMsgList(String username);
}
