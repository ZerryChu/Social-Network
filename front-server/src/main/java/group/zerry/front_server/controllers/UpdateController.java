package group.zerry.front_server.controllers;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.dto.ReturnDataDto;
import group.zerry.front_server.entity.Message;
import group.zerry.front_server.service.MessageService;
import group.zerry.front_server.utils.CookiesData;

/**
 * 
 * @author zhuzirui
 * @content 用于周期更新页面信息，更新cookie内容
 */
@Controller
public class UpdateController {

	@Autowired
	MessageService        messageService;

	@Autowired
	CookiesData           cookiesData;

	private static Logger logger = Logger.getLogger(UpdateController.class);

	/**
	 * 
	 * @param request
	 * @param response
	 * @param username
	 * @param userToken
	 * @return msg: -1 异常  msg： 0 没有新消息 msg： 1有新消息
	 */
	public String updateMessages(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken) {
		try {
			String returnMsg = messageService.show_messages(username, userToken, 1);
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "messages"))) {
				return "{\"msg\" : -1}";
			} else {
				cookiesData.save(request, response, "messages", URLEncoder.encode(returnMsg, "UTF-8"));
				cookie.setValue(URLDecoder.decode(cookie.getValue(), "UTF-8"));
				ReturnDataDto newData = JSON.parseObject(returnMsg, ReturnDataDto.class);
				ReturnDataDto oldData = JSON.parseObject(cookie.getValue(), ReturnDataDto.class);
				// 需要更好的逻辑代码
				if (newData.getReturndata()[0].getId() > oldData.getReturndata()[0].getId()) {
					return "{\"msg\" : 1}";
				} else {
					return "{\"msg\" : 0}";
				}			
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return "{\"msg\" : -1}";
		}
	}

	/**
	 * @content 更新后的信息存入cookies, 并提示用户，您有新的未查看的微博
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update")
	public String update(HttpServletRequest request, HttpServletResponse response, String username, String userToken) {
		return updateMessages(request, response, username, userToken);
	}
}
