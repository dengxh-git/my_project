<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%--
- Author(s): dengxh
- Date: 2019-04-20 15:12:31
- Description:

--%>
<%
	String obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_book"); //
	String obj_search = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.search");//
	String obj_list = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.list"); //
	String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//
	String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><%=obj %></title>
</head>
<body style="width:100%;overflow:hidden;">
<div class="search-condition">
   <div class="list">
	  <div id="form1">
        <input class="nui-hidden" name="param/opratp"/>
        <input class="nui-hidden" name="param/wkflid"/>
        <input class="nui-hidden" name="param/usercd"/>
        <input class="nui-hidden" name="param/cardsq"/>
        <input class="nui-hidden" name="param/status"/>
        <input class="nui-hidden" name="param/cityno"/>
	    <table style="width:100%;height:100%;">
	      <tr>
	      	<td class="form_label">             
	        	<!-- 业务日期 -->
             	  业务日期 
            </td>
	        <td>
	            <input class="nui-datepicker" name="param/bsnsdt" style="width: 200px;"/>
	        </td>
	        <td class="form_label">                
	            <!-- 业务流水 -->
              	  业务流水
            </td>
	        <td>
                <input class="nui-textbox" name="param/bsnssq" style="width: 200px;"/>
	        </td>
	        <td class="form_label">                
                <!-- 处理状态 -->
                                                处理状态
            </td>
	        <td>
				<input class="nui-dictcombobox" valueField="dictID" textField="dictName"  emptyText="<%=nullselect %>" showNullItem="true" nullItemText="<%=nullselect %>" style="width: 200px;" dictTypeId="FI_TRANST" name="param/transt"/>
	        </td>
	        <td class="form_label">
                <!-- 股权编号 -->
			            股权编号
            </td>
            <td colspan="1">
               <input class="nui-buttonedit searchbox" onbuttonclick="selecteqbkno" allowInput="false" name="param/eqbkno" textName="params/eqbkno" style="width: 200px;"/>
            </td>
		  </tr>
		  <tr>
            <td class="form_label">
                <!-- 股东名称 -->
				股东名称
            </td>
            <td colspan="1">
               	   <input class="nui-textbox"  name="param/shhdna" style="width: 200px;"/>
            </td>
            <td class="form_label">
                <!-- 凭证号码 -->
				凭证号码
            </td>
            <td colspan="1">
				<input class="nui-buttonedit searchbox" onbuttonclick="selectdcmtno" allowInput="false" name="param/dcmtno" textName="params/dcmtno" style="width: 200px;"/>
            </td>            
            <td class="form_label">
                <!-- 股东代码 -->
				股东代码
            </td>
            <td colspan="1">
            	   <input class="nui-buttonedit searchbox" onbuttonclick="selecteshhdcd" allowInput="false" name="param/idcard" textName="param/idcard" style="width: 200px;"/>
            </td>
	      </tr>
	    </table>
	  </div>
	   <!--footer-->
	  <div property="footer" align="center">
      		<a class="nui-button" onclick="search()">
      			查询
      		</a>
      		<a class="nui-button" onclick="reset()">
      			重置
      		</a>
       </div>
    </div>
  </div>
  <div class="nui-panel" title="<%=obj_list %>" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a id="add" class="nui-button" iconCls="icon-add" onclick="add()">
                                增加
                            </a>
                            <a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">
                                编辑
                            </a>
                            <a class="nui-button" iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
			<!-- 数据显示区 -->
			<div class="nui-fit">
     			<div id="datagrid1" dataField="eqbbooks" class="nui-datagrid" style="width:100%;height:100%;" 
                	 url="com.sunline.sunfi.sunfi_eq.eqbbookbiz.queryEqbBooks.biz.ext" pageSize="10" 
                	 showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false" 
                	 sizeList=[5,10,20,50,100]>

                    <div property="columns">
                        <div type="indexcolumn" >
                        	序号
                        </div>
                        <div type="checkcolumn" >
                        	选择
                        </div>
                        <div field="bsnsdt" headerAlign="center" allowSort="true" >
                            	业务日期 
                        </div>
                        <div field="bsnssq" headerAlign="center" allowSort="true" >
                           		业务流水
                        </div>
                        <div field="dcmtno" headerAlign="center" allowSort="true" >
                           		凭证号码
                        </div>
                        <div field="eqbkno" headerAlign="center" allowSort="true" >
                           		股权编号
                        </div>
                        <div field="shhdcd" headerAlign="center" allowSort="true" >
                           		股东代码
                        </div>
                        <div field="shhdna" headerAlign="center" allowSort="true" >
                           		股东名称
                        </div>
                        <div field="idcard" headerAlign="center" allowSort="true" >
                           		证件号码
                        </div>
                        <div field="stckam" headerAlign="center" allowSort="true" dataType="float" decimalPlaces="2" numberFormat="n" align="right" >
                          		 持股数
                        </div>
                        <div field="stckam" headerAlign="center" allowSort="true" dataType="currency" currencyUnit="￥" align="right" >
                          		 持股金额
                        </div>
                        <div field="entcdt" headerAlign="center" allowSort="true" renderer="renderEntcdt" >
                           		入股日期
                        </div>
                        <div field="tranty" headerAlign="center" allowSort="true" renderer="renderTranty" >
                           		入股方式
                        </div>
                        <div field="transt" headerAlign="center" allowSort="true"  renderer="renderTranst" >
                          		 处理状态
                        </div>
                    </div>
                </div>
            </div>
	
  </div>
  <script>
     nui.parse();
     //初始化页面时加载数据
     var grid = nui.get("datagrid1");
     var opratp=nui.getbyName("param/opratp").getValue();
     var wkflid=nui.getbyName("param/wkflid").getValue();
     var usercd=nui.getbyName("param/usercd").getValue();
     var cardsq=nui.getbyName("param/cardsq").getValue();
     var status=nui.getbyName("param/status").getValue();
     var cityno=nui.getbyName("param/cityno").getValue();
     var param={param : {"opratp" : opratp , 
     					 "wkflid" : wkflid , 
     					 "usercd" : usercd ,
     					 "cardsq" : cardsq ,
     					 "status" : status ,
     					 "cityno" : cityno
     					}
     	       };
     grid.load(param);

    function add(){
       nui.open({
          url:"<%=request.getContextPath() %>"+"/sunfi_eq/EqbBookInput.jsp",
          title:"<%=obj %>" + '_新增',
          width:800,
          height:600,
          onload:function(){
          		 },
          ondestroy:function(action){
             			if(action=="saveSuccess"){
	            			grid.reload();
	         			}
          			}
       });
    }
      
    //删除
    function remove(){
        var rows = grid.getSelecteds();
        if(rows.length > 0){
            nui.confirm("确定删除选中记录？","系统提示",
            function(action){
                if(action=="ok"){
                    var json = nui.encode({eqbbooks:rows});
                    grid.loading("正在删除中,请稍等...");
                    $.ajax({
                        url:"com.sunline.sunfi.sunfi_eq.eqbbookbiz.deleteEqbBooks.biz.ext",
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
    
         
    //编辑
    function edit() {
        var row = grid.getSelected();
        if (row){
            nui.open({
                url: "<%=request.getContextPath() %>"+"/sunfi_eq/eqbBookUpdate.jsp",
                title: "<%=obj %>" +"_编辑",
                width: 800,
                height: 600,
                onload: function () {
                    		var iframe = this.getIFrameEl();
                    		var data = row;
                    		//根据当前页面的iframe框架获取框架内的window,将数据传递给子页面设置数据
                    		iframe.contentWindow.SetData(data);
                    	},
                ondestroy: function (action) {
                        		if(action=="saveSuccess"){
                            		grid.reload();
                        		}
                    		}
                    });
         } else {
                    nui.alert("请选中一条记录","提示");
                }
         }
         
	  //查询
	  function search() {
	      var form = new nui.Form("#form1");
	      var json = form.getData(false,false);
	      grid.load(json);//grid查询
	  }
	
	  //重置查询条件
	  function reset(){
	      var form = new nui.Form("#form1");//将普通form转为nui的form
	      form.reset();
	  }
      
      //lookup用到的方法
     // var grid = nui.get("datagrid1");
	  //var keyText = nui.get("keyText");
	  //grid.load();
    
      function renderTranst(e){
         return nui.getDictText("FI_TRANST", e.row.transt);
      }  
         
      function renderTranty(e){
         return nui.getDictText("FI_TRANTY", e.row.tranty);
      } 
      function renderEntcdt(e) {
            var value = e.value;
            var date=nui.parseDate(value);
            if (value) 
               return nui.formatDate(date, 'yyyy-MM-dd');
            return "";
      } 
      function selectionChanged(){
         var rows = grid.getSelecteds();
         if(rows.length>1){
            nui.get("add").disable();
            nui.get("update").disable();
         }else{
            nui.get("update").enable();
            nui.get("add").enable();
         }
      }
      
	  //选择股权编号
   	  function selecteqbkno(e) {
		  var btnEdit = this;
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqbBookSelect.jsp?param/isout=2",
	        	showMaxButton: false,
            	title: "股权编号_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.eqbkno);
		                        btnEdit.setText(data.eqbkno);
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(null);
		                        btnEdit.setText(null);
		                }
		            }
		        });            
   		}
   	//选择凭证号码
   	function selectdcmtno(e) {
		  var btnEdit = this;
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqdDcmtDetlSelect.jsp?param/dcmtst1=1&param/dcmtst2=2",
	        	showMaxButton: false,
            	title: "凭证号码_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.dcmtno);//提交值
		                        btnEdit.setText(data.dcmtno);//显示值
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(null);
		                        btnEdit.setText(null);
		                }
		            }
		        });            
   		}
   	//选择股东代码
   	function selecteshhdcd(e) {
		  var btnEdit = this;
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqpShhdAllSelect.jsp",
	        	showMaxButton: false,
            	title: "股东代码_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.shhdcd);//显示
		                        btnEdit.setText(data.shhdcd);//提交
		                        
		                        nui.getbyName("param/shhdna").setValue(data.shhdna);//显示
		                        
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(null);
		                        btnEdit.setText(null);
		                }
		            }
		        });            
   		}
    </script>
</body>
</html>