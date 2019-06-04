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
<title>付款信息列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="账务管理" visible="true" > 
     <div id="form1" class="nui-form" align="center" style="height: 10%"> 
         <table id="table1" class="table">
            <tr>
	            <td>付款账号：</td>
				<td><input class="nui-textbox" name="criteria/_expr[1]/acctno" />
				<input class="nui-hidden" name="criteria/_expr[1]/_op" value="like"/>
				</td>
				<td>付款账号名称：
				<td><input class="nui-textbox" name="criteria/_expr[2]/acctna"/>
				<input class="nui-hidden"name="criteria/_expr[2]/_op" value="like"/>
				<input class="nui-hidden"name="criteria/_expr[2]/_likeRule" value="all"/>
				</td>
				<td>会计科目：
				<td><input class="nui-buttonedit searchbox" id="itemcd" name="criteria/_expr[3]/itemcd" onbuttonclick="selectItem"/>
				<input class="nui-hidden"name="criteria/_expr[3]/_op" value="like"/>
				<input class="nui-hidden"name="criteria/_expr[3]/_likeRule" value="all"/>
	 			</td>
				<td>所属机构：
				<td><input class="nui-buttonedit searchbox" id="brchcd" name="criteria/_expr[4]/brchcd" onbuttonclick="selectBrch"/>
				<input class="nui-hidden"name="criteria/_expr[4]/_op" value="like"/>
				<input class="nui-hidden"name="criteria/_expr[4]/_likeRule" value="all"/>
				</td>
				<td>责任中心：
				<td><input class="nui-buttonedit searchbox" id="dutycd" name="criteria/_expr[5]/dutycd" onbuttonclick="selectDuty"/>
				<input class="nui-hidden"name="criteria/_expr[5]/_op" value="like"/>
				<input class="nui-hidden"name="criteria/_expr[5]/_likeRule" value="all"/>
				</td>
		</table>
	  </div>
			
			<div property="footer" align="center">
			  <a class="nui-button" onclick="search()"> 查询</a>
			  <a class="nui-button" onclick="reset()"> 重置</a>
			</div>    
     
     <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="addAcct()">新增</a>
							<a class="nui-button" id="update" onclick="updateAcct()">修改</a>
							<a class="nui-button" onclick="deleteAcct()" >删除</a>                      
                        </td>
                    </tr>
                </table>
     </div>
     
     <div class="nui-fit">
         <div id="acctgrid" dataField="comaccts" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comacctbiz.selectComAcct.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
		    <div property="columns">
		        <div type="indexcolumn"></div>
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
</div>
</div>


	<script type="text/javascript">
    	//初始化nui插件，否则后面nui插件用不了
    	nui.parse();
    	    	
    	//获取表格信息
    	var grid = nui.get("acctgrid");
    	
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
    	
    	//新增操作员信息
    	function addAcct(){
    		nui.open({
    			url:"<%= request.getContextPath() %>/sunfi_cm/acct/ComAcctAdd.jsp",
    			title:"新增付款账户",
    			ondestroy:function(res){
					if( res == "saveSuccess" ) {
						grid.reload();
					}
				}
    		});
    	}
    	
    	//修改操作员信息
    	function updateAcct(){
    		var row = grid.getSelected();  		
    		if(row){
    			nui.open({
    				url:"<%= request.getContextPath() %>/sunfi_cm/acct/ComAcctUpt.jsp",
    				title:"修改付款账户",
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
    	
    	//删除付款账户
    	function deleteAcct(){
    		var rows = grid.getSelecteds();
    		var json = nui.encode({comacct:rows});
    		if( rows.length > 0 ) {
	    		 nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({comacct:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.comacctbiz.delComAcct.biz.ext",
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