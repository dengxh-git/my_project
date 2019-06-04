package com.sunline.sunfi.util;

import java.math.BigDecimal;

public class PubBean {
	/**
	 * 将double型数字转换成String数组
	 * 
	 * @param x double型数字
	 * @return String[]
	 */
	public static String[] DoubleToStringArray(double x)
	{
		double x1 = MathUtil.ROUND(x, 2);
		BigDecimal bdRemnam = new BigDecimal(x1);
		bdRemnam = bdRemnam.setScale(2,4);
		String[] a = new String[10];
		String xx= String.valueOf(bdRemnam);	
		System.out.println(xx);
		int dex=xx.indexOf(".")+1;
		if(xx.length()-dex==1)
		{
			xx=xx+"0";
		}
		String k="";
		for(int i=0;i<10-xx.length();i++)
		{
			k+=" ";
		}
		if(xx.length()<=10)
			k+="￥";
		String com = k+xx;
		com = com.replaceAll("\\.", "");
		for(int i=0;i<10;i++)
		{
			a[i] = com.substring(i, i+1);
		}
		return a;
	}
}
