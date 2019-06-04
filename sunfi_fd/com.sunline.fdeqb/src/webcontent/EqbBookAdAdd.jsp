<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/coframe/tools/skins/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): dengxh
  - Date: 2019-04-24 19:01:00
  - Description:
-->
<head>
<%
//获取标签中使用的国际化资源信息
String obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.book_price.update"); //股本调整
String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//录入
String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
%>
</head>
  <body style="width:100%;overflow:hidden;">
  	 <form id="form1" method="post">
		   <input class="nui-hidden" name="detail.eqbkno"/>
		   <input class="nui-hidden" name="detail.cardsq"/>
		   <input class="nui-hidden" name="param.cityno"/>
		   <input class="nui-hidden" name="master.wfdena" value="com.sunline.sunfi.sunfi_wf.eqApp"/><!-- 业务流程名称  -->
		   <input class="nui-hidden" name="master.wfinna" value="<%=obj %>"/><!-- 流程实例名称 -->
		   <input class="nui-hidden" name="master.wfinde" value="<%=obj %>"/><!-- 流程实例描述  -->
		   <input class="nui-hidden" name="master.lnkurl" value="/sunfi_eq/EqbBookAdQuery.jsp?wkflid="/>
		   <input class="nui-hidden" name="detail.lnkurl" value="/sunfi_eq/EqbBookAdQuery.jsp?wkflid="/>
		   <input class="nui-hidden" name="master.entityna" value="com.sunline.sunfi.sunfi_eq.eqb.EqbBook"/>
		   <input class="nui-hidden" name="master.linkna" value="<%=obj_input %>"/>
		   <input class="nui-hidden" name="detail.ismain" value="0"/>
		   <input class="nui-hidden" name="detail.addPrcscd" value="eqb_chg_add"/>
		   <input class="nui-hidden" name="detail.enterPrcscd" value="eqb_chg_etr"/>
		   <input class="nui-hidden" name="detail.calPrcscd" value="eqb_com_cal"/>
		   
		   <div style="padding-left:11px;padding-bottom:5px;">
		     <div style="padding:5px;">
		     	<table style="table-layout:fixed;">
				     <tr>
				 		<td style="width:100px;">股权编号：</td>
				        <td style="width:150px;">
				          <input class="nui-buttonedit searchbox" name="detail.eqbkno" onbuttonclick="selecteqbkno" allowInput="false" />
				        </td>
				        <td style="width:100px;">凭证号码：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.dcmtno" required="true"/>
				        </td>
				        <td style="width:100px;">经济性质：</td>
				        <td style="width:150px;">
				          <input class="nui-dictcombobox " name="detail.ecmytp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
				      </tr>
				      <tr>
				        <td style="width:100px;">股东代码：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.shhdcd" required="true"/>
				        </td>
				        <td style="width:100px;">股东名称：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.shhdna" required="true"/>
				        </td>
				        <td style="width:100px;">持股数：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.stcknm" required="true"/>
				        </td>
				      </tr>
				      <tr>
				        <td style="width:100px;">持股金额：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.stckam" required="true"/>
				        </td>
				        <td style="width:100px;">入股日期：</td>
				        <td style="width:150px;">
				          <input class="nui-datepicker " name="detail.entcdt"  allowInput="false" required="true"/> <!-- onvalidation="onCompare" -->
				        </td>
				        <td style="width:100px;">股权状态：</td>
				        <td style="width:150px;">
				          <input class="nui-dictcombobox " name="detail.status" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_EQSTUS" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
				      </tr>
				      <tr>
				        <td style="width:100px;">股权类型：</td>
				        <td style="width:150px;">
				          <input class="nui-dictcombobox " name="detail.eqbktp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
				        <td style="width:100px;">调整方式：</td>
				        <td style="width:150px;">
				          <input class="nui-dictcombobox " name="detail.defi01" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_TRIMWY" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
				        <td style="width:100px;">调整股数：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.defi03" allowInput="true" required="true"/>
				          <input class="nui-hidden" name="detail.thisam"/>
				        </td>
				      </tr>
				      <tr>
				        <td style="width:100px;">每股价格：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.stckpr" allowInput="true"/>
				        </td>
				        <td style="width:100px;">溢价价格：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.prumpr" allowInput="true"/>
				        </td>
				        <td style="width:100px;">股权备注：</td>
				        <td style="width:150px;">
				          <input class="nui-textbox " name="detail.remark" allowInput="true"/>
				        </td>
				      </tr>
				    </table>
		     </div>
		   	 </div>
		    <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
			    <table width="100%">
			      <tr>
			        <td style="text-align:center;">
			          <a class="nui-button" iconCls="icon-save" onclick="onOk">保存</a>
			          <span style="display:inline-block;width:25px;"></span>
			          <a class="nui-button" iconCls="icon-cancel" onclick="onCancel">取消</a>
			        </td>
			      </tr>
			    </table>
			 </div>
  </form>

  <script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");
    form.setChanged(false);
    
    function onOk(){
      saveData();
    }
    
    function saveData(){
      form.validate();
      if(form.isValid()==false) 
      	return;
      
      //调整股数
      var defi03=nui.getbyName("detail.defi03").getValue();
      //每股价格
      var stckpr=nui.getbyName("detail.stckpr").getValue();
      //溢价价格
      var prumpr=nui.getbyName("detail.prumpr").getValue();
      //本次发生额
      nui.getbyName("detail.thisam").setValue(defi03 * stckpr + defi03 * prumpr);
      //获取整个form中的input数据转换object对象
      var data = form.getData(false,true);
      //将表单数据转换成json字符串
      var json = nui.encode(data);
      $.ajax({
        url:"com.sunline.sunfi.sunfi_wf.doExecuteWf.startWorkFlowForAjax.biz.ext",
        type:'POST',
        data:json,
        cache:false,
        contentType:'text/json',
        success:function(text){
            var returnJson = nui.decode(text);
			if(returnJson.exception == null){
				submitWorkFlow(returnJson);
				CloseWindow("saveSuccess");
			}else{
				nui.alert("保存<%=obj %>失败", "系统提示");
			}
        }
      });
    }
    
    function onReset(){
      form.reset();
      form.setChanged(false);
    }
    
    function onCancel(){
      CloseWindow("cancel");
    }
    
    function CloseWindow(action){
      if(action=="close" && form.isChanged()){
        if(confirm("数据已改变,是否先保存?")){
          return false;
        }
      }else if(window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
      else
        return window.close();
    }
  
      //选择股权编号
   	  function selecteqbkno(e) {
		  var btnEdit = this;
		  var eqbkno=this.value;//临时保存
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqbBookSelect.jsp?param/status=0",
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
		                        btnEdit.setValue(data.eqbkno);//提交值
		                        btnEdit.setText(data.eqbkno);//显示值
		                        
		                        nui.getbyName("detail.eqbktp").setValue(data.eqbktp);//股权类型
		                        
		                        nui.getbyName("detail.dcmtno").setValue(data.dcmtno);//凭证号码
		                        
		                        nui.getbyName("detail.shhdcd").setValue(data.shhdcd);//股东代码
		                        
		                        nui.getbyName("detail.shhdna").setValue(data.shhdna);//股东名称
		                        
		                        nui.getbyName("detail.stcknm").setValue(data.stcknm);//持股数
		                        
		                        nui.getbyName("detail.stckam").setValue(data.stckam);//持股金额
		                        
		                        nui.getbyName("detail.entcdt").setValue(data.entcdt);//入股日期
		                   }
		                }
		                if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(eqbkno);
		                        btnEdit.setText(eqbkno);
		                }
		            }
		        });            
   		}
   		  
    //开启工作流
    function submitWorkFlow(returnJson){
		//工作流程实例ID
		var wkflid=returnJson.wkflid;
		if(wkflid !=null){
		//url:"<%=request.getContextPath() %>"+"/sunfi_wf/beforeWorkFolw.jsp?wkflid="+ wkflid,
		//com.sunline.sunfi.sunfi_wf.submitWorkFlow.flow
		  nui.open({
          url:"<%=request.getContextPath() %>"+"/sunfi_wf/com.sunline.sunfi.sunfi_wf.submitWorkFlow.flow?wkflid=" + wkflid,
          title:'流程审批',
          width:800,
          height:400,
          onload:function(){
          		 },
          ondestroy:function(action){
             			if(action == "ok" || action == "close"){
							CloseWindow("saveSuccess");
						}
          			}
                 });
		}else{
			nui.alert("提交流程失败", "系统提示", function(action){
						if(action == "ok" || action == "close"){
							CloseWindow("saveFailed");
						}
			});
		}
		
    }
  </script>
</body>
</html>