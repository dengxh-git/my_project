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
<title>股东组</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
<fieldset style="width:550px;border:solid 1px #aaa;position:relative;">
     <legend>股东组信息</legend>
	<div id="editForm1" style="padding-top: 5px;" align="center">
		<!--  hidden域 -->
		<div id="hiddenForm"></div>
		<!-- 流程id -->
		<input class='nui-hidden' name="eqpgrup.grupcd" >
		<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
			<tr>
				<td class="form_label" align="right">上级股东组:</td>
				<td colspan="1" align="left">
		         	<input name="eqpgrup.sprrcd" class="nui-textbox" />
		        </td>
				<td class="form_label" align="right">股东组名称:</td>
				<td colspan="1" align="left">
				 	<input class="nui-textbox" name="eqpgrup.grupna"/></td>
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">是否末级:</td> 
				<td colspan="1" align="left"><input class="nui-dictcombobox nui-form-input" name="eqpgrup.detltg" value="1" 
          			valueField="dictID" textField="dictName" dictTypeId="AFP_SFMJ"/>
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
		
		function onSave(){
			//提交表单数据
			var data = form.getData();      //获取表单多个控件的数据
			var json = nui.encode(data);   //序列化成JSON
			nui.ajax({
				url: "com.sunline.fdeqb.eqpshhbiz.updateEqpGrupObj.biz.ext",
				type: "post",
				contentType: "text/json",
				data:json ,
				success: function (text) {
			        alert("提交成功，返回结果:" + nui.encode(text));
			    }
			});
		}
		function onReset(){
			var form = new nui.Form("#editForm1");//将普通form转为nui的form
            form.reset();
		}
		
		//标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                //data = nui.clone(data);
                $.ajax({
                    url: "com.sunline.fdeqb.eqpshhbiz.queryEqpGrupById.biz.ext" ,
                    data: data,
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o);
                        form.setChanged(false);
                    }
                });
            }
        }
		
	</script>
</body>
</html>