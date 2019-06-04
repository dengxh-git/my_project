<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-05-16 13:07:16
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<fieldset style="width:400px;border:solid 1px #aaa;position:relative;">
    	<legend>股权证变更信息</legend>
    	<form id="upload" action="com.sunline.fdeqb.eqpshhbiz.impEqpBlackShhd.biz.ext" method="post" enctype="multipart/form-data">
    		<input class="nui-hidden" name="entityNa" value="com.sunline.fdeqb.eqp.ImpEqpBlackShhd">
	    	上传文件：<input class="mini-htmlfile" name="uploadfile" limitType="*.xlsx" />
	        	<input type="submit" value="上传"/>
	    </form>
	</fieldset>
		

	<script type="text/javascript">
    	nui.parse();
    	
    	function startUpload() {
	        var fileupload = mini.get("fileupload1");
	        fileupload.startUpload();
	    }
	    	
    	function onUploadSuccess(){
    	
    	}
    </script>
</body>
</html>