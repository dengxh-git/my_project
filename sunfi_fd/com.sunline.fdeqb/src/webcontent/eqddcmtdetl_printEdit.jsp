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
<title>股权证变更</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
<fieldset style="width:600px;border:solid 1px #aaa;position:relative;">
    <legend>股权证变更信息</legend>
	<div id="editForm1" style="padding-top: 5px;" align="center">
		<!--  hidden域 -->
		<div id="hiddenForm"></div>
		<!-- 流程id -->
		<input class='nui-hidden' name="master.prcscd">
		<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
			<tr>
				<td class="form_label" align="right">股权编号:</td>
				<td colspan="1" align="left">
		         	<input name="master.eqbkno" class="nui-textbox"/>
		        </td>
				<td class="form_label" align="right">股权类型:</td>
				<td colspan="1" align="left">
				 	<input class="nui-dictcombobox nui-form-input" name="master.eqbktp" value="1" disabled="true"  readOnly="true"
          			valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP"/>
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">股东代码:</td> 
				<td colspan="1" align="left"><input class="nui-textbox" name="master.shhdcd"  readOnly="true"/></td>
				<td class="form_label" align="right">股东名称:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.shhdna"  readOnly="true"/></td>
			</tr>
			<tr>
				<td class="form_label"  align="right">持股数:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.stcknm"  readOnly="true"/></td>
				<td class="form_label"  align="right">入股日期:</td>
				<td colspan="1" align="left"><input class="nui-textbox" name="master.entcdt"  readOnly="true"/></td></td>
			</tr>
			<tr>
				<td class="form_label"  align="right">入股方式:</td>
				<td colspan="1" align="left">
					<input class="nui-dictcombobox nui-form-input" name="master.tranty"  readOnly="true"
          			valueField="dictID" textField="dictName" dictTypeId="FI_TRANTY"/>
				</td>
				<td class="form_label"  align="right">股权证编号:</td>
				<td colspan="1" align="left">
					<input name="master.dcmtno" class="nui-buttonedit" onbuttonclick="onButtonEditDcmtno" required="true"/>
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
		var form = new nui.Form("#editForm1");
		
		
		//标准方法接口定义
        function load(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = nui.clone(data);
                data = {eqbkno:data.recode.eqbkno};
                $.ajax({
                    url: "com.sunline.fdeqb.eqddcmtbrchbiz.getEqdDcmtDetlPrintObj.biz.ext" ,
                    data: data,
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o);
                        form.setChanged(false);
						nui.getbyName("master.prcscd").setValue("eqp_reg_dcmt");
                        //onDeptChanged();
                    }
                });
            }
        }
		
		function onButtonEditDcmtno(e) {
			var btnEdit = this;
		    nui.open({
			    url: bootPath+"/fdeqb/eqddcmtdetls_select.jsp?dcmtst=0",
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
			 			}
			        }
			    }
			});
		}
		
		function onSave(){
			//提交表单数据
			var data = form.getData();      //获取表单多个控件的数据
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
                        window.close();
                    }else{
                        nui.alert("处理失败:"+returnJson.exception.message);
                    }
			    }
			});
		}
		function onReset(){
			var form = new nui.Form("#editForm1");//将普通form转为nui的form
            form.reset();
		}
		
	</script>
</body>
</html>