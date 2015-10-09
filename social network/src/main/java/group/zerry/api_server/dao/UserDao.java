package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.User;

@Repository
public interface UserDao {
	public User selectUserByUsername(String username);
	
	public User selectUserByNickname(String nickname);
	
	public void addUser(User user);
	
	public User[] selectFriendsByUsername(String username);
	
	public void addFriend(int id, int friendId, String group);
	
	public String[] selectFriendsNicknameByUserNickname(String nickname);
}
