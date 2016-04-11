package group.zerry.api_server.entity;

/**
 * @author  Zerry
 * @version 2.0
 * @content 用户实体
 * 
 */
public class User {
	private int     id;
	private String  nickname;
	private int     age;
	private String  username;
	private String  password;
	private int     type;
	private String  habit;
	private int     friend_num;
	private int     focus_num;
	private int     message_num;
	private boolean isFriend;

	public boolean isFriend() {
		return isFriend;
	}
	public void setFriend(boolean isFriend) {
		this.isFriend = isFriend;
	}
	public int getFocus_num() {
		return focus_num;
	}
	public void setFocus_num(int focus_num) {
		this.focus_num = focus_num;
	}	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getHabit() {
		return habit;
	}
	public void setHabit(String habit) {
		this.habit = habit;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getFriend_num() {
		return friend_num;
	}
	public void setFriend_num(int friend_num) {
		this.friend_num = friend_num;
	}
	public int getMessage_num() {
		return message_num;
	}
	public void setMessage_num(int message_num) {
		this.message_num = message_num;
	}
	
}
