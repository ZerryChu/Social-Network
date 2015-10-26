package group.zerry.api_server.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
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
	
	@Override
	public Comment[] showComments(int id, int page) {
		int pageSize = 5;
		Comment[] comments = null;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
		    comments = commentDao.selectCommentsByMessageId(id);
			Page<Comment> myPage = PageHelperInterceptor.endPage();
			List<Comment> list = myPage.getResult();
			comments = (Comment[]) list.toArray(new Comment[list.size()]);
			if(null == comments || comments.length == 0)
				return null;
		} catch(Exception e) {
			return null;
		}
		return comments;
	}
}
