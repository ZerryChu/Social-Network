package group.zerry.api_server.entity;

/**
 * 关注对象或者被关注对象
 */
public class Target {
	private String username;
	private String nickname;
	private int    id;
	private int    friend_num;
	private int    focus_num;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFriend_num() {
		return friend_num;
	}
	public void setFriend_num(int friend_num) {
		this.friend_num = friend_num;
	}
	public int getFocus_num() {
		return focus_num;
	}
	public void setFocus_num(int focus_num) {
		this.focus_num = focus_num;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

}
