<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>	
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-17 12:20:52
  - Description:
-->
<head>
<title>批量审核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div  class="nui-panel" title="审批" style="width: 100%;">
<div  class="" id="form1">
        <input class="nui-hidden" name="workFlowMap" id="workFlowMap"/>
	     <table class="nui-form-table" align="center">		     
		      <tr>
			     <td class="nui-form-table-text" style="width: 30%">下一处理步骤:</td>
			     <td><input class="nui-dictcombobox" onvaluechanged="onChanged" id="appFlow" name="appFlow" style="width: 80px;"  textField="text" valueField="id"/></td>
		     </tr>
		      <tr>
			     <td class="nui-form-table-text">意见:</td>
			     <td><input class="nui-textarea" name="messages" style="width: 400px; height: 50px;"/></td>
		     </tr>
	     </table>
     </div>
      <div class="nui-toolbar" id="operate" style="border-bottom:0;padding:0px;">
	     <table style="width:100%;">
            <tr>
                 <td style="text-align:center;">
                  			<a class="nui-button"  onclick="ok()">
                                	提交
                            </a>
                            <a class="nui-button" id="close" onclick="closeWin()">
                                	关闭
                            </a>
            </tr>
        </table>    
     </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	var form  = new nui.Form("#form1");
    	function onChanged(){
		 var appFlow = nui.get("appFlow").getValue();
		 if(appFlow=="AGREE"){
		   nui.getbyName("messages").setValue("同意");
		 }else if(appFlow=="ROLLBACK"){
		   nui.getbyName("messages").setValue("退回");
		 }else if(appFlow=="CANCEL"){
		  nui.getbyName("messages").setValue("作废");
		 }else if(appFlow=="REFUSE"){
		  nui.getbyName("messages").setValue("撤回");
		 };	 
	   };
	  	//关闭窗口             
	  	function closeWin(){
	   	  CloseWindow("cancel");
	 	 }
	   //关闭窗口
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow)
	        return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	 	function ok(){
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:"com.sunline.sunfi.sunfi_wf.listworkitembiz.submitWorkitems.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            if(returnJson.retCode=="0"){
                                nui.alert("批量审核成功!", "提示", function(action){
                                 if(action=="ok") CloseWindow("saveSuccess");
                                });
                            }else{
                               nui.alert("批量审批错误","提示");
                            }
                        }else{
                            nui.alert("批量审批错误,请联系开发人员", "系统提示");
                            }
                        }
                        });
	  
	  	}
	  	$(function (){
	  	 var url ="<%=request.getContextPath() %>/sunfi_wf/workitem/role_emp_other.txt";
	  	 nui.get("appFlow").setUrl(url);
         nui.get("appFlow").select(0);
         nui.getbyName("messages").setValue("同意");  	
	  	});
	  	function SetData(data){	  	
	  	var  json = data;	  	
	  	nui.get("workFlowMap").setValue(json);
	  	};
    </script>
</body>
</html>