<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>
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
String obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_book"); //
String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//
String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
%>
</head>
<body>
  <div id="form1" style="padding-left:11px;padding-bottom:5px;">
   <input class="nui-hidden" name="detail.eqbkno"/>
   <input class="nui-hidden" name="detail.cardsq"/>
   <input class="nui-hidden" name="param.cityno"/>
   <input class="nui-hidden" name="master.wfdena" value="com.sunline.sunfi.sunfi_wf.eqApp"/><!-- 业务流程名称  -->
   <input class="nui-hidden" name="master.wfinna" value="股权登记"/><!-- 流程实例名称 -->
   <input class="nui-hidden" name="master.wfinde" value="股权登记"/><!-- 流程实例描述  -->
   <input class="nui-hidden" name="master.lnkurl" value="/sunfi_eq/EqbBookQuery.jsp?wkflid="/>
   <input class="nui-hidden" name="detail.lnkurl" value="/sunfi_eq/EqbBookQuery.jsp?wkflid="/>
   <input class="nui-hidden" name="master.entityna" value="com.sunline.sunfi.sunfi_eq.eqb.EqbBook"/>
   <input class="nui-hidden" name="master.linkna" value="<%=obj_input %>"/>
   <input class="nui-hidden" name="detail.ismain" value="0"/>
   <input class="nui-hidden" name="detail.addPrcscd" value="eqb_reg_add"/>
   <input class="nui-hidden" name="detail.enterPrcscd" value="eqb_reg_etr"/>
   <input class="nui-hidden" name="detail.calPrcscd" value="eqb_com_cal"/>
    <table style="table-layout:fixed;">
      <tr>
        <td class="form-label">
        	股权类型：
        </td>
        <td>
          <input id="detail.eqbktp" class="nui-dictcombobox " name="detail.eqbktp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
        </td>
        <td class="form-label" >
        	 凭证号码：
        </td>
        <td>
          <input id="detail.dcmtno" class="nui-textbox " name="detail.dcmtno" required="true"/>
        </td>
        <td class="form-label">
        	 经济性质：
        </td>
        <td>
          <input id="detail.ecmytp" class="nui-dictcombobox " name="detail.ecmytp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
        </td>
      </tr>
      <tr>
        <td class="form-label">
        	股东名称：
        </td>
        <td>
          <input id="detail.shhdcd" class="nui-buttonedit searchbox  " name="detail.shhdcd" onbuttonclick="selectshhdna" allowInput="false" required="true"/>
        </td>
        <td class="form-label">
        	持股数：
        </td>
        <td>
          <input id="detail.stcknm" class="nui-textbox " name="detail.stcknm" required="true" onblur="datacheck(0)" />
        </td>
        <td class="form-label">
        	持股金额：
        </td>
        <td>
          <input id="detail.stckam" class="nui-textbox " name="detail.stckam" required="true" />
        </td>
       </tr>
       <tr>
        <td class="form-label">
        	每股价格：
        </td>
        <td>
          <input id="detail.stckpr" class="nui-textbox " name="detail.stckpr" required="true"/>
        </td>
        <td class="form-label">
        	股权金额：
        </td>
        <td>
          <input id="detail.eqtyam" class="nui-textbox " name="detail.eqtyam" required="true"/>
        </td>
        <td class="form-label">
        	溢价价格：
        </td>
        <td>
          <input id="detail.prumpr" class="nui-textbox " name="detail.prumpr" allowInput="true" onblur="datacheck(0)"/>
        </td>
       </tr>
       <tr>
        <td class="form-label">
        	溢价金额：
        </td>
        <td>
          <input id="detail.prumam" class="nui-textbox " name="detail.prumam" allowInput="true"/>
        </td>
        <td class="form-label">
        	入股日期：
        </td>
        <td>
          <input id="detail.entcdt" class="nui-datepicker " name="detail.entcdt"  allowInput="false" required="true"/>
        </td>
        <td class="form-label">
        	入股方式：
        </td>
        <td>
          <input id="detail.tranty" class="nui-dictcombobox " name="detail.tranty" onvaluechanged="valueSet" required="true" valueField="dictID"  textField="dictName" dictTypeId="FI_TRANTY" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
        </td>  
      </tr>
      <tr>
        <td class="form-label">
        	币种：
        </td>
        <td>
          <input id="detail.crcycd" class="nui-dictcombobox " name="detail.crcycd"  valueField="dictID" textField="dictName" dictTypeId="FI_CRCYCD" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
        </td>
        <td class="form-label">
        	账务部门：
        </td>
        <td>
          <input id="detail.acctbr" class="nui-buttonedit searchbox " name="detail.acctbr" required="true" onbuttonclick="selectcombrch" style="width: 130px;" allowInput="false"/>
        </td>
        <td class="form-label">
        	股权备注：
        </td>
        <td>
          <input id="detail.remark" class="nui-textbox " name="detail.remark" allowInput="true"/>
        </td>
      </tr>
    </table>
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
  </div>

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
 	  if(!datacheck(1)){
		alert('股权金额+溢价金额<>持股金额');//股权金额+溢价金额<>持股金额
		return;
	  } 
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
				nui.alert("保存股权登记失败", "系统提示");
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
    //选择账务部门
    function selectcombrch(e) {
	  var btnEdit = this;
	  nui.open({
	        url: "<%=request.getContextPath() %>" + "/sunfi_cm/ComBrchSelect.jsp",
	      	showMaxButton: false,
	        	title: "账务机构_选择列表",
	        	width: 1200,
	        	height: 580,
	        	allowResize:false,
	        	ondestroy: function(action){
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.getData();
	                    data = nui.clone(data);
	                    if (data) {
	                        btnEdit.setValue(data.brchcd);//提交值
	                        btnEdit.setText(data.brchna);//显示值
	                    }
	                }if (action == "cancel" || action == "close") {
	                        btnEdit.setValue(null);
	                        btnEdit.setText(null);
	                }
	            }
	        });            
		}
		
   	//选择股东名称
   	function selectshhdna(e) {
		  var btnEdit = this;
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqpShhdAllSelect.jsp",
	        	showMaxButton: false,
            	title: "股东名称_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.shhdcd);//提交值
		                        btnEdit.setText(data.shhdna);//显示值
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(null);
		                        btnEdit.setText(null);
		                }
		            }
		        });            
   		}
   		
   	function valueSet(){
	  	var tranty = nui.get("detail.tranty").getValue();
	  	//继承     赠与       转让
	  	if(tranty == '3' || tranty == '4' || tranty == '5'){
	  	    //持股数
	  		nui.get("detail.stcknm").setValue(0);
	  		//持股金额
	  		nui.get("detail.stckam").setValue(0);
	  		//每股价格
	  		nui.get("detail.stckpr").setValue(0);
	  		//股权金额
	  		nui.get("detail.eqtyam").setValue(0);
	  		//溢价价格
	  		nui.get("detail.prumpr").setValue(0);
	  		//溢价金额
	  		nui.get("detail.prumam").setValue(0);
	  		
	  		nui.get("detail.stcknm").disable();
	  		nui.get("detail.stckam").disable();
	  		nui.get("detail.stckpr").disable();
	  		nui.get("detail.prumpr").disable();
	  	} 
	  	else{
	  		nui.get("detail.stcknm").enable();
	  		nui.get("detail.stckam").enable();
	  		nui.get("detail.stckpr").enable();
	  		nui.get("detail.prumpr").enable();
	  	}
	 }	
	 
    //股权金额、溢价金额等计算
	function datacheck(sign){
	    var stcknmstr = nui.get("detail.stcknm").getValue(); //持股数
		var stckprstr = nui.get("detail.stckpr").getValue(); //每股价格
		var prumprstr = nui.get("detail.prumpr").getValue(); //溢价价格
		var stcknm,stckpr,prumpr,eqtyam,prumam;
		if(sign==0){
			if(stcknm != ''){
			    stcknm = new Number(stcknmstr);
				if(stckprstr != ''){
					stckpr = new Number(stckprstr);
					eqtyam =stcknm*stckpr;
					nui.get("detail.eqtyam").setValue=eqtyam;//股权金额
					//numToMoneyField($name("detail.eqtyam"));
				}
				if(prumprstr != ''){
					prumpr = new Number(prumprstr);
					prumam =stcknm*prumpr;
					nui.get("detail.prumam").setValue=prumam;//溢价金额
					//numToMoneyField($name("detail.prumam"));
				}
			}
		}else{
		    var stckam = new Number(nui.get("detail.stckam").getValue());
			stcknm = new Number(stcknmstr);
			if(stckprstr == ''){
				nui.get("detail.stckpr").setValue(0);
				stckprstr = "0";
			}
			if(prumprstr == ''){
			    nui.get("detail.prumpr").setValue(0);
				prumprstr ="0";
			}
			stckpr = new Number(stckprstr);
			prumpr = new Number(prumprstr);
			eqtyam =stcknm*prumpr;
			prumam =stcknm*stckpr;
			nui.get("detail.prumam").setValue(eqtyam);//溢价金额
			nui.get("detail.eqtyam").setValue(prumam);//股权金额
			if(stckam !=eqtyam+prumam){
				return false;
			}
		}
		return true;
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
				CloseWindow("saveSuccess");
			}
			});
		}	
    }
  </script>
</body>
</html>