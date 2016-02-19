package group.zerry.front_server.entity;

public class Topic {
	private int    id;
	private String name;
	private String content;
	private int    read_num;
	private int    comment_num;
	private int    weibo_num;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRead_num() {
		return read_num;
	}
	public void setRead_num(int read_num) {
		this.read_num = read_num;
	}
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getWeibo_num() {
		return weibo_num;
	}
	public void setWeibo_num(int weibo_num) {
		this.weibo_num = weibo_num;
	}
}
