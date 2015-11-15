package group.zerry.api_server.entity;

/**
 * 关注对象或者被关注对象
 */
public class Target {
	private String username;
	private String nickname;
	private int    friend_num;
	
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
	public int getFriend_num() {
		return friend_num;
	}
	public void setFriend_num(int friend_num) {
		this.friend_num = friend_num;
	}

}
