package group.zerry.api_server.entity;

public class Label {
	private long id;
	private String name;
	private long times;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Label() {
	// TODO Auto-generated constructor stub
	}

	public Label(String name, long times) {
		this.name = name;
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
