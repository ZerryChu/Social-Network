package group.zerry.front_server.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.service.MessageService;
import group.zerry.front_server.utils.CookiesData;

@Controller
@RequestMapping(value = "/message")
public class MessageController {

	@Autowired
	MessageService messageService;

	@Autowired
	CookiesData cookiesData;

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String post_message(String username, String userToken, String content, int type, MultipartFile pic) throws IOException {
		// 加入判断文件大小，后缀的逻辑
		if (messageService.send_message(username, userToken, content, type, pic))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String delete_message(String username, String userToken, int id) {
		if (messageService.delete_message(username, userToken, id))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}

	/**
	 * @return 1:点赞成功 0：操作异常 2：已点过赞
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/support", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String addSupportTimes(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"msg\": ");
		regMsg.append(messageService.addSupportTimes(username, userToken, id) + "}");
		return regMsg.toString();
	}

	/**
	 * @return 1:取消点赞成功 0：操作异常 2：没有点过赞
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/_support", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String decreaseSupportTimes(String username, String userToken, int id) {
		StringBuilder regMsg = new StringBuilder("{\"msg\": ");
		regMsg.append(messageService.decreaseSupportTimes(username, userToken, id) + "}");
		return regMsg.toString();
	}

	/**
	 * 有缓存show
	 * 
	 * @param flag：0
	 *            无更新查询 1 有更新查询
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_messages(HttpServletRequest request, HttpServletResponse response, String username,
			String userToken, int page, int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "messages"))) {
				String returnMsg = messageService.show_messages(username, userToken, page);
				cookiesData.save(request, response, "messages", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = messageService.show_messages(username, userToken, page);
			if (page == 1)
				cookiesData.save(request, response, "messages", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/show_announcements", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_announcements(HttpServletRequest request, HttpServletResponse response, int flag)
			throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "announcements"))) {
				String returnMsg = messageService.show_announcement();
				cookiesData.save(request, response, "announcements", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = messageService.show_announcement();
			cookiesData.save(request, response, "announcements", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/show_ownmessages", produces = "text/html;charset=UTF-8")
	public String show_ownMessages(HttpServletRequest request, HttpServletResponse response, String nickname, int page,
			int flag) throws UnsupportedEncodingException {
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, "ownmessages"))) {
				String returnMsg = messageService.show_userOwnMessages(nickname, page);
				cookiesData.save(request, response, "ownmessages", URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = messageService.show_userOwnMessages(nickname, page);
			cookiesData.save(request, response, "ownmessages", URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/judge_ifsupport", produces = "text/html;charset=UTF-8")
	public String judgeIfSupported(HttpServletRequest request, HttpServletResponse response, String username,
			int message_id, String userToken, int flag) throws UnsupportedEncodingException {
		String cookieName = "ifSupport" + message_id;
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, cookieName))) {
				String returnMsg = messageService.judgeIfSupport(username, message_id, userToken);
				cookiesData.save(request, response, cookieName, URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = messageService.judgeIfSupport(username, message_id, userToken);
			cookiesData.save(request, response, cookieName, URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/comment", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String send_comment(String username, String userToken, int id, String content) {
		if (messageService.send_comment(username, userToken, id, content))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/repost", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String repost_message(String username, String userToken, String content, int id) {
		if (messageService.add_repost(username, userToken, content, id))
			return "{\"msg\" : 1}";
		else
			return "{\"msg\" : 0}";
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/show_message", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	public String show_messageById(HttpServletRequest request, HttpServletResponse response, String username, String userToken, int message_id, int flag) throws UnsupportedEncodingException {
		String cookieName = "MessageInfoById" + message_id;
		if (flag == 0) {
			Cookie cookie;
			if (null == (cookie = cookiesData.getCookie(request, cookieName))) {
				String returnMsg = messageService.show_messageById(username, userToken, message_id);
				cookiesData.save(request, response, cookieName, URLEncoder.encode(returnMsg, "UTF-8"));
				return returnMsg;
			} else {
				String returnMsg = cookie.getValue();
				returnMsg = URLDecoder.decode(returnMsg, "UTF-8");
				return returnMsg;
			}
		} // 无更新查询
		else {
			String returnMsg = messageService.show_messageById(username, userToken, message_id);
			//cookiesData.save(request, response, cookieName, URLEncoder.encode(returnMsg, "UTF-8"));
			return returnMsg;
		}
	}
}
