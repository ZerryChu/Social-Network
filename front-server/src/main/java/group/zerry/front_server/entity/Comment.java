package group.zerry.front_server.entity;

/**
 * @author: ZerryChu
 * @date:   2015.10.12 9.38pm 
 * @content:微博评论
 */
public class Comment {
	private int    id;
	private String nickname;
	private int    message_id;
	private String content;
	private String create_time;
	
	public void setId(int id) {
		this.id = id;
	}
	public int id() {
		return id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
}
