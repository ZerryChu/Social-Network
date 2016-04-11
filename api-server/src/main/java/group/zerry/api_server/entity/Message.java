package group.zerry.api_server.entity;

/**
 * @author  ZerryChu
 * @version 2.0
 * @content 微博帖子
 * 
 */
public class Message extends SourceMessagae {
	//private int     id;
	private User    author;
	//private String  content;
	private int     type;
	//private String  create_time;
	//private int     repost_times;  //转发量
	//private int     comment_times; //评论量
	//private int     support_times; //点赞量
	private String  pic;           //uuid值，图片名，暂定一微博只能存一张图片
	private int     label_id;
	private String  label_name;
	private boolean isSupported;
	private SourceMessagae source_message;
	
	public String getLabel_name() {
		return label_name;
	}
	public void setLabel_name(String label_name) {
		this.label_name = label_name;
	}
	public boolean isSupported() {
		return isSupported;
	}
	public void setSupported(boolean isSupported) {
		this.isSupported = isSupported;
	}
	public int getLabel_id() {
		return label_id;
	}
	public void setLabel_id(int label_id) {
		this.label_id = label_id;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public User getAuthor() {
		return author;
	}
	public void setAuthor(User author) {
		this.author = author;
	}
	public SourceMessagae getSource_message() {
		return source_message;
	}
	public void setSource_message(SourceMessagae source_message) {
		this.source_message = source_message;
	}
	
}
