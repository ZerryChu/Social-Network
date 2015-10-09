package group.zerry.api_server.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.service.MessageService;

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
}
