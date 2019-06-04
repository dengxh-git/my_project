<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): kaifasanshi93
  - Date: 2018-12-05 09:51:23
  - Description:
-->
<head>
<title>供应商信息列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
	<div title="供应商管理" visible="true" >          
     <div id="form1" align="center" align="center" class="nui-form" style="height: 10%"> 
     <input id="brname" class="nui-hidden" name="criteria/_expr[3]/brname"/>
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
			  <a class="nui-button" onclick="excel()"> 导出excel</a>
			  <form id="excelform" action="" method="post" style="display: inline;"></form>
			</div>    
     
     <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="addSupp()">新增</a>
							<a class="nui-button" id="update" onclick="updateSupp()">修改</a>
							<a class="nui-button" onclick="deleteSupp()">删除</a>                      
                        </td>
                    </tr>
                </table>
     </div>
     
     <div class="nui-fit">
         <div id="suppgrid" dataField="afbsupps" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.afbsuppbiz.selectAfbSupp.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
		    <div property="columns">
		    	<div type="checkcolumn"></div>
		    	<div field="suppna" headerAlign="left" allowSort="true">供应商名称(户名)</div>
		        <div field="brname" headerAlign="left" allowSort="true">开户银行</div>
		        <div field="bankno" headerAlign="left" allowSort="true">收款账户号</div>
		    </div>
		</div>
	</div>
</div>
</div>


	<script type="text/javascript">
    	//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	    	
    	//获取表格信息
    	var grid = nui.get("suppgrid");
    	
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
    	
    	//新增供应商信息
    	function addSupp(){
    		nui.open({
    			url:"<%= request.getContextPath() %>/sunfi_cm/supp/AfbSuppAdd.jsp",
    			width: 680, height: 240,
    			allowResize: false,
    			title:"新增供应商",
    			ondestroy:function(res){
					if( res == "saveSuccess" ) {
						grid.reload();
					}
				}
    		});
    	}
    	
    	//修改供应商信息
    	function updateSupp(){
    		var row = grid.getSelected();  		
    		if(row){
    			nui.open({
    				url:"<%= request.getContextPath() %>/sunfi_cm/supp/AfbSuppUpt.jsp",
    				title:"修改供应商",
    				width: 680, height: 240,
    				allowResize:false,
    				onload:function(){
    					var iframe = this.getIFrameEl();
                        var data = row;
                        //直接从页面获取，不用去后台获取
                        iframe.contentWindow.setData(data);
                        },
                        ondestroy: function (action) {
                             grid.reload();
                        }
    			});
    		} else {
    			nui.alert("请选择一条记录");
    		}
    	}
    	
    	//删除供应商
    	function deleteSupp(){
    		var rows = grid.getSelecteds();
    		var json = nui.encode({afbsupps:rows});
    		if( rows.length > 0 ) {
	    		 nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({afbsupps:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.afbsuppbiz.delAfbSupp.biz.ext",
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
    	
    	//导出Excel
	                            function excel(){
	                                 var form = document.getElementById("excelform");
	                                 //var suppid = nui.get("suppid").getFormValue();
	                                 var suppna = nui.get("suppna").getValue();
	                                 //var bankno = nui.get("bankno").getValue();
	                                 var brname = nui.get("brname").getValue();
								     form.action = "com.sunline.sunfi.sunfi_cm.exportAfbSupp.flow?suppna="+suppna+"&&brname="+brname;
								     form.submit();
	                            }
    </script>
</body>
</html>