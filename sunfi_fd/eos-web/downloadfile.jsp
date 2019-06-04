<%@ page contentType="application/pdf;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%
	response.reset();
    response.setCharacterEncoding("utf-8");
	String filePath = request.getParameter("filePath");	
	String fileName = request.getParameter("fileName");	
	fileName = new String(fileName.getBytes(),"ISO_8859-1");
	response.addHeader("content-Disposition","attachment;filename="+fileName);
	File file =new File(filePath);
	FileInputStream fs = new FileInputStream(file);
	BufferedInputStream  bufferedInputStream = new BufferedInputStream (fs);
    byte[] bytes = new byte[(int)file.length()]; 
	bufferedInputStream.read(bytes);
	response.setContentType("application/x-download");
	response.setContentLength(bytes.length);
	response.getOutputStream().write(bytes, 0, bytes.length);
	response.getOutputStream().flush();
	response.getOutputStream().close();//此时response已关闭，后续不能再继续有对response的处理，否则会报：java.io.IOException: response already committed
	fs.close();
	bufferedInputStream.close();
	out.clear();
    out = pageContext.pushBody(); 
%>