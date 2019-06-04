<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): kaifasanshi93
  - Date: 2018-12-06 09:48:52
  - Description:
-->
<head>
<title>新增付款账户</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
   <div id="dataform1" style="padding-top:5px;">
         <table  class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                       付款账号:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="comacct.acctno" required="true" onvalidation="codevalidation"/>
                    </td>
                    <td class="nui-form-table-text">
                        付款账号名称:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="comacct.acctna" required="true" />
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        会计科目:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectItem" allowInput="false" id="comacct.itemcd" name="comacct.itemcd" textName="itemna"/>
                    </td>
                    <td class="nui-form-table-text">
                        所属机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectBrch" allowInput="false" id="comacct.brchcd" name="comacct.brchcd" />
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        所属责任中心:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectDuty" allowInput="false" id="comacct.dutycd" name="comacct.dutycd" />
                    </td>
                    <!-- <td class="form_label">
                        开户银行:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectBank" allowInput="false" name="comacct.bkname" />
                    </td> -->
                    <td class="nui-form-table-text">
                        开户银行:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectBank" allowInput="false" id="comacct.brname" name="comacct.brname" />
                    </td>
                </tr>
                <tr>                   
                    <td class="nui-form-table-text">
                         联系电话:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="comacct.phone"/>
                    </td>
                    <td class="nui-form-table-text">
                         是否默认账户:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="FI_ISDEACCT" id="comacct.isacct" name="comacct.isacct" required="true" value="0"/>
                    </td>
                </tr>
            </table>
            
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button"  onclick="onOk()">
                                保存
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
             </div>
          </div>   

	<script type="text/javascript">
	
    	nui.parse();
    	var form = new nui.Form("#dataform1");      
    	var bootPath = "<%=request.getContextPath() %>";
    	
    	function selectItem() {
			        var btnEdit = this;
			        nui.get("comacct.itemcd").setValue(null);
			        nui.get("comacct.itemcd").setText(null);
			        nui.open({
			            url: bootPath + "/sunfi_cm/item/comItem_select.jsp",
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
			        nui.get("comacct.brchcd").setValue(null);
			        nui.get("comacct.brchcd").setText(null);
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
			        var brchcd = nui.get("comacct.brchcd").getValue();
			        
			        if(!brchcd){
			        	nui.alert("请先选择机构","提示");
			        	return;
			        }
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
			       
		function selectBank() {
			        var btnEdit = this;
			        nui.get("comacct.brname").setValue(null);
			        nui.get("comacct.brname").setText(null);
			        nui.open({
			            url: bootPath + "/sunfi_cm/bank/bank_select.jsp",
			            showMaxButton: false,
			            title: "选择开户行",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.brname);
			                        btnEdit.setText(data.brname);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                }
			            }
			        });            
			       }
		
		//判断是否数字	       
		function isNumber(v) {
			       var re = new RegExp("^[0-9]*$");
			       if (re.test(v)) return true;
			       return false;
			    }
		
		//校验付款账号	    
		function codevalidation(e){
			        	if(e.isValid){
				        	 if (isNumber(e.value) == false) {
			                     e.errorText = "必须输入数字";
			                     e.isValid = false;
			                     return;
	                			}					          
			        	    var data = {acctno:e.value};
			        		var json = nui.encode({template:data});
				        	$.ajax({
			                    url: "com.sunline.sunfi.sunfi_cm.comacctbiz.checkAcctno.biz.ext",
			                    type: 'POST',
				                data: json,
				                contentType:'text/json',
			                    cache: false,
			                    async: false,
			                    success: function (text) {
			                       var o = nui.decode(text);
			                        if(o.data == "1"){
			                        	e.errorText = "付款账号已存在，请请重新填写";
				        				e.isValid = false;
			                        }
			                    }
				           });
			        	}
			        }			        
    	
    	function saveData(){
			    form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
			        url: "com.sunline.sunfi.sunfi_cm.comacctbiz.checkIsAcctAdd.biz.ext",
			        type: 'POST',
				    data: json,
				    contentType:'text/json',
			        cache: false,
			        async: false,
			        success: function (text) {
			        var o = nui.decode(text);
			        if(o.retuin == "1"){
			            nui.alert("一个法人机构只能有一个默认账户！","提示");
				        return false;
			          }
                $.ajax({
                    url:"com.sunline.sunfi.sunfi_cm.comacctbiz.addComAcct.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                                });
                            }
                        }
                        });
			       }
				});							
       }
                    //关闭窗口
                    function CloseWindow(action) {
                        if (action == "close" && form.isChanged()) {
                            if (confirm("数据被修改了，是否先保存？")) {
                                saveData();
                            }
                        }
                        if (window.CloseOwnerWindow)
                        return window.CloseOwnerWindow(action);
                        else window.close();
                    }

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
    </script>
</body>
</html>