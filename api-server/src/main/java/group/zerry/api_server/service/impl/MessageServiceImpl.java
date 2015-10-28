package group.zerry.api_server.service.impl;

import java.util.List;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
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
			messageDao.deleteMessageById(id);
			userDao.decreaseMessage_numByUsername(username);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return MessageStatusEnum.DMF;
		}
		return MessageStatusEnum.DMS;
	}

	//分页
	@Override
	public Message[] show_messages(String username, int page) {
		// TODO Auto-generated method stub
		int pageSize = 10;
		Message[] message = null;
		try {
			String[] friend = null;
			friend = userDao.selectFriendsNicknameByUsername(username);
			if(null == friend || 0 == friend.length) {
				return null;
			}
			PageHelperInterceptor.startPage(page, pageSize);
			message = messageDao.getMessages(friend);
			Page<Message> myPage = PageHelperInterceptor.endPage();
			List<Message> list = myPage.getResult();
			message = (Message[]) list.toArray(new Message[list.size()]);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
		return message;
	}

	@Override
	public MessageStatusEnum addRepost(String username, int id) {
		// TODO Auto-generated method stub
		try {
			User user = userDao.selectUserByUsername(username);
			Message message = messageDao.getMessageById(id);
			message.setAuthor(user.getNickname());
			message.setType(2);
			messageDao.addMessage(message);
			messageDao.addRepostTimes(id);
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.RS;
	}

	@Override
	public MessageStatusEnum addComment(String username, String content, int id) {
		// TODO Auto-generated method stub
		try {
			String nickname = userDao.selectUserByUsername(username).getNickname();
			Comment comment = new Comment();
			comment.setNickname(nickname);
			comment.setContent(content);
			comment.setMessage_id(id);
			commentDao.addComment(comment);
			messageDao.addCommentTimes(id);
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.CS;
	}

	@Override
	public MessageStatusEnum addSupport(String username, int id) {
		// TODO Auto-generated method stub
		try {
			int num = messageDao.findIfSupportedByUsername(username, id).getNumber();
			if(num > 1 || num < 0) {
				return MessageStatusEnum.OF;
			}
			else if(num == 1)
				return MessageStatusEnum.HAS;
			messageDao.addSupportInfo(id, username);
			messageDao.addSupportTimes(id);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.SS;
		
	}

	@Override
	public MessageStatusEnum decreaseSupport(String username, int id) {
		// TODO Auto-generated method stub
		try {
			int num = messageDao.findIfSupportedByUsername(username, id).getNumber();
			if(num == 0) {
				return MessageStatusEnum.HNS;
			}
			if(num > 1 || num < 0)
				return MessageStatusEnum.OF;
			messageDao.decreaseSupportInfo(id, username);
			messageDao.decreaseSupportTimes(id);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.OS;
	}
	
	@Override
	public Message[] show_ownMessages(String nickname, int page) {
		// TODO Auto-generated method stub
		int pageSize = 10;
		Message[] message = null;
		try {
			//User user = userDao.selectUserByUsername(username);
			PageHelperInterceptor.startPage(page, pageSize);
			message = messageDao.getOwnMessages(nickname);
			Page<Message> myPage = PageHelperInterceptor.endPage();
			List<Message> list = myPage.getResult();
			message = (Message[]) list.toArray(new Message[list.size()]);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
		return message;
	}

	@Override
	public Message[] show_announcements() {
		// TODO Auto-generated method stub
		Message[] message = null;
		try {
			//User user = userDao.selectUserByUsername(username);
			message = messageDao.getAnnouncements();
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
		return message;
	}

	/**
	 * 
	 * @param username
	 * @param id
	 * @return true: 可以点赞 false： 无法点赞
	 */
	@Override
	public boolean judgeIfSupport(String username, int id) {
		// TODO Auto-generated method stub
		Count count = messageDao.findIfSupportedByUsername(username, id);
		int num = count.getNumber();
		if(num > 1 || num < 0 || num == 1)
			return false;
		return true;
	}

}
