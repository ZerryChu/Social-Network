package group.zerry.api_server.service;

import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.enumtypes.CommentStatusEnum;

public interface CommentService {
	
	public Comment[] showComments(int id, int page);
	
	public CommentStatusEnum delete_comment(String username, String nickname, int message_id, int id);
	
	public CommentStatusEnum insertCommentByTopicId(String username, String comment, int topic_id);
}
