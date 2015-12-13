package group.zerry.front_server.entity;

/**
 * 
 * @author  zhuzirui
 * @content 私信
 * @version 1.0
 * @since   2015.12.12
 *
 */
public class PrivateMsg {
	private int     id;
	private int     sdr_id;  // 发送人
	private int     rcvr_id; // 收信人
	private String  content;
	private boolean has_read;// 是否已读
	private String  time;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSdr_id() {
		return sdr_id;
	}
	public void setSdr_id(int sdr_id) {
		this.sdr_id = sdr_id;
	}
	public int getRcvr_id() {
		return rcvr_id;
	}
	public void setRcvr_id(int rcvr_id) {
		this.rcvr_id = rcvr_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isHas_read() {
		return has_read;
	}
	public void setHas_read(boolean has_read) {
		this.has_read = has_read;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
}
