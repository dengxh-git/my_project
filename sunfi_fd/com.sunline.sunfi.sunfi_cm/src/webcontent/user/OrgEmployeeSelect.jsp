<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-27 15:35:03
- Description:
    --%>
    <head>
        <title>
           OA用户查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />                
    </head>
    <body>
            <div id="form1" class="nui-form" style="height: 10%">
                <input class="nui-hidden" name="criteria/_entity" value="com.sunline.sunfi.sunfi_cm.user.OrgEmployee" />
                <table id="table1" class="table" style="height:100%;width:100%;">
                    <tr>
                        <td style="font-size: 12px;text-align: right;">
                           用户代码:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[1]/userid"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            用户名称:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[2]/empname"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                        </td>
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
            <div class="nui-fit">
                <div id="empgrid" dataField="orgemployee" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comuserbiz.queryOrgEmployee.biz.ext" pageSize="10" showPageInfo="true" 
                  onrowdblclick="onOk">
                    <div property="columns">
                        <div type="checkcolumn"></div>                       
                        <div field="userid" headerAlign="center" allowSort="true">用户代码 </div>
                        <div field="empname" headerAlign="center" allowSort="true">用户名称</div>
                    </div>
                </div>
            </div>
        <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;"  onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;"  onclick="onCancel()">取消</a>
    </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("empgrid");
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
