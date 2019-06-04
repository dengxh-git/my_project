<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>	
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-14 11:01:57
  - Description:
-->
<head>
<title>capRoleSelect</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="form1" class="nui-form" style="height: 10%">
 <table id="table1" class="table" style="height:100%;width:100%;">
                    <tr>
                        <td style="font-size: 12px;text-align: right;">
                           角色代码:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[1]/roleCode"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            角色名称:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[2]/roleName"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                    </tr>
                </table>
</div>
  <div property="footer" align="center">
            <a class="nui-button" onclick="search()">
                查询
            </a>
            <a class="nui-button" onclick="reset()">
                重置
            </a>
        </div>   
<div id="datagrid"  class="nui-datagrid" dataField="caprole" url="com.sunline.sunfi.sunfi_cm.comuserbiz.queryCapRoles.biz.ext"
pageSize="10" showPageInfo="true" onrowdblclick="onOk">
    <div property="columns">
        <div field="roleId" allowSort="true">角色id</div>
        <div field="roleCode" allowSort="true">角色代码</div>
        <div field="roleName" allowSort="true">角色名称</div>
        <div field="appid" allowSort="true">所属应用</div>
        <div field="roleDesc" allowSort="true">角色描述</div>
    </div>
</div>
<div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;"  onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;"  onclick="onCancel()">取消</a>
    </div>
	<script type="text/javascript">
    	  nui.parse();
    	  var grid = nui.get("datagrid");
    	  var formData = new nui.Form("#form1").getData(false,false);    
          grid.load(formData);
          function getData() {
		        var row = grid.getSelected();
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
          //查询
          function search() {
            var form = new nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
           }
            //重置查询条件
           function reset(){
                var form = new nui.Form("#form1");//将普通form转为nui的form
                form.reset();
            }    
    </script>
</body>
</html>