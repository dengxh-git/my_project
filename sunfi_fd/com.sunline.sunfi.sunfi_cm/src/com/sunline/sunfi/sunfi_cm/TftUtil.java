/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.eos.system.annotation.Bizlet;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

/**
 * @author kaifasishi82
 * @date 2019-01-14 19:52:44
 *
 */
@Bizlet("")
public class TftUtil {

 @Bizlet("FTF工具传输财务文件 ") 
 public String upFileFms(String filename,String filePath,String trandt,String serverip,String serverport,String ftpuser,String ftppwd,String ftpfilepath){
	File uploadFile = new File(filePath);
	InputStream in = null;
	try {
		in  = new FileInputStream(uploadFile);
	} catch (Exception e) {	
		e.printStackTrace();
	}
	String result="0";
	ChannelSftp sftp = new ChannelSftp();
	try {
		JSch jsch = new JSch();
		jsch.getSession(ftpuser,serverip,Integer.parseInt(serverport));
		Session sshSession =jsch.getSession(ftpuser,serverip,Integer.parseInt(serverport));
		System.out.println("session created!");
		sshSession.setPassword(ftppwd);
		Properties sshConfig = new Properties();
		sshConfig.put("StrictHostKeyChecking","no");		
		sshSession.setConfig(sshConfig);
		sshSession.connect();
		System.out.println("session connected!");
		System.out.println("session channel!");
		Channel channel = sshSession.openChannel("sftp");
		channel.connect();
		sftp = (ChannelSftp) channel;
		System.out.println("Connected to " + serverip +"!");
		sftp.cd(ftpfilepath);
		String st = trandt;
		//String st1 = "FINANCEAMT";
		//String st2 = "FINANCEBAL";
		try {
			sftp.cd(st);
			//sftp.mkdir(st2);
			//sftp.cd(st2);
		} catch (Exception e) {
			// TODO: handle exception
			sftp.mkdir(st);
			sftp.cd(st);
			//sftp.mkdir(st1);
			//sftp.cd(st1);
		}
		sftp.put(in,filename);		
		
		result="1";
		System.out.println(result);
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}finally{
		try {
			if(in !=null)
			in.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		sftp.disconnect();
	}
	 return result;
 }	
}
