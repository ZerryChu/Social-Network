package group.zerry.api_server.entity;

/*
 * 朋友关系实体
 * 弃用
 */
public class Friend {
	private String user_id;
	private String friend_id;
	private String groupname;
	private boolean isOnLine;
	
	public boolean isOnLine() {
		return isOnLine;
	}
	
	public void setOnLine(boolean isOnLine) {
		this.isOnLine = isOnLine;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFriend_id() {
		return friend_id;
	}
	public void setFriend_id(String friend_id) {
		this.friend_id = friend_id;
	}
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
}
