<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-05 09:37:44
  - Description:
-->
<head>
<title>股权证挂失</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
<fieldset style="width:700px;border:solid 1px #aaa;position:relative;">
     <legend>股权证挂失信息</legend>
	<div id="editForm1" style="padding-top: 5px;" align="center">
		<!-- 流程id -->
		<input class='nui-hidden' name="master.prcscd" value="eqd_dct_los">
		<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
			<tr>
				<td class="form_label" align="right">股权证编号:</td>
				<td colspan="1" align="left">
		         	<input name="master.dcmtno" class="nui-buttonedit" onbuttonclick="onButtonEdit"/>
		        </td>
				<td class="form_label" align="right">凭证状态:</td>
				<td colspan="1" align="left">
				 	<input class="nui-dictcombobox nui-form-input" name="master.dcmtst" value="1"  readOnly="true"
          			valueField="dictID" textField="dictName" dictTypeId="FI_DCMTST"/>
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">发证日期:</td> 
				<td colspan="1" align="left"><input class="nui-textbox" name="master.opendt" readOnly="true"/></td>
				<td class="form_label" align="right">发证流水:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.opensq" readOnly="true"/></td>
			</tr>
			<tr>
				<td class="form_label"  align="right">股东编号:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.shhdcd" readOnly="true"/></td>
				<td class="form_label"  align="right">股东类型:</td>
				<td colspan="1" align="left">
					<input class="nui-dictcombobox nui-form-input" name="master.shhdtp" readOnly="true"
          			valueField="dictID" textField="dictName" dictTypeId="FI_SHHDTP"/>
          		</td>
			</tr>
			<tr>
				<td class="form_label"  align="right">股东名称:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.shhdna" readOnly="true"/></td>
				<td class="form_label"  align="right">证件类型:</td>
				<td colspan="1" align="left">
					<input class="nui-dictcombobox nui-form-input" name="master.idcdtp" readOnly="true"
          			valueField="dictID" textField="dictName" dictTypeId="FI_IDCDTP"/>
          		</td>
			</tr>
			<tr>
				<td class="form_label"  align="right">证件号码:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.idcard" readOnly="true"/></td>
				<td class="form_label"  align="right">持股数:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.stcknm" readOnly="true"/></td>
			</tr>
			<tr>
				<td class="form_label"  align="right">持股金额:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.stckam" readOnly="true"/></td>
				<td class="form_label"  align="right">挂失日期:</td>
				<td colspan="1" align="left"><input name="master.lossdt" class="nui-datepicker" format="yyyyMMdd" value="new Date()"/></td>
			</tr>
			<tr>
				<td class="form_label"  align="right">挂失原因:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.lossrs" required="true"/></td>
				<td class="form_label"  align="right">临时挂失:</td>
				<td colspan="1" align="left">
					<input class="nui-dictcombobox nui-form-input" name="master.type" value="2"
          			valueField="dictID" textField="dictName" dictTypeId="FI_DCMTST_NEW"/>
          		</td>
			</tr>
		</table>
	</div>
	<div style="text-align:center;padding:10px;">               
	    <a class="mini-button" onclick="onSave" style="width:60px;margin-right:20px;">保存</a>       
	    <a class="mini-button" onclick="onReset" style="width:60px;">重置</a>       
	</div> 
</fieldset>

	
	<script type="text/javascript">
		nui.parse();
		var bootPath = "<%=request.getContextPath() %>";
		var form = new mini.Form("#editForm1");
		
		function onButtonEdit(e) {
			var btnEdit = this;
		    nui.open({
			    url: bootPath+"/fdeqb/eqddcmtdetls_query.jsp?dcmtst=1",
			    title: "选择列表",
			    width: 650,
			    height: 380,
			    ondestroy: function (action) {
			        if (action == "ok") {
			            var iframe = this.getIFrameEl();
			            var data = iframe.contentWindow.GetData();
			            data = nui.clone(data);    //必须
			 			if (data) {
				 			btnEdit.setValue(data.dcmtno);
				            btnEdit.setText(data.dcmtno);
				            nui.getbyName("master.dcmtst").setValue(data.dcmtst);
			            	nui.getbyName("master.opendt").setValue(data.opendt);
			            	nui.getbyName("master.opensq").setValue(data.opensq);
			            	nui.getbyName("master.shhdcd").setValue(data.shhdcd);
			            	nui.getbyName("master.shhdtp").setValue(data.shhdtp);
			            	nui.getbyName("master.shhdna").setValue(data.shhdna);
			            	nui.getbyName("master.idcdtp").setValue(data.idcdtp);
			            	nui.getbyName("master.idcard").setValue(data.idcard);
			            	nui.getbyName("master.stcknm").setValue(data.stcknm);
			            	nui.getbyName("master.stckam").setValue(data.stckam);
			 			}
			        }
			    }
			});
		}
		
		function onSave(){
			//提交表单数据
			var data = form.getData();      //获取表单多个控件的数据
			data.master.lossdt = nui.getbyName("master.lossdt").getFormValue(); //日期需要特殊处理
			var json = nui.encode(data);   //序列化成JSON
			nui.ajax({
				url: "com.sunline.sunfi.sunfi_cm.busbiz.transferProcedure.biz.ext",
				type: "post",
				contentType: "text/json",
				data:json ,
				success: function (text) {
					var returnJson = nui.decode(text);
                    if(returnJson.exception == null){
                        nui.alert("提交成功，返回结果:"+text.retmsg.erortx);
                        form.reset();
                    }else{
                        nui.alert("处理失败:"+returnJson.exception.message);
                    }
			    }
			});
		}
		function onReset(){
            form.reset();
		}
		
	</script>
</body>
</html>