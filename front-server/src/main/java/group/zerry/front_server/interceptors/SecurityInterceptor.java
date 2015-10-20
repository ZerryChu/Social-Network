package group.zerry.front_server.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import group.zerry.front_server.annotation.AuthPass;
import group.zerry.front_server.enumtypes.UserStatusEnum;
import redis.clients.jedis.Jedis;

//编辑统一错误页
//check
public class SecurityInterceptor implements HandlerInterceptor {

	//@Autowired
	//CacheTools cacheTools;

	//private static Jedis jedis = new Jedis("localhost", 6379);

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	//has userToken
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
            AuthPass authPass = ((HandlerMethod) handler).getMethodAnnotation(AuthPass.class);
            if (authPass == null || authPass.validate() == false)
                return true;
            else {
            	String userToken = request.getParameter("userToken");
        		if (null == userToken) {
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("application/json");
        			StringBuilder regMsg = new StringBuilder("{\"returnmsg\":\"");
        			regMsg.append(UserStatusEnum.UNV);
        			regMsg.append("\"}");
                    response.getWriter().write(regMsg.toString());
                    System.out.println("authpass fail1.");
                    return false;
        		}
        		else
        			return true;
            }
        }
        else
        	return true;
	}
}