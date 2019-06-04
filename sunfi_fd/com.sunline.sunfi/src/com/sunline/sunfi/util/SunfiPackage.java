/*******************************************************************************
 * $Header$
 * $Revision$ v1.2
 * $Date$ 2010-08-28
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2010 sunliune Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-8-28
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.eos.data.datacontext.IUserObject;

public class SunfiPackage extends GenPackage implements Serializable{

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 4586013085072231723L;

	/**
	 * 默认
	 */
	private String defaultOtherHead = "|trantp=TR";

	private StringBuffer packg = new StringBuffer();

	/**
	 * 用户session
	 */
	private IUserObject userSession;

	/**
	 * 非循环报文
	 */
	private Map<String, String> singleMap;

	/**
	 * 非循环报文key值
	 */
	private String[] singleKey;
	
	/**
	 * 非循环报文不需打包的key
	 */
	private Map<String, String> singleExcludeKeyMap;

	/**
	 * 循环报文
	 */
	private Map<String, Object>[] muMaps;

	/**
	 * 循环报文key
	 */
	private String[] muKey;
	
	/**
	 * 循环报文不需打包的key
	 */
	private Map<String, String> muExcludeKeyMap;

	/**
	 * 这里只是设置了报文体内容，报文头（deptcode、userid、prcscd必须通过相应set方法进行设置）
	 * 
	 * @param userSession
	 *            用户session对象
	 * @param prcscd
	 *            处理码
	 * @throws Exception
	 */
	public SunfiPackage(IUserObject userSession, String prcscd)
			throws Exception {
		this.userSession = userSession;
	}

	/**
	 * 
	 * @param userSession
	 *            用户session对象
	 * @param singleMap
	 *            非循环Map
	 * @param prcscd
	 *            处理码
	 * @throws Exception
	 */
	public SunfiPackage(IUserObject userSession, Map<String, String> singleMap,
			String prcscd) throws Exception {
		this.userSession = userSession;
		this.singleMap = singleMap;
		this.setPrcscd(prcscd);
	}

	/**
	 * 
	 * @param userSession
	 *            用户session对象
	 * @param muMaps
	 *            循环Map
	 * @param prcscd
	 *            处理码
	 * @throws Exception
	 */
	public SunfiPackage(IUserObject userSession, Map<String, Object>[] muMaps,
			String prcscd) throws Exception {
		this.userSession = userSession;
		this.muMaps = muMaps;
		this.setPrcscd(prcscd);
	}

	/**
	 * 
	 * @param userSession
	 *            用户session对象
	 * @param singleMap
	 *            非循环Map
	 * @param muMaps
	 *            循环Map
	 * @param prcscd
	 *            处理码
	 * @throws Exception
	 */
	public SunfiPackage(IUserObject userSession, Map<String, String> singleMap,
			Map<String, Object>[] muMaps, String prcscd) throws Exception {
		this.userSession = userSession;
		this.singleMap = singleMap;
		this.muMaps = muMaps;
		this.setPrcscd(prcscd);
	}

	/**
	 * 
	 * @param prcscd
	 *            处理码
	 */
	public SunfiPackage(String prcscd) {
		this.setPrcscd(prcscd);
	}

	/**
	 * 设置取值的key
	 * 
	 * @param singleKey
	 *            非循环key
	 * @param muKey
	 *            循环key
	 */
	public void setPackageKey(String[] singleKey, String[] muKey) {
		this.singleKey = singleKey;
		this.muKey = muKey;
	}
	
	/**
	 * 设置不需打包的key
	 * 
	 * @param singleExcludeKey
	 *            非循环key
	 * @param muExcludeKey
	 *            循环key
	 */
	public void setPackageExcludeKey(String[] singleExcludeKey, String[] muExcludeKey) {
		if(singleExcludeKey != null && singleExcludeKey.length >0){
			singleExcludeKeyMap = new HashMap<String, String>();
			for (int i = 0; i < singleExcludeKey.length; i++) {
				singleExcludeKeyMap.put(singleExcludeKey[i], "");
			}
		}
		if(muExcludeKey != null && muExcludeKey.length >0){
			muExcludeKeyMap = new HashMap<String, String>();
			for (int i = 0; i < muExcludeKey.length; i++) {
				muExcludeKeyMap.put(muExcludeKey[i], "");
			}
		}
	}

	/**
	 * 单个添加，Operatorid、prcscd是必须输入的,只生成非循环报文
	 * 
	 * @param name
	 *            String
	 * @param value
	 *            String
	 */
	public void addItem(String key, String value) throws Exception {
		if ("usercd".equals(key)) {
			this.setUsercd(value);
		} else if ("prcscd".equals(key)) {
			this.setPrcscd(value);
		} else if ("locale".equals(key)) {
			this.setLocale(value);
		} else {
			singleMap.put(key, value);
		}
	}

	/**
	 * 获得报文
	 * 
	 * @throws Exception
	 * @return String
	 */
	public String getPackage() throws Exception {

		if (this.userSession != null){
			if(userSession.getUserId() != null && !"".equals(userSession.getUserId())) {// 设置用户代码
				setUsercd(userSession.getAttributes().get("EXTEND_USER_ID").toString());
			}
			if(userSession.getAttributes().get("brchcd") != null 
					&& !"".equals(userSession.getAttributes().get("brchcd").toString())) {// 设置用户登录机构
				setBrchcd(userSession.getAttributes().get("brchcd").toString());
			}
			if(userSession.getAttributes().get("stacid") != null 
					&& !"".equals(userSession.getAttributes().get("stacid").toString())) {// 设置用户登录账套
				setStacid(userSession.getAttributes().get("stacid").toString());
			}
			if(userSession.getAttributes().get("locale") != null 
					&& !"".equals(userSession.getAttributes().get("locale").toString())) {// 设置用户登录语言
				setLocale(userSession.getAttributes().get("locale").toString());
			}
		}

		if (this.getPrcscd() == null || "".equals(this.getPrcscd())) {

			throw new Exception("Prcscd can't for empty");
		}
		if (this.getUsercd() == null || "".equals(this.getUsercd())) {

			throw new Exception("Usercd can't for empty");
		}
		genPackageBody();// 生成报文体
		
		defaultOtherHead = "|crcycd=" + this.getCrcycd() + defaultOtherHead;

		this.setOtherHead(defaultOtherHead);

		
		
		return getPackageHead() + packg.toString() + "|";
	}

	private void genPackageBody() throws Exception {

		try {// 设置循环数
			if ("1".equals(this.getListnm()) && muMaps != null
					&& muMaps.length > 0) {
				this.setListnm(muMaps.length + "");
			}
		} catch (Exception ex) {
		}

		// 独非循环项的报文生成
		if (singleKey != null && singleKey.length > 0) {// 指定取值
			if(singleMap != null){
				for (int i = 0; i < singleKey.length; i++) {
	
					String key = singleKey[i];
					Object obj = singleMap.get(key);
					packg.append(genKeyValue(key, obj));
	
				}
			}
		} else {// 未指定key
			if(singleMap != null){
				Iterator sigIt = singleMap.keySet().iterator();
				while (sigIt.hasNext()) {
					String key = (String) sigIt.next();
					Object obj = singleMap.get(key);
					if(singleExcludeKeyMap == null || !singleExcludeKeyMap.containsKey(key)){
						packg.append(genKeyValue(key, obj));
					}
	
				}
			}

		}

		packg.append("|");
		packg.append("listnm=");
		packg.append(this.getListnm());

		// 循环记录：而循环项的报文生成
		if (muKey != null && muKey.length > 0) {// 指定循环的key值
			if(muMaps != null){
				for (int outerI = 0; outerI < muMaps.length; outerI++) {
					packg.append("|1:");
					// packg.append(i);
					packg.append("=|2:");
					Map<String, Object> muMap = muMaps[outerI];
					for (int inerI = 0; inerI < muKey.length; inerI++) {
						String key = muKey[inerI];
						Object obj = muMap.get(key);				
						packg.append(genKeyValue(key, obj));
						
					}
				}
			}

		} else {// 未指定循环值
			if(muMaps != null){
				for (int outerI = 0; outerI < muMaps.length; outerI++) {
					packg.append("|1:");
					// packg.append(i);
					packg.append("=|2:");
					Map<String, Object> muMap = muMaps[outerI];
	
					Iterator muIt = muMap.keySet().iterator();
					while (muIt.hasNext()) {
						String key = (String) muIt.next();
						Object obj = muMap.get(key);
						if(muExcludeKeyMap == null || !muExcludeKeyMap.containsKey(key)){
							packg.append(genKeyValue(key, obj));
						}
	
					}
	
				}
			}
		}

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}