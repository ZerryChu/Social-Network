package group.zerry.api_server.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.hamcrest.core.IsNot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import group.zerry.api_server.dao.CommentDao;
import group.zerry.api_server.dao.LabelDao;
import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.dao.TopicDao;
import group.zerry.api_server.dao.UserDao;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.entity.Count;
import group.zerry.api_server.entity.Label;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.entity.Topic;
import group.zerry.api_server.entity.User;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;
import group.zerry.api_server.service.MessageService;
import group.zerry.api_server.utils.BatchHandleWrapperForLabel;

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
	UserDao    userDao;
	
	@Autowired
	LabelDao   labelDao;
	
	@Autowired
	TopicDao   topicDao;
	
	@Autowired
	private BatchHandleWrapperForLabel batchHandleWrapperForLabel;
	
	private Logger logger = Logger.getLogger(MessageServiceImpl.class);
	
	@Override
	public MessageStatusEnum send_message(String username, String content, int type, String pic, String label) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByUsername(username);
		Message message = new Message();
		message.setAuthor(user.getNickname());
		if(pic != null) {
			message.setPic(pic);
		} else {
			message.setPic("");
		}
		message.setContent(content);
		message.setType(type);
		if (label != null) {
			Count count = labelDao.judgeIfLabelExists(label);
			int id;
			if (count.getNumber() == 0) {
				labelDao.insertNewLabel(label);
			} 
			id = labelDao.searchLabelIdByName(label);
			labelDao.updateLabelHeatById(user.getId(), id);
			message.setLabel(id);
		}
		try {
			messageDao.addMessage(message);
			//userDao.addMessage_numByUsername(username); //发微博数+1
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
			//userDao.decreaseMessage_numByUsername(username);
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
		int pageSize = 5;
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

	/**
	 *  转发微博
	 *  message.content: 用户说的话；原微博id
	 */
	@Override
	public MessageStatusEnum addRepost(String username, String _content, int id) {
		// TODO Auto-generated method stub
		try {
			User user = userDao.selectUserByUsername(username);
			Message message = messageDao.getMessageById(id);
			if(message.getType() == 1) {
				message.setContent(_content + ";" + id);
				message.setAuthor(user.getNickname());
				//setPic()
				message.setType(2);
			} else {
				message.setContent( _content + " || " + message.getAuthor() + ":"  + message.getContent());
				message.setAuthor(user.getNickname());
			}
			messageDao.addMessage(message);
			messageDao.addRepostTimes(id);
			addLabelHeat(username, id, 50);
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return MessageStatusEnum.OF;
		}
		return MessageStatusEnum.RS;
	}

	/**
	 *  评论
	 */
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
			addLabelHeat(username, id, 50);
			//messageDao.addCommentTimes(id);
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
			addLabelHeat(username, id, 50);
			//messageDao.addSupportTimes(id);
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
			//messageDao.decreaseSupportTimes(id);
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

	@Override
	public Message show_messageById(int message_id) {
		// TODO Auto-generated method stub
		return messageDao.getMessageById(message_id);
	}

	@Override
	public void addLabelHeat(String username, long id, int timeoutMS) {
		// TODO Auto-generated method stub
		int label_id = labelDao.searchLabelIDByMsgId(id);
		if (label_id == 0) {
			return;
		}
		User user = userDao.selectUserByUsername(username);
		batchHandleWrapperForLabel.add(user.getId(), label_id, 50);
	}

	@Override
	public Message[] show_messagesByLabel(int label_id, int page) {
		// TODO Auto-generated method stub
		int pageSize = 5;
		Message[] message = null;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
			message = messageDao.getMessagesByLabel(label_id);
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
	public Message[] showMessagesByLabelAndHeat(int label_id, int page) {
		// TODO Auto-generated method stub
		int pageSize = 5;
		Message[] message = null;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
			message = messageDao.getMessagesByLabelAndHeat(label_id);
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
	public Message[] showWeiboByTopicId(int topic_id, int page) {
		// TODO Auto-generated method stub
		int pageSize = 2;
		Message[] message = null;
		try {
			PageHelperInterceptor.startPage(page, pageSize);
			Topic topic = topicDao.selectTopicById(topic_id);
			message = messageDao.selectWeiboByTopicName("#" + topic.getName() + "#");
			Page<Message> myPage = PageHelperInterceptor.endPage();
			List<Message> list = myPage.getResult();
			message = (Message[]) list.toArray(new Message[list.size()]);
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
		return message;
	}

	
}
