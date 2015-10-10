package group.zerry.front_server.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author：刘志龙
 * @since：2014年12月13日 下午12:48:12
 * @version:1.0
 */
@Component("httpTarget")
public class HttpTarget {
	@Value("#{configLoader['api.hostname']}")
	public String hostname;
	@Value("#{configLoader['api.path']}")
	public String path;

	public String getHostname() {
		return hostname;
	}

	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
