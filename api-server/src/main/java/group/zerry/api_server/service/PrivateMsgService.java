package group.zerry.api_server.service;

import java.util.List;

import group.zerry.api_server.entity.PrivateMsg;
import group.zerry.api_server.entity.PrivateMsgInfo;
import group.zerry.api_server.enumtypes.PrivateMsgStatusEnum;

public interface PrivateMsgService {
	/*
	public int getMessagesCount(int id1, int id2);
	
	public int[] getAllIdTalkedToUser(int id);
	*/
	
	public PrivateMsg[] getPrivateMsg(String username, String targetUsername);
	
	public List<PrivateMsgInfo> getALLPrivateMsgList(String username);
	
	public PrivateMsgStatusEnum addPrivateMessage(String username, String targetUsername, String content);
	
	public PrivateMsgStatusEnum readPrivateMsg(String username ,String targetUsername);
}
