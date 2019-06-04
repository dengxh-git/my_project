/**
 * 
 */
package com.sunline.sunfi.util;

import java.util.Random;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.system.annotation.Bizlet;

/**
 * @author kaifasishi82
 * @date 2019-01-16 09:20:45
 *
 */
@Bizlet("url��������")
public class UrlTools {
	/**
	 * ��ȡ����ַ�
	 * @param num
	 * @return
	 */
	@Bizlet("��ȡ����ַ�")
	public static String getRandom(int num){
		String str="abcdefghigklmnopqrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ0123456789";
		Random random=new Random();
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<num;i++){
			int number=random.nextInt(str.length());
			sb.append(str.charAt(number));
		}
		return sb.toString();
	}
	@Bizlet("�������ַ�")
	public static void putRandom(String num){
		
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		IUserObject userobject = muo.getUserObject();
		userobject.put("sigCache", num);
		
	}
	@Bizlet("׷������ַ�")
	public static String appendSig(String url,String random){
		String urlP="";
		urlP=url+random;
		return urlP;
	}		
}
