package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.User;

@Repository
public interface UserDao {
	public User selectUserByUsername(String username);
	
	public void addUser(User user);
}
