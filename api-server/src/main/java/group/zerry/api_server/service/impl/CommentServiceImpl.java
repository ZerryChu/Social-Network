package group.zerry.api_server.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.service.CommentService;

/**
 * 
 * @author ZerryChu
 * @since 2015 10 13 12:50am
 * @version 1.0
 */
@Service(value = "CommentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentDao commentDao;
	
	// 分页
	@Override
	public Comment[] showComments(int id) {
		Comment[] comments = null;
		try {
		    comments = commentDao.selectCommentsByMessageId(id);
			if(null == comments || comments.length == 0)
				return null;
		} catch(Exception e) {
			return null;
		}
		return comments;
	}
}
