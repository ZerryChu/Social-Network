package group.zerry.api_server.service;

import group.zerry.api_server.entity.Comment;

public interface CommentService {
	
	public Comment[] showComments(int id, int page);
	
}
