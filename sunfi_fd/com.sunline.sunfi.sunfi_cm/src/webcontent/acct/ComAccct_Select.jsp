<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.system.utility.StringUtil"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): zyw
  - Date: 2019-01-08 10:24:49
  - Description:
-->
<head>
<title>付款信息查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="height:98%;width:95%">
     <div id="form1" class="nui-form" style="height: 10%"> 
         <!-- <table id="table1" class="table" style="height:80%;width:110%;"> -->
                      
                                    付款账号：
			<input class="nui-textbox" name="criteria/_expr[1]/acctno" />
			<input class="nui-hidden"name="criteria/_expr[1]/_op" value="like"/>
			
			付款账号名称：
			<input class="nui-textbox" name="criteria/_expr[2]/acctna"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_likeRule" value="all"/>

			会计科目：
			<input class="nui-buttonedit searchbox" id="itemcd" name="criteria/_expr[3]/itemcd" onbuttonclick="selectItem"/>
			<input class="nui-hidden"name="criteria/_expr[3]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[3]/_likeRule" value="all"/>

			所属机构：
			<input class="nui-buttonedit searchbox" id="brchcd" name="criteria/_expr[4]/brchcd" onbuttonclick="selectBrch"/>
			<input class="nui-hidden"name="criteria/_expr[4]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[4]/_likeRule" value="all"/>

			责任中心：
			<input class="nui-buttonedit searchbox" id="dutycd" name="criteria/_expr[5]/dutycd" onbuttonclick="selectDuty"/>
			<input class="nui-hidden"name="criteria/_expr[5]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[5]/_likeRule" value="all"/>

		<!-- </table> -->
	  </div>
			
			<div property="footer" align="center">
			  <a class="nui-button" onclick="search()"> 查询</a>
			  <a class="nui-button" onclick="reset()"> 重置</a>
			</div>   
     <div class="nui-fit">
         <div id="acctgrid" dataField="comaccts" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comacctbiz.selectComAcct.biz.ext" pageSize="10" showPageInfo="true" 
                onselectionchanged="selectionChanged"  onrowdblclick="onOk">
		    <div property="columns">
		    	<div type="checkcolumn"></div>
		    	<div field="acctno" headerAlign="left" allowSort="true">付款账号</div>
		        <div field="acctna" headerAlign="left" allowSort="true">付款账号名称</div>
		        <div field="itemna" headerAlign="left" allowSort="true">会计科目</div>
		        <div field="brchna" headerAlign="left" allowSort="true">所属机构</div>
		        <div field="dutyna" headerAlign="left" allowSort="true">所属责任中心</div>
		        <!-- <div field="brname" headerAlign="left" allowSort="true">开户银行</div> -->
		        <!-- <div field="phone" headerAlign="left" allowSort="true">联系电话</div> -->
		    </div>
		</div>
	</div>
    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
    </div>


	<script type="text/javascript">
    	//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	    	
    	//获取表格信息
    	var grid = nui.get("acctgrid");
    	var brchcd = "<%= StringUtil.htmlFilter(request.getParameter("brchcd")) %>";
        //获取机构号
        if(brchcd !=null && brchcd!="") {
        var brchcd1 = nui.get("brchcd");
        brchcd1.setValue(brchcd);
        }  
    	
    	//获取表单信息
    	var formData = new nui.Form("#form1").getData(false,false);
    	grid.load(formData);
    	
    	//程序初始化执行一次查询操作，来初始化表单信息
    	search();
    	
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
    	
    	
    	//当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("update").disable();
            }else{
                nui.get("update").enable();
            }
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
    	
    	var bootPath = "<%=request.getContextPath() %>";
    	
    	function selectItem() {
			        var btnEdit = this;
			        nui.get("itemcd").setValue(null);
			        nui.get("itemcd").setText(null);
			        nui.open({
			            url: bootPath + "/sunfi_cm/item/comItem_select.jsp?detltg=1",
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
			       
		function selectBrch() {
			        var btnEdit = this;
			        nui.get("brchcd").setValue(null);
			        nui.get("brchcd").setText(null);
			        nui.open({
			            url: bootPath + "/sunfi_cm/brch/combrch_select.jsp?brchtp=0000",
			            showMaxButton: false,
			            title: "选择机构",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.brchcd);
			                        btnEdit.setText(data.brchna);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                }
			            }
			        });            
			       }
			       
		function selectDuty() {
			        var btnEdit = this;
			        var brchcd = nui.get("dutycd").getValue();
			        
			        /* if(!brchcd){
			        	nui.alert("请先选择机构","提示");
			        	return;
			        } */
			        nui.open({
			            url: bootPath + "/sunfi_cm/brch/combrch_select.jsp?brchtp=0001&acctbr="+brchcd,
			            showMaxButton: false,
			            title: "选择机构",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.brchcd);
			                        btnEdit.setText(data.brchna);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                }
			            }
			        });            
			       }
    </script>
</body>
</html>