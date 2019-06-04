<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-14 18:58:03
  - Description:
-->
<head>
<title>endfile</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />   
</head>
<style type="text/css">
      .mini-textbox-border,
      .mini-textbox-input,
      .mini-buttonedit-border,
      .mini-buttonedit-input,
      .mini-textboxlist-border{
        border:0;background:none;cursor:default;
       }
    </style>
<body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
  <div title="日终管理" visible="true" >            
<div id="form1" class="nui-form" align="center" style="height:10%">
	<table id="table1" class="nui-form-table" style="height:100%">
		<tr>
		<td style="text-align: right;font-size: 12px;border: 1px solid #DCDCDC;">提示:当前业务日期：</td>
		<td style="text-align: left;border: 1px solid #DCDCDC;"><input class="nui-textbox" name="comstac.bsnsdt" readonly="readonly"/></td>
		</tr>
		<tr>
		<td style="text-align: center; border: 1px solid #DCDCDC;" colspan="2"> <a class="nui-button" onclick="ok()">
                开始日终
            </a></td>
		</tr>
	</table>
</div>
</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#form1");
    	$(function(){ 
    	 var data = {stacid:"1"};
    	 var json  = nui.encode({comstac:data});
		  $.ajax({
		            url:"com.sunline.sunfi.sunfi_cm.comstacbiz.getComStac.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                  form.setData(returnJson);
                          form.setChanged(false);
		                }else{
		                   nui.alert("获取业务时间错误!");		                        
		                    }
		                }
		            });
			
    	});
    	
    	function ok(){
    	     var data = {stacid:"1"};
    	     var json  = nui.encode({comstac:data});
    	    $.ajax({
		            url:"com.sunline.sunfi.sunfi_cm.endfmsfile.endfmsfile.biz.ext",
		            type:'POST',
		            //data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                   if(returnJson.retCode.result=="1"){
		                   nui.alert("生成文件成功");
		                   //location.reload();
		                    $.ajax({
				            url:"com.sunline.sunfi.sunfi_cm.comstacbiz.getComStac.biz.ext",
				            type:'POST',
				            data:json,
				            cache:false,
				            contentType:'text/json',
				            success:function(text){
				                var returnJson = nui.decode(text);
				                if(returnJson.exception == null){
				                  form.setData(returnJson);
		                          form.setChanged(false);
				                }else{
				                   nui.alert("获取业务时间错误!");		                        
				                    }
				                }
				            });
		                   }else{
		                    nui.alert("生成文件错误,请检查");
		                   }
		                }else{
		                   nui.alert("日终错误!");		                        
		                    }
		                }
		            });
    	
    	};
    	
    </script>
</body>
</html>