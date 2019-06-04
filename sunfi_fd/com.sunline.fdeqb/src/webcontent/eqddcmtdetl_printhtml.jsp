<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-05-18 23:54:40
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
    <div style="text-align:center;padding:10px;">               
        <a class="nui-button" onclick="printweb" style="width:60px;margin-right:20px;">打印</a>
        <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
    </div>
    <!-- 打印预览页 -->
  	<div id="diva" style="display:block">
 		<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" id="pdfA" width="100%" height="100%">  
  			<param name="_ExtentX" value="2646">  
  			<param name="_ExtentY" value="1323">  
  			<param name="_StockProps" value="0">  
  			<param name="SRC" value="com.sunline.sunfi.sunfi_cm.IReportPrintPdf.flow?filePath=<%= request.getParameter("filePath")%>">  
		</object>  		
  	</div>
  	<!-- 打印页面 -->
  	<div id="divb" style="display:none">
 		<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" id="pdfB" width="100%" height="100%">
  			<param name="_ExtentX" value="2646">
  			<param name="_ExtentY" value="1323">
  			<param name="_StockProps" value="0">
  			<param name="SRC" value="com.sunline.sunfi.sunfi_cm.IReportPrintPdf.flow?filePath=<%= request.getParameter("filePath")%>">
		</object>  		
  	</div> 	     
</body>
	<Script language="JavaScript">
		nui.parse();
		//隐藏工具栏
		var pdfA = nui.get("pdfA");
		var pdfB = nui.get("pdfB");
		pdfA.setShowToolbar(false);
		pdfB.setShowToolbar(false);
		//nui.get("divb").hide();
		//打印
		function printweb(){
		  nui.get("divb").set({display:"block"});
		  
		  pdfB.printAll();  
		}
		
		function onCancel(){
		}
	</Script>
</html>
	