package group.zerry.front_server.service;

public interface PrivateMsgService {
	public String getALLPrivateMsgList(String username, String userToken);

	public String getMsg(String username, String userToken, String targetUsername);
	
	public String addPrivateMessage(String username, String userToken, String targetUsername, String content);
	
	public String readPrivateMessage(String username, String userToken, String targetUsername);
}
