package group.zerry.api_server.controllers;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import group.zerry.api_server.dao.MessageDao;
import group.zerry.api_server.entity.Message;
import group.zerry.api_server.interceptors.PageHelperInterceptor;
import group.zerry.api_server.interceptors.PageHelperInterceptor.Page;

@Controller
@RequestMapping(value="/check")
public class CheckPageHelperInterceptor {
	@Autowired
	MessageDao messageDao;
	/*public PageHelperInterceptor.Page<MessageDao> findSysLoginLog(String nickname, int pageNumber) throws Exception {
		int pageSize = 2;
		PageHelperInterceptor.startPage(pageNumber, pageSize);
		messageDao.getOwnMessages(nickname);
		return PageHelperInterceptor.endPage();
	}
	*/
	@RequestMapping(value = "/message", produces = "text/html;charset=UTF-8")
	public void show(String nickname, int pageNumber) {
		int pageSize = 3;
		PageHelperInterceptor.startPage(pageNumber, pageSize);
		messageDao.getOwnMessages(nickname);
		Page myPage = PageHelperInterceptor.endPage();
		System.out.println(myPage.toString());
		List<Message> list = myPage.getResult();
		Iterator<Message> iterator = list.iterator();
		while(iterator.hasNext()) {
			System.out.println(iterator.next().getContent());
		}
	}
}
