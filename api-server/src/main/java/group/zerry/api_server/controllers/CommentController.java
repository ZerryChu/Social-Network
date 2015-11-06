package group.zerry.api_server.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import group.zerry.api_server.annotation.AuthPass;
import group.zerry.api_server.entity.Comment;
import group.zerry.api_server.enumtypes.CommentStatusEnum;
import group.zerry.api_server.service.CommentService;

/**
 * @author ZerryChu
 * @since 2015 10 3
 * 
 */
@Controller
@RequestMapping(value = "/comment")
public class CommentController {

	@Autowired
	CommentService                         commentService;

	private static SimplePropertyPreFilter commentFilter = new SimplePropertyPreFilter(Comment.class, "id", "nickname",
			"content", "create_time");

	private static Logger                  logger = Logger.getLogger(CommentController.class);

	/**
	 * 
	 * @param id
	 * @分页 pagesize=5
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/show", produces = "text/html;charset=UTF-8")
	public String show_comments(int id, int page) {
		StringBuilder regMsg = new StringBuilder("{\"returndata\": ");
		Comment[] comments = commentService.showComments(id, page);
		/*if (null == comments) {
			regMsg.append(CommentStatusEnum.CNF.getValue());
			regMsg.append("}");
			return regMsg.toString();
		}*/
		regMsg.append(JSON.toJSONString(comments, commentFilter));
		regMsg.append("}");
		logger.error(regMsg.toString());
		return regMsg.toString();
	}

	@AuthPass
	@ResponseBody
	@RequestMapping(value = "/delete", produces = "text/html;charset=UTF-8")
	public String delete_comment(String username, String userToken, String nickname, int message_id, int id) {
		StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
		regMsg.append(commentService.delete_comment(username, nickname, message_id, id).getValue());
		regMsg.append("\"}");
		return regMsg.toString();
	}

	// 评论点赞
}
