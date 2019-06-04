<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-08 17:48:19
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }
    </style>
    
</head>
<body style="width:98%;height:95%;">
    <div class="nui-panel" title="股权证查询" style="width:100%;height:80;" showToolbar="false" showFooter="true">
        <div id="form1" class="nui-form" align="center" style="height:100%">
            <!-- 数据实体的名称 -->
            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqd.EqdDcmtDetls">
            <!-- 排序字段 -->
            <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="dcmtno">
            <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
            <input class="nui-hidden" name="criteria/_expr[1]/dcmtst"/>
            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
            <table id="table1" class="table" style="height:100%">
                <tr>
                    <td class="form_label">凭证号码:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[2]/dcmtno"/>
                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like"/>
                    </td>
                    <td class="form_label">股东名称:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[3]/shhdna"/>
                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="="/>
                    </td>
                    <td class="form_label">证件号码:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[4]/idcard"/>
                        <input class="nui-hidden" name="criteria/_expr[4]/_op" value="="/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!--footer-->
    <div property="footer" align="center">
        <a class="nui-button" onclick="search()">查询</a>
        <a class="nui-button" onclick="reset()">重置</a>
    </div>
    <div class="nui-fit">
        <div id="datagrid1" dataField="eqddcmtdetls" class="nui-datagrid" style="width:100%;height:100%;"  onrowdblclick="onRowDblClick"
        pageSize="10" showPageInfo="true" multiSelect="true" allowSortColumn="false"
        url="com.sunline.fdeqb.eqddcmtbrchbiz.queryEqdDcmtDetls.biz.ext" >
            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div field="shhdtp" visible="false" ></div>
				<div field="idcdtp" visible="false" ></div>
				<div field="idcard" visible="false" ></div>
				<div field="stcknm" visible="false" ></div>
				<div field="stckam" visible="false" ></div>
				<div field="lossdt" visible="false" ></div>
                <div field="dcmtno" headerAlign="center" allowSort="true" >股权证编号</div>
                <div field="dcmtst" headerAlign="center" allowSort="true" renderer="onDcmtstRenderer">凭证状态</div>
                <div field="opendt" headerAlign="center" allowSort="true" >发证日期</div>
                <div field="opensq" headerAlign="center" allowSort="true" >发证流水</div>
                <div field="shhdcd" headerAlign="center" allowSort="true" >股东编号</div>
                <div field="shhdna" headerAlign="center" allowSort="true" >股东名称</div>
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
    	
    	var grid = nui.get("datagrid1");
    	var form = new nui.Form("#form1");
		var param = nui.getParams();
		nui.getbyName("criteria/_expr[1]/dcmtst").setValue(param.dcmtst);
		
        var formData = form.getData(false,false);
        grid.load(formData);
    	
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
	    
	    function onDcmtstRenderer(e){
			return nui.getDictText("FI_DCMTST",e.row.dcmtst);
		}
        
    </script>
</body>
</html>