package group.zerry.front_server.dto;

import java.io.Serializable;

public class ReturnMsgDto implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String returnMsg;

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
}
