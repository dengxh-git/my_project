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
	String obj = "";
	String prcscd="";
	String opratp = request.getParameter("opratp"); 
	if(opratp.equals("13")){
		obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbbook_inherit"); //继承
		prcscd="eqb_iht_add";
	}
	else if(opratp.equals("14")){
		obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbbook_transfer"); //转让
		prcscd="eqb_trs_add";
	}
	else{
		obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbbook_qrant"); //赠与
		prcscd="eqb_gft_add";
	}
	request.setAttribute("opratp", opratp);
	
	String gqzrfxx = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.gqzrfxx"); //
	String gqsrfxx = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.gqsrfxx"); //
	String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//
	String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
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
        <input name="master.wfdena" class="mini-hidden" value="com.sunline.sunfi.sunfi_wf.eqApp"/>
        <input name="master.cityno" class="mini-hidden" value="param/cityno"/>
        <input name="master.wfinna" class="mini-hidden" value="<%=obj_input %>"/>
        <input name="master.wfinde" class="mini-hidden" value="<%=obj_input %>"/>
	  	<input name="master.lnkurl" class="mini-hidden" value="com.sunline.sunfi.sunfi_eq.EqbBookInherit.flow?_eosFlowAction=query&opratp=${opratp}&wkflid=${wkflid}"/>
        <input name="master.linkna" class="mini-hidden" value="<%=obj_input %>"/>
        <input name="master.entityna" class="mini-hidden" value="com.sunline.sunfi.sunfi_eq.eqb.EqbBook"/>
	    <input name="detail.lnkurl" class="mini-hidden" value="com.sunline.sunfi.sunfi_eq.EqbBookInherit.flow?_eosFlowAction=query&opratp=${opratp}&wkflid=${wkflid}"/>
        <input name="detail.ismain" class="mini-hidden" value="0"/>
        <input name="detail.addPrcscd" class="mini-hidden" value="<%=prcscd %>"/>
        <input name="detail.enterPrcscd" class="mini-hidden" value="eqb_trs_etr"/>
        <input name="detail.calPrcscd" class="mini-hidden" value="eqb_com_cal"/>
        <input name="detail.eqbkno" class="mini-hidden"/>
        <input name="detail.cardsq" class="mini-hidden"/>
        <input name="detail.froznm" class="mini-hidden"/>
        <input name="detail.pldgnm" class="mini-hidden"/>

        <div style="padding-left:11px;padding-bottom:5px;">
         	<fieldset style="border:solid 1px #aaa;padding:3px;">
	            <legend>股权转让方信息</legend>
	            <div style="padding:5px;">
		            <table style="table-layout:fixed;">
		                <tr>
		                    <td style="width:80px;">股权编号：</td>
		                    <td style="width:150px;">    
		                    	<input class="nui-buttonedit searchbox" name="detail.eqbkno" onbuttonclick="selecteqbkno" allowInput="false" />
		                    </td>
		                    <td style="width:80px;">经济性质：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.ecmytp" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
					        <td style="width:80px;">股东代码：</td>
					        <td style="width:150px;">
					          	<input class="nui-textbox " name="detail.shhdcd" allowInput="false" required="true"/>
					        </td>
		                </tr>
		                <tr>
		                    <td style="width:80px;">股东名称：</td>
		                    <td style="width:150px;">    
		                    	<input class="nui-textbox " name="detail.shhdna" allowInput="false" required="true"/>
		                    </td>
					        <td style="width:80px;">持股数：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.stcknm" allowInput="false" required="true" emptyText="0" vtype="int"/>
					        </td>
					        <td style="width:80px;">持股金额：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.stckam" allowInput="false" required="true" emptyText="0" vtype="float"/>
					        </td>
		                </tr> 
		                <tr>
		                	<td style="width:80px;">股权类型：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.eqbktp" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
					        <td style="width:80px;">股权备注：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.remark" required="true"/>
					        </td>
					        <td style="width:80px;">转让股数：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.trshnm" emptyText="0" vtype="int" required="true"/>
					        </td>
		                </tr> 
		                <tr>
					        <td style="width:80px;">转让金额：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.trsham" emptyText="0" vtype="float" required="true"/>
					        </td>     
		                </tr> 
		            </table>
                 </div>
        	</fieldset>
        	<fieldset style="border:solid 1px #aaa;padding:3px;">
	            <legend>股权受让方信息</legend>
	            <div style="padding:5px;">
		            <table style="table-layout:fixed;">
		                <tr>
		                    <td style="width:80px;">股权编号：</td>
		                    <td style="width:150px;">    
		                    	<input class="nui-buttonedit searchbox" name="detail.i_eqbkno" onbuttonclick="selecteqbkno" allowInput="false" />
		                    </td>
		                    <td style="width:80px;">经济性质：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.i_ecmytp" allowInput="false" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
					        <td style="width:80px;">股东代码：</td>
					        <td style="width:150px;">
					          	<input class="nui-buttonedit searchbox " name="detail.i_shhdcd" onbuttonclick="selecteshhdcd" allowInput="false" />
					        </td>
		                </tr>
		                <tr>
		                    <td style="width:80px;">股东名称：</td>
		                    <td style="width:150px;">    
		                    	<input class="nui-textbox " name="detail.i_shhdna" allowInput="false" required="true"/>
		                    </td>
		                    <td style="width:80px;">入股日期：</td>
					        <td style="width:150px;">
					            <input class="nui-datepicker " name="detail.i_entcdt" allowInput="false" required="true" />
					        </td>
					        <td style="width:80px;">持股数：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.i_stcknm" emptyText="0" vtype="int" />
					        </td>
		                </tr> 
		                <tr>
					        <td style="width:80px;">持股金额：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.i_stckam" emptyText="0" vtype="float" />
					        </td>
		                	<td style="width:80px;">入股方式：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.i_tranty" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_TRANTY" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
					        <td style="width:80px;">股权类型：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.i_eqbktp"  required="true" valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
		                </tr> 
		                <tr>
					        <td style="width:80px;">账务部门：</td>
					        <td style="width:150px;">
					          	<input class="nui-buttonedit searchbox " name="detail.i_acctbr" onbuttonclick="selectcombrch" allowInput="false" />
					        </td>
					        <td style="width:80px;">币种代码：</td>
					        <td style="width:150px;">
					            <input class="nui-dictcombobox " name="detail.i_crcycd"  valueField="dictID" textField="dictName" dictTypeId="FI_CRCYCD" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
					        </td>
					        <td style="width:80px;">股权备注：</td>
					        <td style="width:150px;">
					            <input class="nui-textbox " name="detail.i_remark" />
					        </td>
		                </tr> 
		            </table>
                 </div>
        	</fieldset>
        </div>
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
  <script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");
	
    function onOk(){
      saveData();
    }
    
    function saveData(){
        var stcknm=nui.getbyName("detail.stcknm").getValue();//转出方持股数
		var froznm=nui.getbyName("detail/froznm").getValue();//冻结股数
		var pldgnm=nui.getbyName("detail/pldgnm").getValue();//质押股数
		var validnm=stcknm-froznm-pldgnm;//转出方有效持股数
		var trshnm=nui.getbyName("detail.trshnm").getValue();//转让股数
		var trsham=nui.getbyName("detail.trsham").getValue();//转让金额
		
		if(validnm < trshnm || validnm < 0){
			alert("转让股数不能大于转让方有效持股数!");//转让股数不能大于转让方有效持股数!'<b:message key="sunfi.sunfi_eq.trshnmtoomore"/>'
			return;
		}
		
/* 		if(parseFloat(trshnm) * parseFloat(thshpr) != parseFloat(trsham)){
			alert('<b:message key="sunfi.sunfi_eq.trshnmnoteqtrsham"/>');//转让股数乘以每股价格不等于转入金额
			return;
		}  */
		
      form.validate();
      if(form.isValid()==false) 
      	return;
	 
      //获取整个form中的input数据转换object对象
      var data = form.getData(false,true);
      var entcdt=nui.getbyName("detail.i_entcdt").getValue();
      data.detail.i_entcdt=entcdt.substring(0,4) + entcdt.substring(5,7) + entcdt.substring(8,10);
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
				nui.alert("保存股权继承失败", "系统提示", function(action){
					if(action == "ok" || action == "close"){
						CloseWindow("saveFailed");
					}
				});
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
   	  	  var i="";
		  var btnEdit = this;
		  var eqbkno=this.value;//临时保存
		  if(e.sender.name=="detail.i_eqbkno"){
		  	i='i_';
		  }
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqbBookSelect.jsp?param/isout=1&param/status=0&param/pldgst=2&param/frozst=2",
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
		                        
		                        nui.getbyName("detail."+i+"eqbktp").setValue(data.eqbktp);//股权类型
		                        
		                        nui.getbyName("detail."+i+"ecmytp").setValue(data.ecmytp);//经济性质

		                        nui.getbyName("detail."+i+"shhdcd").setValue(data.shhdcd);//股东代码
		                        
		                        nui.getbyName("detail."+i+"stcknm").setValue(data.stcknm);//持股数
		                        
		                        nui.getbyName("detail."+i+"stckam").setValue(data.stckam);//持股金额
		                        
		                        nui.getbyName("detail."+i+"shhdna").setValue(data.shhdna);//股东名称
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(eqbkno);
		                        btnEdit.setText(eqbkno);
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
		                        btnEdit.setValue(data.shhdcd);//提交值
		                        btnEdit.setText(data.shhdna);//显示值
		                        
		                        nui.getbyName("detail.i_shhdna").setValue(data.shhdna);//股东名称
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(null);
		                        btnEdit.setText(null);
		                }
		            }
		        });            
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

