<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): zyw
  - Date: 2019-01-07 09:51:23
  - Description:
-->
<head>
<title>供应商信息列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
     <div id="form1" align="center" class="nui-form" style="height: 10%"> 
     		<input class="nui-hidden" name="criteria/_expr[2]/usercd" id="usercd"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_op" value="like"/>
            <table id="table1" class="table" style="height:100%">
	           <tr>
		           <td>供应商名称(户名)：</td>
		           <td>
			            <input class="nui-textbox" name="criteria/_expr[1]/suppna" id="suppna"/>
						<input class="nui-hidden"name="criteria/_expr[1]/_op" value="like"/>
		           </td>
	           </tr>
           </table> 
	  </div>
			
			<div property="footer" align="center">
			  <a class="nui-button" onclick="search()"> 查询</a>
			  <a class="nui-button" onclick="reset()"> 重置</a>
			</div> 
     <div class="nui-fit">
         <div id="suppgrid" dataField="afbsupps" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.afbsuppbiz.selectAfbSupp.biz.ext" pageSize="10" showPageInfo="true" 
                 allowSortColumn="false" onrowdblclick="onOk">
		    <div property="columns">
		    	<div type="checkcolumn"></div>
		    	<div field="suppna" headerAlign="left" allowSort="true">供应商名称(户名)</div>
		        <div field="brname" headerAlign="left" allowSort="true">开户银行</div>
		        <div field="bankno" headerAlign="left" allowSort="true">收款账户号</div>
		        <div field="suppid" visible="false"></div>
		    </div>
		</div>
		
	</div>

    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" onclick="addSupp()">新增</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>

	<script type="text/javascript">
    	//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	setData();   	
    	//获取表格信息
    	var grid = nui.get("suppgrid");
        //进入页面加载相关数据 以及页面间传输json数据
        function setData(){                        
            $.ajax({
            url: "com.sunline.sunfi.sunfi_cm.comuserbiz.initUserBrchDuty.biz.ext",
            type: 'POST',
           // data: json,
            cache: false,
            contentType:'text/json',
            success: function (text) {
                var o = nui.decode(text);
                var usercd = nui.get("usercd");
                usercd.setValue(o.initUserInfo.usercd);
                //获取表单信息
    			var formData = new nui.Form("#form1").getData(false,false);
    			grid.load(formData);
              }
            });
        }  
        
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
        
    	
    	//根本条件分页查询
    	function search(){
    	    var form = new nui.Form("#form1");
    		grid.load(form.getData(false,false));
    	}
    	
    	//重置查询条件
        function reset(){
            var form = new nui.Form("#form1");//将普通form转为nui的form
            form.reset();
        }
        
        //重新刷新页面
        function refresh(){
            var form = new nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
            nui.get("update").enable();
        }
    	
    	//新增操作员信息
    	function addSupp(){
    		nui.open({
    			url:"<%= request.getContextPath() %>/sunfi_cm/supp/AfbSuppAdd.jsp",
    			title:"新增供应商",
    			ondestroy:function(res){
					if( res == "saveSuccess" ) {
						grid.reload();
					}
				}
    		});
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
    	function lookupAcct(){
    		var row = grid.getSelected();
    		
    		if( row ){
    			nui.open({
    				url:"<%= request.getContextPath() %>/base/operator_lookup.jsp",
    				title:"修改付款账户",
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