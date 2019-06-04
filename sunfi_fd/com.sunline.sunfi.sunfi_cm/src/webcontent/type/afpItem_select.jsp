<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): zyw
  - Date: 2019-01-02 17:17:24
  - Description:
-->
<head>
<title>业务项目获取</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />  
  <%
    	String isedit = request.getParameter("isedit");
    	String rpstcd = request.getParameter("schetp");
    	request.setAttribute("isedit", isedit);
    	request.setAttribute("rpstcd", rpstcd);
     %>  
</head>
 <body>
<div id="typeForm" class="nui-form" align="center" style="height:10%">
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.sunline.sunfi.sunfi_cm.type.afpItems">
                <!-- 排序字段 -->
                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="typecd">
                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
                <input class="nui-hidden" id="isedit" name="criteria/_expr[5]/isedit"/>
                <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td class="form_label">
                            业务代码:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/typecd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td class="form_label">
                            业务名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[2]/typena"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>
                        <td class="form_label">
                            科目代码:
                        </td>
                        <td colspan="1">
                            <input class="nui-buttonedit searchbox" name="criteria/_expr[3]/itemcd" onbuttonclick="selectItem" allowinput="false"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
                        </td>
                        <td class="form_label">
                            报账类型:
                        </td>
                        <td colspan="1">
                            <input class="nui-dictcombobox" dictTypeId="FI_EXPTP" id="rpstcd" name="criteria/_expr[4]/rpstcd"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>
        <!--footer-->
        <div property="footer" align="center">
            <a class="nui-button" onclick="search()">查询</a>
            <a class="nui-button" onclick="reset()"> 重置</a>
        </div>     
            <div class="nui-fit">
                <div id="datagrid1" dataField="afpitems" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.afpitembiz.queryAfpItems.biz.ext" pageSize="10" showPageInfo="true" 
                allowSortColumn="false" onrowdblclick="onOk">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="typecd" headerAlign="center" allowSort="true" > 业务代码</div>
                        <div field="typena" headerAlign="center" allowSort="true" > 业务名称</div>
                        <div field="itemcd" headerAlign="center" allowSort="true" > 对应科目</div>
                        <div field="itemna" headerAlign="center" allowSort="true" > 对应科目名称</div>
                        <div field="rpstcd" headerAlign="center" allowSort="true" renderer="renderExptp"> 报账类型</div>
                        <div field="market" headerAlign="center" allowSort="true" > 说明        </div>
                        <div field="isedit" headerAlign="center" allowSort="true" renderer="renderIsedit"> 是否启用</div>
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
            
            var grid = nui.get("datagrid1");
            var bootPath = "<%=request.getContextPath() %>";
           
            //获取参数信息
            var isedit = "${isedit}";
            var rpstcd = "${rpstcd}";           
            //是否启用
            if(isedit !="" && isedit !=null) {
            	var isedit1 = nui.get("isedit");
            	isedit1.setValue(isedit);
            }
             //报账类型
            if(rpstcd !="" && rpstcd !=null) {
            	var rpstcd1 = nui.get("rpstcd");
            	rpstcd1.setValue(rpstcd);
            	rpstcd1.disable();
            }
            var formData = new nui.Form("#typeForm").getData(false,false);
            grid.load(formData);
            
            function getData(){
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
            //重新刷新页面
            function refresh(){
                var form = new  nui.Form("#typeForm");
                var json = form.getData(false,false);
                grid.load(json);//grid查询
                nui.get("update").enable();
            }

            //查询
            function search() {
                var form = new nui.Form("#typeForm");
                var json = form.getData(false,false);
                grid.load(json);//grid查询
            }

            //重置查询条件
            function reset(){
                var form = new nui.Form("#typeForm");//将普通form转为nui的form
                form.reset();
               //是否启用
	            if(isedit !="" && isedit !=null) {
	            	var isedit2 = nui.get("isedit");
	            	isedit2.setValue(isedit);
	            }
	             //报账类型
	            if(rpstcd !="" && rpstcd !=null) {
	            	var rpstcd2 = nui.get("rpstcd");
	            	rpstcd2.setValue(rpstcd);
	            	rpstcd2.disable();
	            }
            }

            //enter键触发查询
            function onKeyEnter(e) {
                search();
            }
                                
           function selectItem(){
                var btnEdit = this;
            	nui.open({
	            	url: bootPath + "/sunfi_cm/item/comItem_select.jsp?detltg="+1,
	            	showMaxButton: false,
	            	title: "选择科目",
	            	width: 870,
	            	height: 480,
	            	ondestroy: function(action){
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.getData();
	                        data = nui.clone(data);
	                    if (data) {
	                        btnEdit.setValue(data.itemcd);
	                        btnEdit.setText(data.itemna);
	                    }
	                }else {
	                	btnEdit.setValue(null);
	                    btnEdit.setText(null);
	                }
	              }
	        	});            
            }

           
                                
        function renderExptp(e){
        	return nui.getDictText("FI_EXPTP",e.row.rpstcd);
        }
        function renderIsedit(e){
        	return nui.getDictText("FI_YESORNO",e.row.isedit);
        }
        </script>
    </body>
</html>
