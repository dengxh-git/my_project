<!-- 
  - Author(s): 安宣部
  - Date: 2010-11-05 08:06:59
  - Description:
-->
<%@ page contentType="application/pdf;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%
	response.reset();
	String filePath = request.getParameter("filePath");
	filePath = filePath.replace("&#x2F;", "/");
	File file =new File(application.getRealPath(filePath));
	FileInputStream fs = new FileInputStream(file);
	BufferedInputStream  bufferedInputStream = new BufferedInputStream (fs);
    byte[] bytes = new byte[(int)file.length()]; 
	bufferedInputStream.read(bytes);
	response.setContentType("application/pdf");
	response.setContentLength(bytes.length);
	response.getOutputStream().write(bytes, 0, bytes.length);
	response.getOutputStream().flush();
	response.getOutputStream().close();//此时response已关闭，后续不能再继续有对response的处理，否则会报：java.io.IOException: response already committed
	fs.close();
	bufferedInputStream.close();
	out.clear();
    out = pageContext.pushBody(); 
%>