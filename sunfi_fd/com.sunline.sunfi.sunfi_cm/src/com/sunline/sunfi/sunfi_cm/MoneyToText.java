/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.io.File;
import java.util.HashMap;

import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;

/**
 * @author kaifasishi82
 * @date 2019-01-23 14:54:26
 *
 */
@Bizlet("")
public class MoneyToText {
	
	
private static HashMap<Integer,String> dws;
	
	private static String[] jes;
	
	static{
		dws = new HashMap<Integer,String>();
		dws.put(-2, "分");
		dws.put(-1, "角");
		dws.put(0, "元");
		dws.put(1, "拾");
		dws.put(2, "佰");
		dws.put(3, "仟");
		dws.put(4, "万");
		dws.put(5, "拾");
		dws.put(6, "佰");
		dws.put(7, "仟");
		dws.put(8, "亿");
		dws.put(9, "拾");
		dws.put(10, "佰");
		dws.put(11, "仟");
		dws.put(12, "万");
		jes = new String []{"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};					
	}
	/**
	 * 
	 * 
	 * @param totlam
	 * @return
	 */
	@Bizlet("金额转大写")
	public String moneyToText(String totlam){
		StringBuffer su = new StringBuffer();
		totlam = delInvalidZero(totlam);
		String str = null;
		String decimal = null;
		if(totlam.contains(".")){
			str = totlam.split("\\.")[0];
			decimal = totlam.split("\\.")[1];
		}else{
			str = totlam;
		}
		if(str.length()>0){
			for(int i=0;i<str.length();i++){
				String context = str.substring(i,i+1);
				int pow = str.length()-i-1;
				Integer val = Integer.parseInt(context.toString());
				String sign = dws.get(pow);
				String name = jes[Integer.parseInt(context)];
				if(val==0){
					if(pow%4!=0){
						sign="";
					}
					if(i<str.length()-1){
						Integer val1 = Integer.parseInt(str.substring(i+1,i+2));
						if(val==0&&val==val1){
							name = "";
						}
					}else if(i ==str.length()-1){
						name ="";
					}
				}
				su.append(name+sign);
			}
		}
		if(decimal!=null){
			str = decimal.substring(0,1);
			if(!"0".equals(str)){
				su.append(jes[Integer.parseInt(str)]+dws.get(-1));
			}
			if(decimal.length()==2){
				str = decimal.substring(1,2);
				if(!"0".equals(str)){
					su.append(jes[Integer.parseInt(str)]+dws.get(-2));
				}
			}
		}else{
			su.append("整");
		}
		return "大写金额："+su.toString();
	}
	
	public static String delInvalidZero(String str){
		if("0".equals(str.substring(0,1))){
			return delInvalidZero(str.substring(1, str.length()));
		}else if(str.contains(",")){
			return delInvalidZero(str.replace(",",""));
		}
		return str;
	}
	
	@Bizlet("地址")
	public String path(){
		ApplicationContext context = ApplicationContext.getInstance(); 
		String WarRealPath = context.getWarRealPath();
		if(WarRealPath.endsWith(File.separator) == false) {
			WarRealPath = WarRealPath + File.separator;
		}		
		String filepath = WarRealPath  + "report" + File.separator; 
		
		return filepath;
	}

}
