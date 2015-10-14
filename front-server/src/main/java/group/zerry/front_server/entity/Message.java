package group.zerry.front_server.entity;

/**
 * @author  ZerryChu
 * @version 2.0
 * @content 微博帖子
 * 
 */
public class Message {
	private int    id;
	private String author;
	private String content;
	private int    type;
	private String create_time;
	private int    repost_times;  //转发量
	private int    comment_times; //评论量
	private int    support_times; //点赞量
	
	public int getRepost_times() {
		return repost_times;
	}
	public void setRepost_times(int repost_times) {
		this.repost_times = repost_times;
	}
	public int getComment_times() {
		return comment_times;
	}
	public void setComment_times(int comment_times) {
		this.comment_times = comment_times;
	}
	public int getSupport_times() {
		return support_times;
	}
	public void setSupport_times(int support_times) {
		this.support_times = support_times;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
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
