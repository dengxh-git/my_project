package com.sunline.sunfi.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eos.access.http.IWebInterceptor;
import com.eos.access.http.IWebInterceptorChain;

public class XssFilter implements IWebInterceptor {

	public void doIntercept(HttpServletRequest request, HttpServletResponse response,
			IWebInterceptorChain interceptorChain) throws IOException, ServletException {
		// 将请求传递到其它过滤器中
				interceptorChain.doIntercept(new XSSRequestWrapper(
						(HttpServletRequest) request), response);

	}

}
