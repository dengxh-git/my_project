/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import com.eos.system.annotation.Bizlet;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author chenc
 * @date 2019-04-08 15:12:54
 *
 */
public class DataConvert {
	@Bizlet("字符串日期转换")
	public  String dateConvert(String str){
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatcv = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		String strReturn = null;
		try {
			date = format.parse(str);
			//System.out.println(date);
		} catch (ParseException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		strReturn = formatcv.format(date);
		return strReturn;
		
	}
	public static void main(String[] args) {
		
		System.out.println(new DataConvert().dateConvert("2018-01-07T00:00:00"));
	}
}

