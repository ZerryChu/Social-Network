package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.User;

@Repository
public interface UserDao {
	public User selectUserByUsername(String username);
	
	public User selectUserByNickname(String nickname);
	
	public void addUser(User user);
	
	//public User[] selectFriendIdByUsername(String username);
		
	public void addFriend(int id, int friendId, String group);
	
	public String[] selectFriendsNicknameByUsername(String nickname);
	
	public void addMessage_numByUsername(String username);
	
	public void decreaseMessage_numByUsername(String username);
	
	public void addFriend_numByUsername(String username);

}
