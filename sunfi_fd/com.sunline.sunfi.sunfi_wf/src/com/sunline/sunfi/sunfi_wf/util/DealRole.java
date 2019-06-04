/**
 * 
 */
package com.sunline.sunfi.sunfi_wf.util;

import java.util.HashMap;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2019-01-16 16:51:42
 *
 */
@Bizlet("角色处理")
public class DealRole {
	
	@SuppressWarnings("rawtypes")
	@Bizlet("角色处理")
	public static boolean dealRole(HashMap params, String str) {
		String roleList = params.get("role").toString();
		return roleList.contains(str);
	}
	/**
	 * @param detail
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Bizlet("工作项处理")
	public static long[] dealWorkitemId(HashMap[] detail) {
		long[] returnValue = new long[detail.length];
		for (int i = 0; i < detail.length; i++) {
			long workItemid = Long.valueOf((String) detail[i].get("workItemid"));
			returnValue[i] = workItemid;			
		}
		return returnValue;
	}
}
