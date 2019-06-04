/*******************************************************************************
 * $Header$
 * $Revision$ v1.2
 * $Date$ 2010-08-28
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2010 sunline Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-8-28
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.eos.system.annotation.Bizlet;

public class GenPackage {

	/**
	 * 子报文分隔符
	 */
	protected static final char SUBFIELD_DELIMITER = 58;//“:”

	/**
	 * 转义符 
	 */
	protected static final char TRANS_CHAR = 92;//“\”

	/**
	 * 层次分隔符 
	 */
	protected static final char LEVEL_DELIMITER = 58;//“:”

	/**
	 * key、value分隔符 
	 */
	protected static final char NAME_VALUE_DELIMITER = 61;//“=”

	/**
	 * 分隔符 
	 */
	protected static final char FIELD_DELIMITER = 124;//“|”

	protected static final char CHINESE_CHAR = 128;//“?”

	/**
	 * 报文头
	 */
	private StringBuffer packageHead = new StringBuffer();


	/**
	 * 用户code
	 */
	private String usercd = null;
	
	/**
	 * 账套ID,默认1
	 */
	private String stacid = "1";
	
	/**
	 * 用户登录机构
	 */
	private String brchcd = null;

	
	/**
	 * 其他的默认的报文头
	 */
	private String otherHead = null;

	/**
	 * 处理码
	 */
	private String prcscd = null;

	/**
	 * 币种，默认为01币种 
	 */
	private String crcycd = "01";
	
	/**
	 * 语言代码，默认中文 
	 */
	private String locale = "zh_CN";

	/**
	 * 报文循环体数目
	 */
	private String listnm = "1";

	/**
	 * 报文体
	 */
	private String packageBody = null;

	/**
	 * 报文头
	 * @return String
	 */
	protected String getPackageHead() {
		//        packageHead.append("|deptcode=");
		//        packageHead.append(tranValue(this.deptCode));
		packageHead.append("|");
		packageHead.append("user_locale=");
		packageHead.append(this.locale);
		packageHead.append("|");
		packageHead.append("user_usercd=");
		packageHead.append(this.usercd);
		packageHead.append("|");
		if (this.brchcd !=null){
			packageHead.append("user_brchcd=");
			packageHead.append(this.brchcd);
			packageHead.append("|");
		}
		packageHead.append("user_stacid=");
		packageHead.append(this.stacid);
//		packageHead.append("|");
		//        packageHead.append("usercode=");
		//        packageHead.append(tranValue(this.usercode));
		packageHead.append(genKeyValue("prcscd", this.prcscd));
		packageHead.append(this.otherHead);

		return packageHead.toString();
	}

	protected void setPackageBody(String packageBody) {
		this.packageBody = packageBody;
	}

	protected String getPackageBody() {
		return packageBody;
	}


	public void setUsercd(String usercd) {
		this.usercd = usercd;
	}

	public String getUsercd() {
		return usercd;
	}
	
	/**
	 * 获取用户登录机构
	 * @return
	 */
	public String getBrchcd() {
		return brchcd;
	}
	
	/**
	 * 设置用户登录机构
	 * @param brchcd
	 */
	public void setBrchcd(String brchcd) {
		this.brchcd = brchcd;
	}
	
	/**
	 * 获取账套ID
	 * @return
	 */
	public String getStacid() {
		return stacid;
	}
	
	/**
	 * 设置账套ID
	 * @param stacid
	 */
	public void setStacid(String stacid) {
		this.stacid = stacid;
	}

	/**
	 * 设置币种
	 * @param crcycd
	 */
	public void setCrcycd(String crcycd) {
		this.crcycd = crcycd;
	}

	/**
	 * 取币种
	 * @return
	 */
	public String getCrcycd() {
		return crcycd;
	}
	
	/**
	 * 语言代码
	 * @param crcycd
	 */
	public void setLocale(String locale) {
		this.locale = locale;
	}

	/**
	 * 语言代码
	 * @return
	 */
	public String getLocale() {
		return locale;
	}

	public void setOtherHead(String otherHead) {
		this.otherHead = otherHead;
	}

	public String getOtherHead() {

		return otherHead;
	}

	public void setPrcscd(String prcscd) {
		this.prcscd = prcscd;
	}

	public String getPrcscd() {
		return prcscd;
	}

	public void setListnm(String listnm) {
		this.listnm = listnm;
	}

	public String getListnm() {
		return listnm;
	}

	/**
	 * 转移值，判断数据项中是否有特殊字符，对特殊字符进行处理后返回
	 * @param value
	 * @return
	 */
	protected String genKeyValue(String key, Object value) {
		if (value == null || (value instanceof Map) ) {
			return "";
		}
		StringBuffer bufStr = new StringBuffer();
		String value_str = value.toString();
		
		//绵阳 20161205 前台jsp产生的undefined，后台置为""
		if("undefined".equalsIgnoreCase(value_str)){
			value_str ="";
		}
		//中有对js不能处理的特殊字符进行处理。回显时要求。
		value_str = value_str.replaceAll("'", "“").replaceAll("\"", "“")
				.replaceAll("\n", "").replaceAll("%", "％");
		//value_str = convertString(value_str); AIX系统中为乱码
		//转换特殊字符(在"\|=:"字符前加'\')
		value_str = value_str.replace("\\", "\\\\\\").replace("=", "\\=").replace(":", "\\:");

		//加密密码
		//    	if(("psaupw".equalsIgnoreCase(key) || "authpw".equalsIgnoreCase(key))&&(null!=value||!"".equals(value)) {
		//               //综合业务系统加密密码
		//               //String dbuserpwd = PasswordDes.getPasswdStr(BankConstants.PWD_KEY,ele.getChildTextTrim(eleOrDocSigle[i]));
		//              // packg.append(dbuserpwd);
		//               //财务加密密码
		//               packg.append(Crypto.encodeByKey(Constants.DEFAULT_KEY, value));
		//           }
		//    	

		bufStr.append("|");
		bufStr.append(key);
		bufStr.append("=");
		if("null".equalsIgnoreCase(value_str)) {
			bufStr.append("");
		}else{
			bufStr.append(value_str);
		}
		
		if("crcycd".equals(key)){
			this.setCrcycd(value_str);
		}

		return bufStr.toString();
	}

	/**
	 * 转换特殊字符(在"\|=:"字符前加'\')
	 * @param str String
	 * @return String
	 */
	@Bizlet("转换特殊字符(在'\\|=:'字符前加'\')")
	public static String convertString(String str) {
		//		StringBuffer retStr = new StringBuffer();
		//		String tmp = str;
		//		int star = 0;
		//		int i = 0;
		//		System.out.println("the value is :" + str);
		//		try {
		//			System.out.println("the regenerate(default) value is :" + new String(str.getBytes("GBK"),"GBK"));
		//		} catch (UnsupportedEncodingException e1) {
		//			e1.printStackTrace();
		//		}
		List<Byte> encode = new ArrayList<Byte>();
		try {
			for (byte temp : str.getBytes("GBK")) {
				if ("\\|=:".indexOf(new String(new byte[] { temp }, "GBK")) != -1) {
					encode.add("\\".getBytes()[0]);
					encode.add(temp);
				} else
					encode.add(temp);
				//				System.out.println("the byte code is :" + temp +" HexString is :" + Integer.toHexString(temp)+" String is " + new String(new byte[]{temp},"GBK"));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		byte[] encode_byte = new byte[encode.size()];
		for (int j = 0; j < encode_byte.length; j++) {
			//			System.out.println("encode.get(i).byteValue() is " + encode.get(j).byteValue());
			encode_byte[j] = encode.get(j).byteValue();
		}
		//		try {
		//			System.out.println("encode is :" + encode + "the charge encode_byte is " + encode_byte + " default string is " + new String(encode_byte,"GBK") + "the utf_8 string is " + new String(encode_byte,"UTF-8"));
		//		} catch (UnsupportedEncodingException e) {
		//			e.printStackTrace();
		//		}
		//		String temp1 = ChangeCharset.changeCharset(str, ChangeCharset.ISO_8859_1);
		//		System.out.println("the changed value(iso_8859_1) is : " + temp1 +" and bytes count is: " + temp1.getBytes().length );
		//		temp1 = ChangeCharset.changeCharset(str, ChangeCharset.GBK);
		//		System.out.println("the changed value(GBK) is : " + temp1 +" and bytes count is: " + temp1.getBytes().length );
		//		for (i = 0; i < tmp.length(); i++) {
		//			if ("\\|=:".indexOf(tmp.toCharArray()[i]) != -1) {
		//				retStr.append(tmp.substring(star, i)).append("\\");
		//				star = i;
		//			}
		//		}
		//		retStr.append(tmp.substring(star, i));
		try {
			return new String(encode_byte, "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * 调用测试用例
	 * @param args
	 */
	public static void main(String[] args) {
		String str= "\\|=:中华人民共和国";
		str = convertString(str);
		System.out.println("convert str："+str);
		
		str= "\\|=:中华人民共和国";
		str = str.replace("\\", "\\\\\\").replace("=", "\\=").replace(":", "\\:");
		System.out.println("convert str："+str);
		
		str= "中华人民\\|=:共和國";
		str = convertString(str);
		System.out.println("convert str："+str);
		
		str= "中华人民\\|=:共和國";
		str = str.replace("\\", "\\\\\\").replace("=", "\\=").replace(":", "\\:");
		System.out.println("convert str："+str);
	}
	
}
