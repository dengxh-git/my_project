<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi147
  - Date: 2018-11-28 15:41:50
  - Description:
-->
<head>
<title>用户管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
 <div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="用户管理" visible="true" >          
		 <div id="form1" class="nui-form"  align="center"  style="height: 10%">           
			<table id="table1" class="table" style="height:100%">
			<tr>
			<td style="font-size: 12px;">
			<input class="nui-hidden" name="criteria/_entity" value="com.sunline.sunfi.sunfi_cm.item.ViComUser" />
																	
			用户代码：
			<input class="nui-textbox" name="criteria/_expr[1]/usercd" />
			<input class="nui-hidden"name="criteria/_expr[1]/_op" value="like"/>
			
			用户名称：
			<input class="nui-textbox" name="criteria/_expr[2]/userna"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_likeRule" value="all"/>
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
            <form id="excelform" action=""  method="post" style="display: inline;"></form>
        </div>
	
         <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="addOperator()">新增</a>
							<a class="nui-button" id="update" onclick="updateOperator()">修改</a>
							<a class="nui-button" onclick="deleteOperator()">删除</a>                      
                        </td>
                    </tr>
                </table>
            </div>
 <div class="nui-fit">
            <div id="usergrid" dataField="comusers" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comuserbiz.queryComUser.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
            <div property="columns">
		    	<div type="checkcolumn"></div>
		    	<div field="usercd" headerAlign="left" allowSort="true">用户代码</div>
		        <div field="userna" headerAlign="left" allowSort="true">用户名称</div>
		        <div field="brchna" headerAlign="left" allowSort="true">所属机构</div>
		        <div field="dutyna" headerAlign="left" allowSort="true">所属责任中心</div>
		        <div field="phone"  headerAlign="left" allowSort="true" visible="false">联系电话</div>
		        <div name="action"  headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
		    </div>
		</div>
		</div>
</div>
</div>
	<script type="text/javascript">
		//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	
    	//获取表单信息
    	var form = new nui.Form("#form1");
    	
    	//获取表格信息
    	var grid = nui.get("usergrid");
    	
    	//程序初始化执行一次查询操作，来初始化表单信息
    	search();
    	
    	//根本条件分页查询
    	function search(){
    		grid.load(form.getData(false,false));
    	}
    	//重置查询条件
        function reset(){
            var form = new nui.Form("#form1");//将普通form转为nui的form
            form.reset();
        }
        
        //编辑用户数据权限
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var rowIndex = e.rowIndex;
            var s =  '<a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')">用户数据权限编辑</a>';         
            return s;
        }
       function editRow(row_uid) {
            var row = grid.getRowByUID(row_uid);
            if (row) {
                nui.open({
    				url: "<%= request.getContextPath() %>/sunfi_cm/user/comUspm_edit.jsp" ,
    				showMaxButton: false,
    			    width: 670,
			        height: 180,
			        allowResize: false,
    				title:"用户数据权限设置",
    				onload:function(){
    					var iframe = this.getIFrameEl();
	    				iframe.contentWindow.loadData(row);
    				},
    				ondestroy:function(res){
    					if( res == "saveSuccess" ) {
    						grid.reload();
    					}
    				}
    			});
            }
        } 
    	
    	//新增操作员信息
    	function addOperator(){
    		nui.open({
    			url:"<%= request.getContextPath() %>/sunfi_cm/user/ComUserAdd.jsp",
    			title:"新增操作员",
    			showMaxButton: false,
    			width: 550,
			    height: 195,
			    allowResize: false,
    			ondestroy:function(res){
					if( res == "ok" ) {
						grid.reload();
					}
				}
    		});
    	}
    	
    	//修改操作员信息
    	function updateOperator(){
    		var row = grid.getSelected();
    		if(row){
    			nui.open({
    				url:"<%= request.getContextPath() %>/sunfi_cm/user/ComUserUpt.jsp",
    				showMaxButton: false,
    				width: 550,
			    	height: 195,
			    	allowResize: false,
    				title:"修改操作员",
    				onload:function(){
    					var iframe = this.getIFrameEl();
	    				iframe.contentWindow.loadData(row);
    				},
    				ondestroy:function(res){
    					if( res == "saveSuccess" ) {
    						grid.reload();
    					}
    				}
    			});
    		} else {
    			nui.alert("请选择一条记录");
    		}
    	}
    	
    	//删除操作员
    	function deleteOperator(){
    		var rows = grid.getSelecteds();
    		var json = nui.encode({comusers:rows});
    		if( rows.length > 0 ) {
	    		 nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({comusers:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.comuserbiz.deleteComUsers.biz.ext",
                                        type:'POST',
                                        data:json,
                                        cache: false,
                                        contentType:'text/json',
                                        success:function(text){
                                            var returnJson = nui.decode(text);
                                            if(returnJson.exception == null){
                                                grid.reload();
                                                nui.alert("删除成功", "系统提示", function(action){
                                                    });
                                                }else{
                                                    grid.unmask();
                                                    nui.alert("删除失败", "系统提示");
                                                }
                                            }
                                            });
                                        }
                                        });
    		} else {
    			nui.alert("请选择记录");
    		}
    	}
    	
    	//当选择列时
                                function selectionChanged(){
                                    var rows = grid.getSelecteds();
                                    if(rows.length>1){
                                        nui.get("update").disable();
                                    }else{
                                        nui.get("update").enable();
                                    }
                                }
    	
    	
    	//lookup下拉框
    	function lookupOperator(){
    		var row = grid.getSelected();
    		
    		if( row ){
    			nui.open({
    				url:"<%= request.getContextPath() %>/base/operator_lookup.jsp",
    				title:"修改操作员",
    				onload:function(){
    					var iframe = this.getIFrameEl();
	    				iframe.contentWindow.loadData(row);
    				},
    				ondestroy:function(res){
    					if( res == "ok" ) {
    						grid.reload();
    					}
    				}
    			});
    		} else {
    			nui.alert("请选择一条记录");
    		}
    	}
    </script>
</body>
</html>