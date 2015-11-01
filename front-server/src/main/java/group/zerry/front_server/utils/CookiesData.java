package group.zerry.front_server.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookiesData {
	public Cookie getCookie(HttpServletRequest request, String cookieName) {
		Cookie[] cookies = request.getCookies();
		if (null == cookies) {
			return null;
		} else {
			if (cookies.length == 0) {
				return null; // cookies被用户禁用
			} else {
				for (int i = 0; i < cookies.length; i++) {
					Cookie c = cookies[i];
					if (c.getName().equals(cookieName)) {
						if (c.getValue() != null || !c.getValue().equals("")) {
							return c;
						}
					}
				}
				return null;
			}
		}
	}

	public void save(HttpServletRequest request, HttpServletResponse response, String cookieName, String newData) throws UnsupportedEncodingException {
		//newData = URLEncoder.encode(newData, "UTF-8"); //转码
		Cookie cookie = new Cookie(cookieName, newData);
		cookie.setMaxAge(1200);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	public void deleteCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals(cookieName)) {
				Cookie cookie = new Cookie(cookies[i].getName(), null);
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				return;
			}
		}
		return;
	}

	public void deleteAllCookies(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = new Cookie(cookies[i].getName(), null);
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		return;
	}
}
