<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-05-14 18:19:02
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
	<div class="mini-splitter" style="width:100%;height:100%;">
	    <div size="240">
	        <div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
	             
	        </div>
	        <div class="mini-fit">
	            <ul id="tree1" class="mini-tree" url="com.sunline.fdeqb.eqpshhbiz.queryEqpGrupObj.biz.ext" style="width:100%;"
	                showTreeIcon="true" textField="grupna" idField="grupcd" parentField="sprrcd" resultAsTree="false" dataField="eqpgrupobjs">        
	            </ul>
	        </div>
	    </div>
	    <div>
	        <div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
	                           
	        </div>
	        <div class="mini-fit" >
	            <div class="nui-panel" title="股东组" iconCls="icon-add" style="width:100%;height:10%;" >
			        <div id="form1" class="nui-form" align="center" style="height:100%">
			            <!-- 数据实体的名称 -->
			            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqd.EqdDcmtBrch">
			            <!-- 排序字段 -->
			            <table id="table1" class="table" style="height:100%">
			                <tr>
			                    <td class="form_label">股东组代码:</td>
			                    <td colspan="1" align="left">
			                        <input class="nui-textbox" name="criteria/_expr[1]/grupcd"/>
			                        <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
			                    </td>
			                    <td class="form_label">股东组名称:</td>
			                    <td colspan="1" align="left">
			                        <input class="nui-textbox" name="criteria/_expr[2]/grupna"/>
			                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
			                    </td>
			                    <td class="form_label">是否末级:</td>
			                    <td colspan="1" align="left">
			                    	<input class="nui-dictcombobox nui-form-input" name="criteria/_expr[3]/detltg" valueField="dictID" textField="dictName" dictTypeId="AFP_SFMJ"/>
			                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
			                    </td>
			                </tr>
			            </table>
			        </div>
			    </div>
			    <div property="footer" align="center">
		        	<a class="nui-button" onclick="search()">查询</a>
		            <a class="nui-button" onclick="reset()">重置</a>
		        </div>
			    <div class="nui-panel" title="股权证登记列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
				    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
				        <table style="width:100%;">
				            <tr>
				            <td style="width:100%;">
				                <a class="nui-button" iconCls="icon-add" onclick="add()">增加</a>
				                <a class="nui-button" iconCls="icon-edit" onclick="edit()">编辑</a>
				                <a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
				            </td>
				            <tr>
				        </table>
				    </div>
				    <div class="nui-fit">
						<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" pageSize="10" showPageInfo="true"
						    url="com.sunline.fdeqb.eqpshhbiz.queryEqpGrup.biz.ext" dataField="eqpgrups" idField="grupcd" allowResize="true">
						    <div property="columns">
						        <div type="indexcolumn" headerAlign="center">序号</div>
						        <div type="checkcolumn" >#</div>
						        <div field="grupcd" width="120" headerAlign="center">股东组代码</div>
						        <div field="sprrcd" width="120" headerAlign="center">上级股东z组</div>
						        <div field="grupna" width="100" headerAlign="center">股东组名称</div>
						        <div field="detltg" width="100" headerAlign="center">是否末级</div>
						    </div>
						</div>
					</div>
				</div>
	        </div>
	    </div>        
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var bootPath = "<%=request.getContextPath() %>";
    	
    	var tree = mini.get("tree1");
        var grid = mini.get("datagrid1");
		grid.load();
        tree.on("nodeselect", function (e) {
            var data = {"criteria/_expr[1]/_op":"=","criteria/_expr[1]/sprrcd":e.node.grupcd};
            grid.load(data);
        });
        
        function add() {
            nui.open({
                targetWindow: window,
                url: bootPath + "/fdeqb/eqpgrup_add.jsp",
                title: "新增股东组", width: 600, height: 450,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = { action: "new" };
                    iframe.contentWindow.load(data);
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        }

        function edit() {
            var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: bootPath + "/fdeqb/eqpgrup_update.jsp",
                    title: "编辑股东组", width: 600, height: 450,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "edit", grupcd: row.grupcd};
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                        grid.reload();
                    }
                });
                
            } else {
                alert("请选中一条记录");
            }
            
        }
        function remove() {
            var row = grid.getSelected();
            if(row){
                nui.confirm("确定删除选中记录？","系统提示",
                function(action){
                    if(action=="ok"){
                        var json = {eqpgrups:row};
                        json = nui.decode(json);
                        grid.loading("正在删除中,请稍等...");
                        nui.ajax({
							url: "com.sunline.fdeqb.eqpshhbiz.deleteEqpGrupObj.biz.ext",
							type: "post",
							contentType: "text/json",
							data:json ,
							success: function (text) {
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
            }else{
                nui.alert("请选中一条记录！");
            }
        }
        
        //查询
        function search() {
            var form = new nui.Form("#form1");
            var json = form.getData(true,false);
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