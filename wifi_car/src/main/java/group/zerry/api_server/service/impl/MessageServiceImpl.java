package group.zerry.api_server.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.enumtypes.MessageStatusEnum;
import group.zerry.api_server.service.MessageService;

@Service(value="MessageService")
public class MessageServiceImpl implements MessageService{
		
	@Autowired
	MessageDao messageDao;
	
	@Override
	public MessageStatusEnum send_message(Message message) {
		// TODO Auto-generated method stub
		if(message == null)
			return MessageStatusEnum.MNE;
		else {
			try {
				messageDao.addMessage(message);
			} catch (Exception e) {
				return MessageStatusEnum.AMF;
			}
			return MessageStatusEnum.AMS;
		}
	}
	
	@Override
	public MessageStatusEnum delete_message(int id) {
		// TODO Auto-generated method stub
			try {
				messageDao.deleteMessageByID(id);
			} catch (Exception e) {
				return MessageStatusEnum.DMF;
			}
			return MessageStatusEnum.DMS;
		
	}
	
	//check
	@Override
	public Message[] show_message(String username, int type, int page) {
		// TODO Auto-generated method stub
		return null;
	}
}
