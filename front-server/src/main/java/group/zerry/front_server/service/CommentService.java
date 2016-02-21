package group.zerry.front_server.service;

public interface CommentService {
	public String show_comments(int id, int page);
	
	public boolean delete_comment(String username, String userToken, String nickname, int message_id, int id);
	
	public boolean insertCommentByTopicId(String username, String userToken, String comment, int topic_id);
}
