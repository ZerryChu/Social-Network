package group.zerry.api_server.service.impl;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.service.MessageService;

/**
 * @author ZerryChu
 * @since  2015.10.3
 *
 */
@Service(value = "MessageService")
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageDao messageDao;

	@Autowired
	CommentDao commentDao;
	@Autowired
	UserDao userDao;
	
	private Logger logger = Logger.getLogger(MessageServiceImpl.class);
	
	@Override
	public MessageStatusEnum send_message(String username, String content, int type) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByUsername(username);
		Message message = new Message();
		message.setAuthor(user.getNickname());
		message.setContent(content);
		message.setType(type);
		try {
			messageDao.addMessage(message);
			userDao.addMessage_numByUsername(username); //发微博数+1
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.AMF;
		}
		return MessageStatusEnum.AMS;
	}

	@Override
	public MessageStatusEnum delete_message(String username, int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.deleteMessageByID(id);
			userDao.decreaseMessage_numByUsername(username);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.DMF;
		}
		return MessageStatusEnum.DMS;

	}

	//分页
	@Override
	public Message[] show_messages(String username, int type) {
		// TODO Auto-generated method stub
		Message[] message = null;
		try {
			String[] friend = null;
			friend = userDao.selectFriendsNicknameByUsername(username);
			if(null == friend || 0 == friend.length) {
				return null;
			}
			message = messageDao.getMessages(friend);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		return message;
	}

	@Override
	public MessageStatusEnum addRepostTimes(String username, int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.addRepostTimes(id);
			Message message = messageDao.getMessageById(id);
			message.setAuthor(username);
			messageDao.addMessage(message);
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.RS;
		
	}

	//check
	@Override
	public MessageStatusEnum addComment(String username, String content, int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.addCommentTimes(id);
			String nickname = userDao.selectUserByUsername(username).getNickname();
			Comment comment = new Comment();
			comment.setNickname(nickname);
			comment.setContent(content);
			comment.setMessage_id(id);
			commentDao.addComment(comment);
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.CS;
	}

	@Override
	public MessageStatusEnum addSupportTimes(String username, int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.addSupportTimes(id);
			// 待考量： 限制个人点赞次数
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.SS;
		
	}

}
