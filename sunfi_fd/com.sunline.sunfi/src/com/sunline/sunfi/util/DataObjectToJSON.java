/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2013-7-30
 *******************************************************************************/


package com.sunline.sunfi.util;


import java.util.ArrayList;
import java.util.HashMap;

import net.sf.json.JSONObject;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

public class DataObjectToJSON {
	
	/**
	 * 将DataObject[]转换为JSON对象
	 * @param objs
	 * @return
	 */
	@Bizlet("将DataObject[]转换为JSONObject")
	public static String convertDataObject2JSONObject(DataObject[] objs , String json){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(objs != null){
			for(int m = 0 ; m < objs.length; m++){
				map = Convert.convertDataObject2HashMap(objs[m]);
				//map.put("i", m);
				System.out.println(map);
				list.add(map);
			}
		}
		JSONObject JSON = JSONObject.fromObject(json);
		JSON.put("detail", list);
		
		return JSON.toString();
	}
	
	/**
	 * 将DataObject[]转换为JSON对象
	 * @param objs
	 * @return
	 */
	@Bizlet("将DataObject[]转换为JSONObject")
	public static String convertString2JSONObject(String arg0){
		
		JSONObject json = new JSONObject();
		String[] args;
		String[] strs;
		if(arg0 != null){
			args = arg0.split("\\|");
			if(args != null){
				for(int i = 0; i < args.length; i++){
					if(args[i].length() == 0){
						continue;
					}
					strs = args[i].split("=");
					if(strs.length == 2){
						json.put(strs[0], strs[1]);
					}else if(strs.length == 1){
						json.put(strs[0], "");
					}else{
					}
				}
			}
		}
		
		return json.toString();
	}
	
	public static void main(String args[]){
		/*
		DataObject[] objs = null;
		DataObject obj = DataObjectUtil.createDataObject("com.sunline.sunfi.db.infc.public.ComSequ");
		obj.setString("sequna", "AAAA");
		obj.setInt("sequid", 1);
		objs[1] = obj;
		obj.setString("sequna", "BBBB");
		obj.setInt("sequid", 2);
		objs[2] = obj;
		
		System.out.println(convertDataObject2JSONObject(objs));
		*/
		
		String arg0 = "|acctbr_1=01002|aftpcd_1=66011305|bnmthd_1=1|smrytx_1=纪委费用|";
		System.out.println(convertString2JSONObject(arg0));
	}
}
