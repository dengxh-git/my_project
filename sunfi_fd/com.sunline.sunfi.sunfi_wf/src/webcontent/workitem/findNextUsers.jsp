<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-09 19:00:52
  - Description:
-->
<head>
<%@include  file="/common.jsp"%>
<title>findNextUsers</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width:100%;height:100%;">
<div  class="nui-datagrid"  id="datagrid" style="height: 300px; width: 100%;" multiSelect="false"
dataField="nextUser"  showPager="true" onrowdblclick="onOk" url="com.sunline.sunfi.sunfi_wf.workFlowCom.findNextUsers.biz.ext">
    <div property="columns">
        <div type="checkcolumn"></div>
        <div field="empid" width="" headerAlign="" allowSort="true">编号</div>
        <div field="userid" width="" headerAlign="" allowSort="true">代码</div>
        <div field="empname" width="" headerAlign="" allowSort="true">名称</div>
        <div field="rolename" width="" headerAlign="" allowSort="true">角色名称</div>
        <div field="roleid" width="" headerAlign="" allowSort="true" visible="false">角色编号</div>
    </div>
</div>
<div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;"  onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;"  onclick="onCancel()">取消</a>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	var grid  = nui.get("datagrid");
    	function setData(data){
    	    data = nui.clone(data); //如果是点击编辑类型页面          
            grid.load(data);       
    	}
    	function getData() {
	        var row = grid.getSelecteds();
	        return row;
	    }
    	function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	
	    function onOk() {
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
    </script>
</body>
</html>