<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasanshi93
  - Date: 2018-12-05 09:51:23
  - Description:
-->
<head>
<title>银行列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="height:98%;width:95%">
     <div id="form1" class="nui-form" style="height:10%"> 
                      
                                    银行名称：
			<input class="nui-textbox" name="criteria/_expr[1]/bkname" />
			<input class="nui-hidden"name="criteria/_expr[1]/_op" value="like"/>
			
			银行编码：
			<input class="nui-textbox" name="criteria/_expr[2]/bankno"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[2]/_likeRule" value="all"/>

			分行名称：
			<input class="nui-textbox" name="criteria/_expr[3]/brname"/>
			<input class="nui-hidden"name="criteria/_expr[3]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[3]/_likeRule" value="all"/>

			分行编码：
			<input class="nui-textbox" name="criteria/_expr[4]/bracno"/>
			<input class="nui-hidden"name="criteria/_expr[4]/_op" value="like"/>
			<input class="nui-hidden"name="criteria/_expr[4]/_likeRule" value="all"/>

	  </div>
			
			<div property="footer" align="center">
			  <a class="nui-button" onclick="search()"> 查询</a>
			  <a class="nui-button" onclick="importFile()"> 导入</a>
			  <!-- <a class="nui-button" onclick="reset()"> 重置</a> -->
			</div>
     
     <div class="nui-fit">
         <div id="bankgrid" dataField="bank" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.bankbiz.bankList.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" allowSortColumn="false">
		    <div property="columns">
		    	<div field="cohome" headerAlign="left" allowSort="true" style="width:5%">国家</div>
		        <div field="bkname" headerAlign="left" allowSort="true" style="width:20%">银行名称</div>
		        <div field="bankno" headerAlign="left" allowSort="true" style="width:10%">银行编码</div>
		        <div field="baaddr" headerAlign="left" allowSort="true" style="width:15%">总行地址</div>
		        <div field="brname" headerAlign="left" allowSort="true" style="width:20%">分行名称</div>
		        <div field="bracno" headerAlign="left" allowSort="true" style="width:10%">分行编码</div>
		        <div field="brardd" headerAlign="left" allowSort="true" style="width:15%">分行地址</div>
		    </div>
		</div>
	</div>



	<script type="text/javascript">
    	//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	    	
    	//获取表格信息
    	var grid = nui.get("bankgrid");
    	
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
    	
    	<%-- //导入
    	function importFile(){
    	   document.location = "com.sunline.sunfi.sunfi_cm.BKBudgLoad.flow";
		   nui.open({
    			url:"<%= request.getContextPath() %>/sunfi_cm/bank/BKBudgLoad.jsp",
    			title:"银行管理导入",
    			ondestroy:function(res){
					if( res == "saveSuccess" ) {
						grid.reload();
					}
				}
    		});
     } --%>
    	
        /* //重置查询条件
        function reset(){
            var form = new nui.Form("#form1");//将普通form转为nui的form
            form.reset();
        } */
        
        /* //重新刷新页面
        function refresh(){
            var form = new nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
            nui.get("update").enable();
        } */
   	
    </script>
</body>
</html>