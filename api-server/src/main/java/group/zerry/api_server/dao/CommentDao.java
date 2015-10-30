package group.zerry.api_server.dao;

import org.springframework.stereotype.Repository;

import group.zerry.api_server.entity.Comment;

/**
 * @author ZerryChu
 * @content 微博帖子评论Dao
 * 
 */
@Repository
public interface CommentDao {

	public Comment[] selectCommentsByMessageId(int id);
	
	public void addComment(Comment comment);
	
	public void deleteComment(String nickname, int id);
}
