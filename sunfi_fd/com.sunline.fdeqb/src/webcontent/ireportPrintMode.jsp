<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-22 17:00:20
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body onload="printweb();" >
	<input class="nui-hidden" name="isprnt"/>
	<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" id="pdf" width="100%" height="100%">  
  		<param name="_ExtentX" value="2646">  
  		<param name="_ExtentY" value="1323">  
  		<param name="_StockProps" value="0">  
  		<param name="SRC" value="com.sunline.sunfi.sunfi_cm.IReportPrintPdf.flow?filePath=<%= request.getParameter("filePath")%>">  
	</object> 
	
	<script type="text/javascript">
    	nui.parse();
    	var pdf = nui.get("pdf");
    	
    	function printweb(){
			try{
		    	pdf.setShowToolbar(false);
		    }catch(e){
		    }	
			if(nui.getbyName("isprnt").getValue == "true"){
				pdf.printAll();
			}
		}
		function printHand(){
			pdf.printAll();
		}
    </script>
</body>
</html>