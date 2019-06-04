<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-05-14 18:23:57
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
	<div class="nui-panel" title="黑名单查询" iconCls="icon-add" style="width:100%;height:10%;" >
        <div id="form1" class="nui-form" align="center" style="height:100%">
            <!-- 数据实体的名称 -->
            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqp.EqpBlackShhd">
            <!-- 排序字段 -->
            <table id="table1" class="table" style="height:100%">
                <tr>
                    <td class="form_label">股东编号:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[1]/shhdcd"/>
                        <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                    </td>
                    <td >
                    	<a class="nui-button" onclick="search()">查询</a>
            			<a class="nui-button" onclick="reset()">重置</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="nui-panel" title="黑名单列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
	    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;">
	            <tr>
	            <td style="width:100%;">
	                <a class="nui-button" iconCls="icon-add" onclick="add()">导入</a>
	                <a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
	            </td>
	            <tr>
	        </table>
	    </div>
	    <div class="nui-fit">
			<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" pageSize="10" showPageInfo="true" multiSelect="true"
			url="com.sunline.fdeqb.eqpshhbiz.queryEqpBlakShhd.biz.ext" dataField="eqpblackshhds" allowResize="true">
			    <div property="columns">
			        <div type="indexcolumn" >序号</div>
			        <div type="checkcolumn" >#</div>
			        <div field="bathid" width="100" headerAlign="center">批次号</div>
			        <div field="shhdcd" width="120" headerAlign="center">股东代码</div>
			        <div field="shhdna" width="120" headerAlign="center">股东名称</div>
			        <div field="stcknm" width="120" headerAlign="center">持股数</div>
			        <div field="remark" width="100" headerAlign="center">备注</div>
			        <div field="bsnsdt" width="100" headerAlign="center">业务日期</div>
			        <div field="bsnssq" width="100" headerAlign="center">业务流水</div>
			    </div>
			</div>
		</div>
	</div>
		

	<script type="text/javascript">
    	nui.parse();
    	var bootPath = "<%=request.getContextPath() %>";
    	var grid = nui.get("datagrid1");
        grid.load();
        
        function add() {
            nui.open({
                targetWindow: window,
                url: bootPath + "/fdeqb/eqpshhblack_upload.jsp",
                title: "上传黑名单", width: 450, height: 200,
                onload: function () {
                    
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        }

        function edit() {
        }
        
        function remove() {
            var rows = grid.getSelecteds();
            if(rows.length > 0){
                nui.confirm("确定删除选中记录？","系统提示",
                function(action){
                    if(action=="ok"){
                        var json = nui.encode({eqpblakshhds:rows});
                        grid.loading("正在删除中,请稍等...");
                        $.ajax({
                            url:"com.sunline.fdeqb.eqpshhbiz.deleteEqpBlackShhd.biz.ext",
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
            }else{
                nui.alert("请选中一条记录！");
            }
        }
        
        //查询
        function search() {
            var form = new nui.Form("#form1");
            var json = form.getData(true,false);
            alert(nui.encode(json));
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