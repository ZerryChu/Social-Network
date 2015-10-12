package group.zerry.api_server.service.impl;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.AMF;
		}
		return MessageStatusEnum.AMS;
	}

	@Override
	public MessageStatusEnum delete_message(int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.deleteMessageByID(id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.DMF;
		}
		return MessageStatusEnum.DMS;

	}

	//分页
	@Override
	public Message[] show_messages(String nickname, int type) {
		// TODO Auto-generated method stub
		Message[] message = null;
		try {
			String[] friend = null;
			friend = userDao.selectFriendsNicknameByUserNickname(nickname);
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

	@Override
	public MessageStatusEnum addComment(String username, String content, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MessageStatusEnum addSupportTimes(String username, int id) {
		// TODO Auto-generated method stub
		try {
			messageDao.addSupportTimes(id);
		} catch(Exception e) {
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.SS;
		
	}

}
