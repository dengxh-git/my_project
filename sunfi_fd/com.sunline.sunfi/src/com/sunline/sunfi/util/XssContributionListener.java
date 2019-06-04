package com.sunline.sunfi.util;

import com.eos.access.http.WebInterceptorConfig;
import com.eos.access.http.WebInterceptorManager;
import com.eos.runtime.resource.IContributionEvent;
import com.eos.runtime.resource.IContributionListener;

public class XssContributionListener implements IContributionListener {

	public void load(IContributionEvent arg0) {
		// TODO 自动生成的方法存根

	}

	public void loadFinished(IContributionEvent arg0) {
		// 注册过滤器
				WebInterceptorConfig con = new WebInterceptorConfig();
				con.setFilterId("PageFilter");
				con.setSortIdx(1);
				con.setClassName("com.sunline.sunfi.util.PageFilter");
				con.setPattern("*.jsp");
				WebInterceptorManager.INSTANCE.addInterceptorConfig(con);
				WebInterceptorConfig config = new WebInterceptorConfig();
				config.setFilterId("XssFilter");
				config.setSortIdx(2);
				config.setClassName("com.sunline.sunfi.util.XssFilter");
				config.setPattern("*.jsp");
				WebInterceptorManager.INSTANCE.addInterceptorConfig(config);

	}

	public void unLoad(IContributionEvent arg0) {
		// TODO 自动生成的方法存根

	}

}
