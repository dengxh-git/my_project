/**
 * 
 */
package com.sunline.sunfi.sunfi_wf.util;

import java.math.BigDecimal;
import java.util.HashMap;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2019-01-14 17:32:25
 *
 */
@Bizlet("")
public class Wfflowlistisexist {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Bizlet("比较")
	public HashMap  compare(DataObject wfflowlist, DataObject[] wfflowlists){
	HashMap map = new HashMap();	
	String  minsum1 =(String) wfflowlist.getString("minsum");
	String  pageType = (String) wfflowlist.getString("pageType");
	if(minsum1==null){
		minsum1="0.00";
	}
	String  maxsum1 =(String) wfflowlist.getString("maxsum");
	if(maxsum1==null){
		maxsum1="999999999999.00";
	}
	//修改时获取以前的数据
	String  minsumold1 =(String) wfflowlist.getString("minsumold");
	/*if(minsumold1==null){
		minsumold1="0.00";
	}
	String  maxsumold1 =(String) wfflowlist.getString("maxsumold");
	if(maxsumold1==null){
		maxsumold1="999999999999.00";
	}*/
	BigDecimal minsum =new BigDecimal(minsum1) ;//最小金额
	BigDecimal maxsum = new BigDecimal(maxsum1) ;//最大金额
	/*BigDecimal minsumold =new BigDecimal(minsumold1) ;//最小金额
	BigDecimal maxsumold = new BigDecimal(maxsumold1) ;//最大金额
*/	BigDecimal queryminsum = new BigDecimal("0.00");
	BigDecimal querymaxsum = new BigDecimal("0.00");
	for(int i=0;i<wfflowlists.length;i++){
	 DataObject obj = (DataObject)wfflowlists[i];	
	 String queryminsum1 = (String) obj.getString("minsum");
	 if(queryminsum1==null){
		 queryminsum1="0.00";
	  }
	 String querymaxsum1 = (String) obj.getString("maxsum");
	 if(querymaxsum1==null){
		 querymaxsum1="999999999999.00";
	 }		
	 queryminsum = new BigDecimal(queryminsum1) ;//最小金额
	 querymaxsum = new BigDecimal(querymaxsum1) ;//最大金额
	 //判断新增的最大值是否大于查询出来的最大值
	  
	 //最大值小于查询出来最大值
	 if(maxsum.compareTo(querymaxsum)==-1){
		 map.put("result",1);
	     map.put("queryminsum",queryminsum);
	     map.put("querymaxsum",querymaxsum);
	     return map; 		 
	 }
	 //最大值大于查询出来最大值
	 else if(maxsum.compareTo(querymaxsum)==1){
		 //判断最小值是否大于查询出来的最大值
		// 最小值大于等于查询出来的最大值
		if(minsum.compareTo(querymaxsum)==1 || minsum.compareTo(querymaxsum)==0){
			 map.put("result",0);
		     map.put("queryminsum",queryminsum);
		     map.put("querymaxsum",querymaxsum);		     
		}//最小值小于查询出来的最大值
		else{
			//最大值为"999999999999.00"
			if(maxsum.compareTo(new BigDecimal("999999999999.00"))==0){
				//最小值小于查询出来的最大值
				if(minsum.compareTo(querymaxsum)==-1){
					 map.put("result",1);
				     map.put("queryminsum",queryminsum);
				     map.put("querymaxsum",querymaxsum);
				     //return map;
				}else{
					 map.put("result",0);
				     map.put("queryminsum",queryminsum);
				     map.put("querymaxsum",querymaxsum);
				     return map;
				}
			//最大值为其它情况	
			}else{
			 map.put("result",1);
		     map.put("queryminsum",queryminsum);
		     map.put("querymaxsum",querymaxsum);
		     return map;
			}
		} 
	 }
	  //最大值等于查询出来最大值
	 else{
		//最小值大于查询最小值
		if(minsum.compareTo(queryminsum)==1){
			//最大值为"999999999999.00"
			if(maxsum.compareTo(new BigDecimal("999999999999.00"))==0){
				 map.put("result",0);
			     map.put("queryminsum",queryminsum);
			     map.put("querymaxsum",querymaxsum);
			     return map;
			}
			//最大值为其它情况
			else{
				 map.put("result",1);
			     map.put("queryminsum",queryminsum);
			     map.put("querymaxsum",querymaxsum);
			     return map;			
			}		
		}
		//最小值等于查询出来的最小值
		else if(minsum.compareTo(queryminsum)==0){
			 if(minsumold1 !="" && minsumold1 !=null){
				 map.put("result",0); 
			 }else{
				 map.put("result",1);
			 }			 
		     map.put("queryminsum",queryminsum);
		     map.put("querymaxsum",querymaxsum);
		     //return map;			
		}else{
			 map.put("result",1);
		     map.put("queryminsum",queryminsum);
		     map.put("querymaxsum",querymaxsum);
		     return map;			
			
		} 
		 
	 }	
 }
	return map;
}
}
