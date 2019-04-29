package web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger
	= LoggerFactory.getLogger(AdminInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.info("+ Admin 인터셉트 시작! +");
		
		// 세션 얻기
		HttpSession session = request.getSession();
		
		if(session.getAttribute("adminLogin") == null) {
			logger.info(" >> 접속불가 : 로그인되지 않음!");
			
			response.sendRedirect("/admin/main");
			
			return false;
		}
		
		logger.info(" >> 로그인 상태!");
		
		return true;
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		logger.info("+ 인터셉트 종료! +");
	}

}
