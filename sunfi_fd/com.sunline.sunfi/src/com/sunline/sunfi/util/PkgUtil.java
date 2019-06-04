package com.sunline.sunfi.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.eos.system.annotation.Bizlet;

/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 * 取报文信息，不支持字段名(fildna)中有特殊字符":\=|"这4个字符
 * 
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-9-8
 *******************************************************************************/

public class PkgUtil {
		
	/**
	 * 
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @return 字段对应的值(如果是循环字段则返回第一个字段的值)
	 */	
	@Bizlet("获取字段对应的值")
    public static String getPkgstr(String pkgstr,String fildna){
    	return getPkgstr(pkgstr,fildna,0,0);
    }
    /**
	 * 
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @param cyclpo 循环位置
	 * @return 字段对应的值
	 */	
	@Bizlet("获取字段对应的值")
    public static String getPkgstr(String pkgstr,String fildna,int cyclpo){
    	return getPkgstr(pkgstr,fildna,cyclpo,0);
    }
    /**
	 * 
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @param cyclpo 循环位置
	 * @param listnm 总循环数
	 * @return 字段对应的值
	 */	
	@Bizlet("获取字段对应的值")
    public static String getPkgstr(String pkgstr,String fildna,int cyclpo,int listnm){
    	String subPkg ="";
    	pkgstr = pkgstr + "|";
    	if(cyclpo==0){//取主报文字段
    		subPkg = pkgstr.replaceAll("(1\\:\\=\\|2\\:.*)0\\:","");//将循环体替换成空 
    		if(pkgstr.contains("1:=|2:")){
    			subPkg = subPkg.replaceAll("(1\\:\\=\\|2\\:.*)\\b","");//将循环体替换成空
    		}
    	}else{//取循环体内字段
    		//System.out.println("subPkg1="+subPkg);
    		subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)0\\:",1);//获取循环体
    		//System.out.println("subPkg2="+subPkg);
    		if ("".endsWith(subPkg)){
    			subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)\\b",1);//获取循环体
    		}
    		subPkg = subPkg + "1:=|2:";
    		//System.out.println("subPkg3="+subPkg);
        	subPkg = getPkgstrByExp(subPkg,"1\\:\\=\\|2\\:(.*?)1\\:\\=\\|2\\:",cyclpo);//获取第cyclpo层循环
    	}
    	//System.out.println("subPkg2="+subPkg);
    	return getPkgstrByExp(subPkg,fildna+"\\\\*=(.*?)(\\\\)*\\|",1);
    }
    /**
     * 根据正则表达式在报文串中匹配
     * @param pkgstr 报文字符串
     * @param expres 正在表达式
     * @param octime 匹配次数
     * @return 返回第octime次匹配结果
     */
	@Bizlet("获取字段对应的值")
    public static String getPkgstrByExp(String pkgstr,String expres,int octime){
    	Pattern pn = Pattern.compile(expres);
		Matcher m = pn.matcher(pkgstr);
		while(m.find()&&octime>0){
			octime--;
			if(octime == 0){
				return m.group(1);
			}
			pkgstr = pkgstr.substring(m.end(1));
			m = pn.matcher(pkgstr);
		}
		return "";
    }
	
	/**
	 * 判断pkgstr是否包含fildna
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @return 报文是否包含字段
	 */	
	@Bizlet("判断pkgstr是否包含fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna){
    	return pkgContainsKey(pkgstr,fildna,0,0);
    }
    /**
	 * 判断pkgstr是否包含fildna
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @param cyclpo 循环位置
	 * @return 报文是否包含字段
	 */	
	@Bizlet("判断pkgstr是否包含fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna,int cyclpo){
    	return pkgContainsKey(pkgstr,fildna,cyclpo,0);
    }
    /**
	 * 判断pkgstr是否包含fildna
	 * @param pkgstr 报文字符串
	 * @param fildna 字段名称
	 * @param cyclpo 循环位置
	 * @param listnm 总循环数
	 * @return 报文是否包含字段
	 */	
	@Bizlet("判断pkgstr是否包含fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna,int cyclpo,int listnm){
		String subPkg ="";
    	pkgstr = pkgstr + "|";
    	if(cyclpo==0){//取主报文字段
    		subPkg = pkgstr.replaceAll("(1\\:\\=\\|2\\:.*)0\\:","");//将循环体替换成空 
    		if(pkgstr.contains("1:=|2:")){
    			subPkg = subPkg.replaceAll("(1\\:\\=\\|2\\:.*)\\b","");//将循环体替换成空
    		}
    	}else{//取循环体内字段
    		//System.out.println("subPkg1="+subPkg);
    		subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)0\\:",1);//获取循环体
    		//System.out.println("subPkg2="+subPkg);
    		if ("".endsWith(subPkg)){
    			subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)\\b",1);//获取循环体
    		}
    		subPkg = subPkg + "1:=|2:";
    		//System.out.println("subPkg3="+subPkg);
        	subPkg = getPkgstrByExp(subPkg,"1\\:\\=\\|2\\:(.*?)1\\:\\=\\|2\\:",cyclpo);//获取第cyclpo层循环
    	}
    	//System.out.println("subPkg2="+subPkg);
    	return pkgContainsKeyByExp(subPkg,fildna+"\\\\*=(.*?)(\\\\)*\\|",1);
    }
    /**
     * 根据正则表达式判断pkgstr是否包含fildna
     * @param pkgstr 报文字符串
     * @param expres 正在表达式
     * @param octime 匹配次数
     * @return 报文是否包含字段
     */
	@Bizlet("判断pkgstr是否包含fildna")
    public static boolean pkgContainsKeyByExp(String pkgstr,String expres,int octime){
    	Pattern pn = Pattern.compile(expres);
		Matcher m = pn.matcher(pkgstr);
		while(m.find()&&octime>0){
			octime--;
			if(octime == 0){
				return true;
			}
			pkgstr = pkgstr.substring(m.end(1));
			m = pn.matcher(pkgstr);
		}
		return false;
    }
    
	/**
	 * 调用测试案例
	 * @param args
	 */
    public static void main(String args[]) {
    	String pkgstr = "cheque=|acctno=小王|acctno=小二|myname\\\\\\=韩 梅梅\\\\|" +
    			"1:=|2:acctno\\\\=914261005900001\\\\|acctno=111|acctna=韩梅梅账号|" +
    			"1:=|2:acctno=500077052802033|acctna=李磊账号|" +
    			"0:yield=0.00|acctno1=500077052802033";
    	System.out.println("cheque=" + getPkgstr(pkgstr,"cheque"));//结果=
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno"));//结果=小王
    	System.out.println("myname=" + getPkgstr(pkgstr,"myname"));//结果=韩 梅梅
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",1));//结果=914261005900001
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",1));//结果=韩梅梅账号
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",2));//结果=500077052802033
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",2));//结果=李磊账号
    	System.out.println("yield=" + getPkgstr(pkgstr,"yield"));//结果=0.00
    	System.out.println("acctno1=" + getPkgstr(pkgstr,"acctno1"));//结果=500077052802033
    	System.out.println("test=" + getPkgstr(pkgstr,"test"));//结果=
    	System.out.println("test=" + getPkgstr(pkgstr,"test",1));//结果=
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",3));//结果=
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",3));//结果=
    	//判断是否存在
    	System.out.println("contain cheque :" + pkgContainsKey(pkgstr,"cheque"));//结果 ture
    	System.out.println("contain cheque12 :" + pkgContainsKey(pkgstr,"cheque12"));//结果 false
    	System.out.println("contain acctna :" + pkgContainsKey(pkgstr,"acctna",2));//结果 ture
    	System.out.println("contain cheque :" + pkgContainsKey(pkgstr,"cheque",2));//结果 false
	}
}
