<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%--
- Author(s): Administrator
- Date: 2019-05-05 15:12:32
- Description:
--%>
<%
		//获取标签中使用的国际化资源信息
		String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
		String opratp = request.getParameter("opratp");
		String obj = ""; //
		String opranm="";
		String oprars="";
		String opradt="";
		String urlna="";
		String addprcscd=""; 
		String entprcscd="";
		if("20".equals(opratp)){
				addprcscd="eqb_upl_add";
				entprcscd="eqb_upl_etr";
				obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slupledge"); //解质押
				opranm= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slupldgnm");//解质押股数
				oprars= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slupldgrs");//解质押原因
				opradt= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slupldgdt");//解质押日期
				urlna=com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slupledgebook");//解质押登记簿
		}else if("22".equals(opratp)){
				addprcscd="eqb_ufz_add";
				entprcscd="eqb_ufz_etr";
				obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slufreeze"); //解冻结
				opranm= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slufrzenm");//解冻结股数
				oprars= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slufrzers");//解冻结原因
				opradt= com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_slufrzedt");//解冻结日期
		}
		String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//
		
		request.setAttribute("opratp", opratp);
%>
<%
		String wkflid = request.getParameter("wkflid");//流程ID
		request.setAttribute("wkflid", wkflid);
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <%=obj_input %>
    </title>
  </head>
  <body style="width:100%;overflow:hidden;">
  	 <form id="form1" method="post">
        <input name="detail.eqbkno" class="nui-hidden"/>
        <input name="detail.bsnsdt" class="nui-hidden"/>
        <input name="detail.bsnssq" class="nui-hidden"/>
        <input name="detail.lnnssq" class="nui-hidden"/>
        <input name="detail.lnnsdt" class="nui-hidden"/>
        <input name="detail.usercd" class="nui-hidden"/>
        <input name="master.wfdena" class="nui-hidden" value="com.sunline.sunfi.sunfi_wf.eqApp"/>
        <input name="master.wfinna" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.wfinde" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.linkna" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.entityna" class="nui-hidden" value="com.sunline.sunfi.sunfi_eq.eqb.EqbBook"/>
        <input name="detail.ismain" class="nui-hidden" value="0"/>

        <input name="master.prcscd" class="nui-hidden" value="<%=addprcscd %>"/>
        <input name="detail.ismain" class="nui-hidden" value="0"/>
        <input name="detail.calPrcscd" class="nui-hidden" value="eqb_com_cal"/>
        <input name="detail.addPrcscd" class="nui-hidden" value="<%=addprcscd %>"/>
        <input name="detail.enterPrcscd" class="nui-hidden" value="<%=entprcscd %>"/>
        <input name="master.lnkurl" class="nui-hidden" value="/sunfi_eq/EqbPldgMemoveQuery.jsp?opratp=${opratp}&wkflid="/>
        <input name="detail.lnkurl" class="nui-hidden" value="/sunfi_eq/EqbPldgMemoveQuery.jsp?opratp=${opratp}&wkflid="/>
        
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
				            <input class="nui-dictcombobox " name="detail.ecmytp" allowInput="false" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;">股东代码：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="detail.shhdcd" allowInput="false" required="true"/>
				        </td>
	                    <td style="width:100px;">股东名称：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="detail.shhdna" allowInput="false" required="true"/>
	                    </td>
	                    <td style="width:100px;">股权类型：</td>
	                    <td style="width:150px;">
				            <input class="nui-dictcombobox " name="detail.eqbktp" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
	                </tr> 
	                <tr>
	                	<td style="width:100px;">持股数：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="detail.stcknm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td>
	                	<td style="width:100px;">持股金额：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="detail.stckam" allowInput="false" required="true" emptyText="0" vtype="float"/>
				        </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;">质押股数：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="detail.pldgnm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td> 
	                	<td style="width:100px;">冻结股数：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="detail.froznm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td>
	                    <td style="width:100px;"><%=opranm %>：</td>
	                    <td style="width:150px;">
	                    	<input class="nui-textbox " name="detail.thisam"  required="true" emptyText="0" vtype="int"/>
	                    </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;"><%=opradt %>：</td>
				        <td style="width:150px;">
				        	<input class="nui-datepicker " name="detail.pldgdt" allowInput="false" required="true"/>
				        </td>
	                    <td style="width:100px;"><%=oprars %>：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="detail.pldgrs" required="true" />
	                    </td>	                	
	                </tr>
	                <tr>
	                    <td style="width:100px;">申请文书号：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="detail.aplyno" required="true" />
	                    </td>
	                    <td style="width:100px;">批准文书号：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="detail.audtno" />
	                    </td>
	                </tr>
	            </table>
             </div>
        </div>
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>    
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
  <script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");
	var opratp="${opratp}";
	
    function onOk(){
      saveData();
    }
    
    function saveData(){
      form.validate();
      if(form.isValid()==false) 
      	return;
      	
      if(!dataCheck())
         return ;
      //获取整个form中的input数据转换object对象
      var data = form.getData(false,true);
      var pldgdt=nui.getbyName("detail.pldgdt").getValue();
      data.detail.pldgdt=pldgdt.substring(0,4) + pldgdt.substring(5,7) + pldgdt.substring(8,10);
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
    
    function dataCheck(){
    	var thisam=nui.getbyName("detail.thisam").getValue();//解质押（冻结）股数
        var froznm=nui.getbyName("detail.froznm").getValue();//冻结股数
        var pldgnm=nui.getbyName("detail.pldgnm").getValue();//质押股数
        if(opratp == '20'){//质押
        	if(thisam > pldgnm - 0)
        	{
        		alert("解质押股数不能大于质押股数！");
        		return false;
        	}
        }else {
        	if(thisam > froznm - 0)
        	{
        		alert("解冻结股数不能大于冻结股数！");
        		return false;
        	}
        }
        return true;
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
		  var pldgst="",frozst="";
		
		  if(opratp == "20"){//解质押
		  	  opratp="19";    
		  	  pldgst="0";   	 
		  }else if(opratp == "22"){//解冻结
		  	  opratp="21";    
		  	  frozst="0";    
		  }
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqbPldgSelect.jsp?pldgst="+ pldgst +"&frozst="+ frozst +"&opratp=" + opratp,
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
		                        
		                        nui.getbyName("detail.ecmytp").setValue(data.ecmytp);//经济性质
		                        
								nui.getbyName("detail.dcmtno").setValue(data.dcmtno);//凭证号码
								
		                        nui.getbyName("detail.shhdcd").setValue(data.shhdcd);//股东代码
		                        
		                        nui.getbyName("detail.shhdna").setValue(data.shhdna);//股东名称
		                        
		                        nui.getbyName("detail.stcknm").setValue(data.stcknm);//持股数
		                        
		                        nui.getbyName("detail.stckam").setValue(data.stckam);//持股金额
		                        
								nui.getbyName("detail.lnnsdt").setValue(data.bsnsdt);
								
								nui.getbyName("detail.lnnssq").setValue(data.bsnssq);
								
								nui.getbyName("detail.pldgnm").setValue(data.pldgnm);//质押股数
								
								nui.getbyName("detail.froznm").setValue(data.froznm);//冻结股数
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
				CloseWindow("saveSuccess");
			}
			});
		}	
    }
  </script>
</body>
</html>