package group.zerry.api_server.entity;

/**
 * 
 * @author  zhuzirui
 * @content 私信信息（与用户交流的用户的用户名，私信数量， 是否有新消息）
 * @version 1.0
 * @since   2015.12.12
 *
 */
public class PrivateMsgInfo {
	private int     targetId;
	private String  targetUsername;
	private String  targetNickname; //与用户交流的用户的用户名
	private boolean has_noRead;// 是否有未读消息
	private int     count;   // 私信总数
	private String  time;    // 最后一条交流的时间
	
	public String getTargetUsername() {
		return targetUsername;
	}
	public void setTargetUsername(String targetUsername) {
		this.targetUsername = targetUsername;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getTargetId() {
		return targetId;
	}
	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}
	public String getTargetNickname() {
		return targetNickname;
	}
	public void setTargetNickname(String targetNickname) {
		this.targetNickname = targetNickname;
	}
	public boolean isHas_noRead() {
		return has_noRead;
	}
	public void setHas_noRead(boolean has_noRead) {
		this.has_noRead = has_noRead;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
