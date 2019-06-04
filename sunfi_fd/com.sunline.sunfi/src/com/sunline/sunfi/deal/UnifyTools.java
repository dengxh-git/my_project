/**
 * 
 */
package com.sunline.sunfi.deal;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;

import org.apache.axis2.engine.ListenerManager;
import org.apache.commons.codec.binary.Hex;

import com.alibaba.fastjson.JSON;
import com.eos.system.annotation.Bizlet;
import com.sunline.sunfi.deal.PortalTodoUnifyParam;
import com.sunline.sunfi.deal.PortalTodoUnifyParamBody;
import com.sunline.sunfi.sunfi_cm.ComPara;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2018-11-20 14:50:28
 *
 */
@Bizlet("")
public class UnifyTools {

	/**
	 * @param url
	 * @param paramJson
	 * @return
	 * @author kaifasishi82
	 */
	String  hostUrl = ComPara.getParavl("1", "IP_EMS");
	String  hostUrlPortal = ComPara.getParavl("1", "IP_PORTAL");
	String  EmsUnique = ComPara.getParavl("1", "EMS_UNIQUE");
	
	@Bizlet("数据上传")
	public static String HttpUrRequestl(String url, String paramJson) {
		PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            conn.setRequestProperty("Content-type", "application/json; charset=utf-8");
        //  conn.setRequestProperty("Content-Type","multipart/form-data; boundary=----WebKitFormBoundaryY1x6mrLQzLKXTx7F");
            conn.setConnectTimeout(10000);//设置超时
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            out.print(paramJson);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            //添加读取的编码格式 
            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            try {
				throw e;
			} catch (Exception e1) {
				e1.printStackTrace();
			}
            System.out.println("发送post请求异常"+e);
            e.printStackTrace();
            return "ERROR:请求异常";
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                try {
					throw ex;
				} catch (IOException e) {
					e.printStackTrace();
				}
                return "ERROR:关闭输出流、输入流异常";
            }
        }
        //log.info("消息推送返回结果："+result);
        System.out.println("调用服务返回结果："+result);
        return result;
	}

	/**
	 * @param data
	 * @return
	 * @author kaifasishi82
	 * @throws UnsupportedEncodingException 
	 */
	@Bizlet("数据处理")
	public String insertTodoUnifys(DataObject[] data) throws UnsupportedEncodingException {
		ListenerManager.defaultConfigurationContext = null;
		PortalTodoUnifyParam[] todoUnifys =new PortalTodoUnifyParam[data.length];
		for(int i=0;i<data.length;i++){
			PortalTodoUnifyParam todoUnify = new PortalTodoUnifyParam();
			todoUnify.setTaskTime(data[i].getDate("taskTime"));
			String url = hostUrl.concat(data[i].getString("processUrl"));	
			/*String taskType = "1";
			String taskState = "0";
			String view = "";//用于加密
*/			todoUnify.setAppCode("cwxt");//财务系统编码	
            String AppName = data[i].getString("appName");//财务系统
            AppName = new String(AppName.getBytes("UTF-8"));
			todoUnify.setAppName(AppName);
			todoUnify.setTaskId(data[i].getString("taskId"));
			String title = data[i].getString("taskName");
			if(checkLength(data[i].getString("taskName"))>150){
				title =  data[i].getString("taskName").substring(0,40);
			}
			title = new String(Hex.encodeHex(title.getBytes("UTF-8")));
			//title = title.replaceAll("\\+","%20");
			todoUnify.setTaskName("<![CDATA["+title.toUpperCase()+"]]>");
			todoUnify.setCurrUserid(data[i].getString("currUserid"));
			String currUsername = data[i].getString("currUsername");
			if(checkLength(data[i].getString("currUsername"))>30){
				currUsername = data[i].getString("currUsername").substring(0,9);
			}
			todoUnify.setCurrUsername("<![CDATA["+new String(Hex.encodeHex(currUsername.getBytes("UTF-8"))).toUpperCase()+"]]>");
			todoUnify.setDeptId(data[i].getString("deptId"));
			//todoUnify.setDeptName(data[i].getString("deptId"));
			/*if(data[i].getString("currentState").equals("10")){//待办
				taskType = "0";
				taskState = "0";
				view = "false";
			}else if(data[i].getString("currentState").equals("12")){//已办
				taskType = "1";
				taskState = "1";
				view = "true";
			}else{
				taskType = "2";
				taskState = "1";
				view = "true";
			}*/
			/*String sigValue = CryptoUtil.encryptByDES(view+workItemID, "cap_user");
			System.out.println(sigValue);*/
			//url待后期加工处理
			//url = url+"?workItemID="+workItemID+"&view="+view;
			//url = Hex.encodeHexString(url.getBytes());
			url =  new String(Hex.encodeHex(url.getBytes("UTF-8")));
			todoUnify.setProcessUrl("<![CDATA["+url.toUpperCase()+"]]>");
			todoUnify.setTaskType((data[i].getString("taskType")));
			todoUnify.setTaskState((data[i].getString("taskState")));
			todoUnify.setProductTime(new Date());
			todoUnify.setProcessInstanceId(data[i].getString("processInstanceId"));
			String processBelong = data[i].getString("processBelong");
			if(checkLength(data[i].getString("processBelong"))>100){
				processBelong = data[i].getString("processBelong").substring(0,25);
			}
			processBelong =new String(Hex.encodeHex(processBelong.getBytes("UTF-8"))); 
			todoUnify.setProcessBelong("<![CDATA["+processBelong.toUpperCase()+"]]>");
			todoUnifys[i] = todoUnify;
		}
		PortalTodoUnifyParamBody paramBody = new PortalTodoUnifyParamBody();
		paramBody.setPortalTodoUnifyParam(todoUnifys);
		paramBody.setUnique(EmsUnique);
		String paramJson = JSON.toJSONString(paramBody);
		
		String result = UnifyTools.HttpUrRequestl(hostUrlPortal+"/api/unify/insert/insertTodoUnify", paramJson);
		return result;
	}

	//校验字符长度
	public int checkLength(String temp){//校验字符长度
		int i,sum;
		sum=0;
	 	for(i=0;i<temp.length();i++) {
	  		if((temp.charAt(i)>=0) && (temp.charAt(i)<=255)){
	   			sum=sum+1;
	  		}else{
	   			sum=sum+3;
	 		}
	 	}
	 	return sum;
	}
}
