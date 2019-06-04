package com.sunline.sunfi.util;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;

import com.eos.system.annotation.Bizlet;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.SCPClient;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;

/**
 * Provides static methods for running SSH, scp as well as local commands.
 *
 */
public class SSHCommandRunner {
	private static final Logger logger = Logger.getLogger(SSHCommandRunner.class);

	private SSHCommandRunner() {
	}

	/**
	 * Get remote file through scp
	 * @param host
	 * @param username
	 * @param password
	 * @param remoteFile
	 * @param localDir
	 * @throws IOException
	 */
	public static void scpGet(String host, int port, String username, String password,
			String remoteFile, String localDir) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("spc [" + remoteFile + "] from " + host + " to " + localDir);
		}
		Connection conn = getOpenedConnection(host, port, username, password);
		SCPClient client = new SCPClient(conn);
		client.get(remoteFile, localDir);
		conn.close();
	}

	/**
	 * Put local file to remote machine.
	 * @param host
	 * @param username
	 * @param password
	 * @param localFile
	 * @param remoteDir
	 * @throws IOException
	 */
	public static void scpPut(String host, int port, String username, String password,
			String localFile, String remoteDir) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("spc [" + localFile + "] to " + host + remoteDir);
		}
		Connection conn = getOpenedConnection(host, port, username, password);
		SCPClient client = new SCPClient(conn);
		client.put(localFile, remoteDir);
		conn.close();
	}

	/**
	 * Run SSH command.
	 * @param host
	 * @param username
	 * @param password
	 * @param cmd
	 * @return exit status
	 * @throws IOException
	 */
	@Bizlet(value = "通过SSH执行脚本")
	public static int runSSH(String host, int port, String username, String password,
			String cmd) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("running SSH cmd [" + cmd + "]");
		}
		int ret = -1;
		int outresult = 0;
		Connection conn = getOpenedConnection(host, port, username, password);
		Session sess = conn.openSession();
		sess.execCommand(cmd);

		InputStream stdout = new StreamGobbler(sess.getStdout());
		BufferedReader br = new BufferedReader(new InputStreamReader(stdout));

		while (true) {
			// attention: do not comment this block, or you will hit NullPointerException
			// when you are trying to read exit status
			String line = br.readLine();
			if (line == null)
				break;
			if (logger.isDebugEnabled()) {
				logger.debug(line);
			}
			if(-1 != line.indexOf("result=0")){//输出result=0表示执行成功
				outresult = 1;
			}
		}

		sess.close();
		conn.close();
		ret = sess.getExitStatus().intValue();
		if(ret != 0 || outresult != 1){
			ret = -1;
		}
		
		return ret;
	}

	/**
	 * return a opened Connection
	 * @param host
	 * @param username
	 * @param password
	 * @return
	 * @throws IOException
	 */
	private static Connection getOpenedConnection(String host, int port, String username,
			String password) throws IOException {
//		if (logger.isDebugEnabled()) {
//		logger.debug("connecting to " + host + " with user " + username
//		+ " and pwd " + password);
//		}

		Connection conn = new Connection(host, port);
		conn.connect(); // make sure the connection is opened
		boolean isAuthenticated = conn.authenticateWithPassword(username,
				password);
		if (isAuthenticated == false)
			throw new IOException("Authentication failed.");
		return conn;
	}

	/**
	 * Run local command
	 * @param cmd
	 * @return exit status
	 * @throws IOException
	 */
	@Bizlet(value = "执行本地脚本")
	public static int runLocal(String cmd) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("running local cmd [" + cmd + "]");
		}
		int ret = -1;
		int outresult = 0;
		
		Runtime rt = Runtime.getRuntime();
		Process p = rt.exec(cmd);

		InputStream stdout = new StreamGobbler(p.getInputStream());
		BufferedReader br = new BufferedReader(new InputStreamReader(stdout));

		while (true) {
			String line = br.readLine();
			if (line == null)
				break;
			if (logger.isDebugEnabled()) {
				logger.debug(line);
			}
			if(-1 != line.indexOf("result=0")){//输出result=0表示执行成功
				outresult = 1;
			}
		}
		br.close();
		stdout.close();
		ret = p.exitValue();
		p.destroy();
		
		if(ret != 0 || outresult != 1){
			ret = -1;
		}
		
		return ret;
	}

	/**
	 * 测试
	 * @param args
	 */
	public static void main( String[] args ) {    
		try {    
			System.out.println( "Start SSH..." );    
			String host = "11.0.34.2"; 
			int port = 22; 
			String user = "oracle";    
			String password = "oracle";
			int ret = SSHCommandRunner.runSSH(host,port,user,password,"/home/weblogic/sunlineappc/test.sh");
			System.out.println( "ret:" +ret );  
		} catch ( Exception e ) {    
			e.printStackTrace();    
		}    
	}    
}