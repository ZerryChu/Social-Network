package group.zerry.api_server.dao;

import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.PrivateMsg;

public interface PrivateMsgDao {
	/**
	 * @content 用户1和用户2之间的消息总数
	 */
	public Count getMessagesCount(int id1, int id2);
	
	/**
	 * @content 获取所有和用户有过私信交流的id（建立私信列表）
	 */
	public Integer[] selectAllIdTalkedToUser(int id);
	
	/**
	 * @content 用户1与用户2对话的最新消息
	 */
	public PrivateMsg getHotMsg(int id1, int id2);
	
	public PrivateMsg[] getMsg(int id1, int id2);
	
	public void readPrivateMsg(int id1, int id2);
	
	public void insertPrivateMessage(int id1, int id2, String content);
	
}
