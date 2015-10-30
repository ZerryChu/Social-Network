package group.zerry.api_server.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.CommentStatusEnum;
import group.zerry.api_server.enumtypes.UserStatusEnum;
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
	CommentDao            commentDao;
	
	@Autowired
	UserDao               userDao;
	
	@Autowired
	MessageDao            messageDao;
	
	private static Logger logger = Logger.getLogger(CommentServiceImpl.class);
	
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

	@Override
	public CommentStatusEnum delete_comment(String username, String nickname, int message_id, int id) {
		// TODO Auto-generated method stub
		try {
			User user = userDao.selectUserByNickname(nickname);
			if(null == user.getUsername() || !user.getUsername().equals(username)) {
				return CommentStatusEnum.UAF;
			}
			commentDao.deleteComment(nickname, id);
			//messageDao.decreaseCommentTimes(message_id);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return CommentStatusEnum.DCF;
		}
		return CommentStatusEnum.OS;
	}
}
