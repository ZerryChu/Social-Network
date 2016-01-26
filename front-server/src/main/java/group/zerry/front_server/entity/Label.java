package group.zerry.front_server.entity;

public class Label {
	private long id;
	private long times;

	public Label() {
	// TODO Auto-generated constructor stub
	}

	public Label(long id, long times) {
		this.id = id;
		this.times = times;
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getTimes() {
		return times;
	}
	public void setTimes(long times) {
		this.times = times;
	}
	
}
