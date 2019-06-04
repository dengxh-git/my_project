<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-14 13:00:15
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width:98%;height:95%;">
    <div class="nui-panel" title="股东组查询" style="width:100%;height:80px;" showToolbar="false" showFooter="true">
        <div id="form1" class="nui-form" align="center" style="height:100%">
            <!-- 数据实体的名称 -->
            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqp.EqpGrup">
            <!-- 排序字段 -->
            <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="sprrcd,grupcd"/>
            <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc"/>
            <table id="table1" class="table" style="height:100%">
                <tr>
                    <td class="form_label">股东组代码:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[1]/grupcd"/>
                        <input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
                    </td>
                    <td>
                    	<a class="nui-button" onclick="search()"> 查询</a>
				        <a class="nui-button" onclick="reset()">重置</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div class="nui-fit">
        <div id="datagrid1" dataField="eqpgrups" class="nui-datagrid" style="width:100%;height:100%;"  onrowdblclick="onRowDblClick"
        pageSize="10" showPageInfo="true" multiSelect="true" allowSortColumn="false"
        url="com.sunline.fdeqb.eqpshhbiz.queryEqpGrup.biz.ext" >
            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div field="grupcd" headerAlign="center" allowSort="true" >股东组代码</div>
                <div field="grupna" headerAlign="center" allowSort="true" >股东组名称</div>
                <div field="sprrcd" headerAlign="center" allowSort="true" >上级股东组</div>
                <div field="detltg" headerAlign="center" allowSort="true" renderer="onGenderRenderer">是否末级</div>
            </div>
        </div>
    </div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
	
	<script type="text/javascript">
    	nui.parse();
    	var grid = mini.get("datagrid1");
    	var form = new nui.Form("#form1");
		grid.load();
		
    	 //查询
        function search() {
            var json = form.getData(false,false);
            grid.load(json);//grid查询
        }

        //重置查询条件
        function reset(){
            form.reset();
        }
        
        function onGenderRenderer(){
        	
        }
        
        function GetData() {
	        var row = grid.getSelected();
	        return row;
	    }

	    function onKeyEnter(e) {
	        search();
	    }
	    function onRowDblClick(e) {
	        onOk();
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