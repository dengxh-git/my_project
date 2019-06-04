package com.sunline.sunfi.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.eos.system.annotation.Bizlet;

/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 * ȡ������Ϣ����֧���ֶ���(fildna)���������ַ�":\=|"��4���ַ�
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
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @return �ֶζ�Ӧ��ֵ(�����ѭ���ֶ��򷵻ص�һ���ֶε�ֵ)
	 */	
	@Bizlet("��ȡ�ֶζ�Ӧ��ֵ")
    public static String getPkgstr(String pkgstr,String fildna){
    	return getPkgstr(pkgstr,fildna,0,0);
    }
    /**
	 * 
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @param cyclpo ѭ��λ��
	 * @return �ֶζ�Ӧ��ֵ
	 */	
	@Bizlet("��ȡ�ֶζ�Ӧ��ֵ")
    public static String getPkgstr(String pkgstr,String fildna,int cyclpo){
    	return getPkgstr(pkgstr,fildna,cyclpo,0);
    }
    /**
	 * 
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @param cyclpo ѭ��λ��
	 * @param listnm ��ѭ����
	 * @return �ֶζ�Ӧ��ֵ
	 */	
	@Bizlet("��ȡ�ֶζ�Ӧ��ֵ")
    public static String getPkgstr(String pkgstr,String fildna,int cyclpo,int listnm){
    	String subPkg ="";
    	pkgstr = pkgstr + "|";
    	if(cyclpo==0){//ȡ�������ֶ�
    		subPkg = pkgstr.replaceAll("(1\\:\\=\\|2\\:.*)0\\:","");//��ѭ�����滻�ɿ� 
    		if(pkgstr.contains("1:=|2:")){
    			subPkg = subPkg.replaceAll("(1\\:\\=\\|2\\:.*)\\b","");//��ѭ�����滻�ɿ�
    		}
    	}else{//ȡѭ�������ֶ�
    		//System.out.println("subPkg1="+subPkg);
    		subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)0\\:",1);//��ȡѭ����
    		//System.out.println("subPkg2="+subPkg);
    		if ("".endsWith(subPkg)){
    			subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)\\b",1);//��ȡѭ����
    		}
    		subPkg = subPkg + "1:=|2:";
    		//System.out.println("subPkg3="+subPkg);
        	subPkg = getPkgstrByExp(subPkg,"1\\:\\=\\|2\\:(.*?)1\\:\\=\\|2\\:",cyclpo);//��ȡ��cyclpo��ѭ��
    	}
    	//System.out.println("subPkg2="+subPkg);
    	return getPkgstrByExp(subPkg,fildna+"\\\\*=(.*?)(\\\\)*\\|",1);
    }
    /**
     * ����������ʽ�ڱ��Ĵ���ƥ��
     * @param pkgstr �����ַ���
     * @param expres ���ڱ��ʽ
     * @param octime ƥ�����
     * @return ���ص�octime��ƥ����
     */
	@Bizlet("��ȡ�ֶζ�Ӧ��ֵ")
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
	 * �ж�pkgstr�Ƿ����fildna
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @return �����Ƿ�����ֶ�
	 */	
	@Bizlet("�ж�pkgstr�Ƿ����fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna){
    	return pkgContainsKey(pkgstr,fildna,0,0);
    }
    /**
	 * �ж�pkgstr�Ƿ����fildna
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @param cyclpo ѭ��λ��
	 * @return �����Ƿ�����ֶ�
	 */	
	@Bizlet("�ж�pkgstr�Ƿ����fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna,int cyclpo){
    	return pkgContainsKey(pkgstr,fildna,cyclpo,0);
    }
    /**
	 * �ж�pkgstr�Ƿ����fildna
	 * @param pkgstr �����ַ���
	 * @param fildna �ֶ�����
	 * @param cyclpo ѭ��λ��
	 * @param listnm ��ѭ����
	 * @return �����Ƿ�����ֶ�
	 */	
	@Bizlet("�ж�pkgstr�Ƿ����fildna")
    public static boolean pkgContainsKey(String pkgstr,String fildna,int cyclpo,int listnm){
		String subPkg ="";
    	pkgstr = pkgstr + "|";
    	if(cyclpo==0){//ȡ�������ֶ�
    		subPkg = pkgstr.replaceAll("(1\\:\\=\\|2\\:.*)0\\:","");//��ѭ�����滻�ɿ� 
    		if(pkgstr.contains("1:=|2:")){
    			subPkg = subPkg.replaceAll("(1\\:\\=\\|2\\:.*)\\b","");//��ѭ�����滻�ɿ�
    		}
    	}else{//ȡѭ�������ֶ�
    		//System.out.println("subPkg1="+subPkg);
    		subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)0\\:",1);//��ȡѭ����
    		//System.out.println("subPkg2="+subPkg);
    		if ("".endsWith(subPkg)){
    			subPkg = getPkgstrByExp(pkgstr,"(1\\:\\=\\|2\\:.*)\\b",1);//��ȡѭ����
    		}
    		subPkg = subPkg + "1:=|2:";
    		//System.out.println("subPkg3="+subPkg);
        	subPkg = getPkgstrByExp(subPkg,"1\\:\\=\\|2\\:(.*?)1\\:\\=\\|2\\:",cyclpo);//��ȡ��cyclpo��ѭ��
    	}
    	//System.out.println("subPkg2="+subPkg);
    	return pkgContainsKeyByExp(subPkg,fildna+"\\\\*=(.*?)(\\\\)*\\|",1);
    }
    /**
     * ����������ʽ�ж�pkgstr�Ƿ����fildna
     * @param pkgstr �����ַ���
     * @param expres ���ڱ��ʽ
     * @param octime ƥ�����
     * @return �����Ƿ�����ֶ�
     */
	@Bizlet("�ж�pkgstr�Ƿ����fildna")
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
	 * ���ò��԰���
	 * @param args
	 */
    public static void main(String args[]) {
    	String pkgstr = "cheque=|acctno=С��|acctno=С��|myname\\\\\\=�� ÷÷\\\\|" +
    			"1:=|2:acctno\\\\=914261005900001\\\\|acctno=111|acctna=��÷÷�˺�|" +
    			"1:=|2:acctno=500077052802033|acctna=�����˺�|" +
    			"0:yield=0.00|acctno1=500077052802033";
    	System.out.println("cheque=" + getPkgstr(pkgstr,"cheque"));//���=
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno"));//���=С��
    	System.out.println("myname=" + getPkgstr(pkgstr,"myname"));//���=�� ÷÷
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",1));//���=914261005900001
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",1));//���=��÷÷�˺�
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",2));//���=500077052802033
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",2));//���=�����˺�
    	System.out.println("yield=" + getPkgstr(pkgstr,"yield"));//���=0.00
    	System.out.println("acctno1=" + getPkgstr(pkgstr,"acctno1"));//���=500077052802033
    	System.out.println("test=" + getPkgstr(pkgstr,"test"));//���=
    	System.out.println("test=" + getPkgstr(pkgstr,"test",1));//���=
    	System.out.println("acctna=" + getPkgstr(pkgstr,"acctna",3));//���=
    	System.out.println("acctno=" + getPkgstr(pkgstr,"acctno",3));//���=
    	//�ж��Ƿ����
    	System.out.println("contain cheque :" + pkgContainsKey(pkgstr,"cheque"));//��� ture
    	System.out.println("contain cheque12 :" + pkgContainsKey(pkgstr,"cheque12"));//��� false
    	System.out.println("contain acctna :" + pkgContainsKey(pkgstr,"acctna",2));//��� ture
    	System.out.println("contain cheque :" + pkgContainsKey(pkgstr,"cheque",2));//��� false
	}
}
