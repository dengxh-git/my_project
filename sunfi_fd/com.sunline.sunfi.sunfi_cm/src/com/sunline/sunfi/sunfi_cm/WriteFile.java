/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.math.BigDecimal;
import java.util.Map;

import org.jdom.JDOMException;

import com.eos.system.annotation.Bizlet;
import com.sunline.sunfi.config.FIConfig;
import com.eos.foundation.common.utils.FileUtil;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2019-01-14 19:47:05
 *
 */
@Bizlet("")
public class WriteFile {
	
	@Bizlet("财务接口发生额文件")
	public static String writeFMSAccrualFile(Map params, DataObject[] expaeuvs,String localpath) {

		String bsnsdt = (String) params.get("bsnsdt");
		String fileName = (String) params.get("filename");
		String filePath = "";		
	    filePath = localpath;
		filePath = filePath.concat(fileName);
		String temp = "|";
		String param = "\n";
		String sumD ="0.000";
		String sumC ="0.000";
		BigDecimal sumD1 = new BigDecimal("0.000");
		BigDecimal sumC1 = new BigDecimal("0.000");
		
		StringBuffer writeBuffer = new StringBuffer();		
		//文件头的位置
		//循环发生额
		for (int i = 0; i < expaeuvs.length; i++) {
			DataObject obj = (DataObject) expaeuvs[i];
			String acctbr = (String) obj.get("acctbr") ;
			if(acctbr == null){
				acctbr = "";
			}
			String dutycd = (String) obj.get("dutycd") ;
			if(dutycd == null){
				dutycd = "";
			}
			String crcycd = (String) obj.get("crcycd") ;
			if(crcycd == null){
				crcycd = "";
			}
			String itemcd = (String) obj.get("itemcd") ;
			if(itemcd == null){
				itemcd = "";
			}
			String trandt = (String) obj.get("trandt") ;
			if(trandt == null){
				trandt = "";
			}
			String strkst = (String) obj.get("strkst") ;
			if(strkst == null){
				strkst = "";
			}
			String bsnssq = (String) obj.get("bsnssq") ;
			if(bsnssq == null){
				bsnssq = "";
			}
			String totalC = (String) obj.get("totalC") ;
			if(totalC == null){
				totalC = "";
			}			
			String totalD = (String) obj.get("totalD") ;
			if(totalD == null){
				totalD = "";
			}						
			String numD = "0";
			String numC = "0";
			//判断是贷方金额还是借方金额
			if(totalC.equals("0")){
				numC = "0";
			    numD = "1";
			}else{
				numC = "1";
			    numD = "0";
			}
			//累计借方金额	
			BigDecimal sumDx = new BigDecimal(sumD);
			BigDecimal totalD1 = new BigDecimal(totalD);
			BigDecimal totalDScale = totalD1.setScale(3, BigDecimal.ROUND_UNNECESSARY);
			sumD1 = sumDx.add(totalDScale);
			sumD = sumD1.toString();
			
			//累计贷方金额	
			BigDecimal sumCx = new BigDecimal(sumC);
			BigDecimal totalC1 = new BigDecimal(totalC);
			BigDecimal totalCScale = totalC1.setScale(3, BigDecimal.ROUND_UNNECESSARY);			
			sumC1 = sumCx.add(totalCScale);
			sumC = sumC1.toString();
			
			
			writeBuffer.append(acctbr).append(temp).//机构			
			append(dutycd).append(temp).//责任中心
			append(crcycd).append(temp).//币种
			append(itemcd).append(temp).//科目
			append("0").append(temp).//标识符：0正常
			append(totalDScale).append(temp).//借方发生额
			append(totalCScale).append(temp).//贷方发生额
			append(numD).append(temp).//借方发生笔数
			append(numC).append(temp).//贷方发生笔数
			append("0.000").append(temp).//冲正借方发生额
			append("0.000").append(temp).//冲正贷方发生额
			append("0").append(temp).//冲正借方发生笔数
			append("0").append(temp).//冲正贷方发生笔数
			append(trandt).append(temp).//记账日期
			append(bsnssq).append(temp).//流水号
			append(param);			
		}
		writeBuffer.append("END").append(temp).//结尾标志		
		append(expaeuvs.length).append(temp).//总笔数
		append(bsnsdt).append(temp).//过账日期
		append(sumD1).append(temp).//累计借方发生额
		append(sumC1).append(temp).//累计贷方发生额
		append("0.000").append(temp).//累计冲正借方发生额
		append("0.000").append(temp).//累计冲正贷方发生额
		append(param);
		FileUtil.writeFile(filePath, writeBuffer.toString(),"GBK");

		return filePath;
	}
	
	@Bizlet("财务接口发生总额文件")
	public static String writeFMSAccrualFileAll(Map params, DataObject[] expaeuvsall,String localpath) {

		String bsnsdt = (String) params.get("bsnsdt");
		String fileName = (String) params.get("filename");
		String filePath = "";		
		filePath = localpath;		
		filePath = filePath.concat(fileName);
		String temp = "|";
		String param = "\n";	
		StringBuffer writeBuffer = new StringBuffer();		
		//文件头的位置
		//循环发生额
		for (int i = 0; i < expaeuvsall.length; i++) {
			DataObject obj = (DataObject) expaeuvsall[i];
			String acctbr = (String) obj.get("acctbr") ;
			if(acctbr == null){
				acctbr = "";
			}
			String dutycd = (String) obj.get("dutycd") ;
			if(dutycd == null){
				dutycd = "";
			}
			String crcycd = (String) obj.get("crcycd") ;
			if(crcycd == null){
				crcycd = "";
			}
			String itemcd = (String) obj.get("itemcd") ;
			if(itemcd == null){
				itemcd = "";
			}			
			String total = (String) obj.get("total") ;
			if(total == null){
				total = "";
			}
			BigDecimal total1 = new BigDecimal(total);
			BigDecimal totalScale = total1.setScale(3, BigDecimal.ROUND_UNNECESSARY);		
			String amntcd = (String) obj.get("amntcd") ;
			if(amntcd == null){
				amntcd = "";
			}
			BigDecimal totalC=new BigDecimal("0.000");
			BigDecimal totalD=new BigDecimal("0.000");
			if(amntcd.equals("D")){
				totalD=totalScale;				
			}else{
				totalC=totalScale;				
			}						
			writeBuffer.append(acctbr).append(temp).//机构			
			append(dutycd).append(temp).//责任中心
			append(crcycd).append(temp).//币种
			append(itemcd).append(temp).//科目			
			append(totalD).append(temp).//借方发生额
			append(totalC).append(temp).//贷方发生额
			append(bsnsdt).append(temp).//入账日期
			append(param);			
		}		
		FileUtil.writeFile(filePath, writeBuffer.toString(),"GBK");

		return filePath;
	}

}
