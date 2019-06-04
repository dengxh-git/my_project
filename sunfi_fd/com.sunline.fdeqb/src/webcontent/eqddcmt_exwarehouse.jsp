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
<title>股权证出库</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<fieldset style="width:600px;border:solid 1px #aaa;position:relative;">
	<legend >基本信息</legend>
	<div id="editForm1" style="padding-top: 5px;" align="center">
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <input class='nui-hidden' name="master.prcscd" value="eqd_dcmt_rec">
        <!-- hidden域 -->
        <input class="nui-hidden" name="master.brchcd" />
        <input class="nui-hidden" name="master.usercd" />
        <input class="nui-hidden" name="master.bsnssq" />
        <input class="nui-hidden" name="master.bsnsdt" />
        <input class="nui-hidden" name="master.wkflid" value=""/>
        <input class="nui-hidden" name="master.transt" />
        <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
            <tr>
                <td class="form_label" align="right">凭证序号：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.dcmtid" readonly="true"/>
                </td>
                <td class="form_label" align="right">编码前缀：</td>
                <td colspan="1" align="left">
                	<input class="nui-dictcombobox nui-form-input" name="master.prefno" value="F"  readonly="true"
      				valueField="dictID" textField="dictName" dictTypeId="FI_PREFNO"/>
                </td>
            </tr>
            <tr>
                <td class="form_label" align="right">起始号码：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.initno" readonly="true"/>
                </td>
                <td class="form_label" align="right">结束号码：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.finlno" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label" align="right">份数：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.tranam" readonly="true"/>
                </td>
                <td class="form_label" align="right">登记日期：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.regtdt" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label" align="right">凭证所属机构：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.brchcd" readonly="true"/>
                </td>
                <td class="form_label" align="right">备注：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.remark" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label" align="right">领取人：</td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="master.recver" required="true"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">               
        	<a class="nui-button" onclick="onOk()">保存</a>
            <span style="display:inline-block;width:25px;"></span>
            <a class="nui-button" onclick="onCancel()">取消</a>       
        </div>
    </div>
    </fieldset>
	<script type="text/javascript">
		nui.parse();
		var bootPath = "<%=request.getContextPath() %>";
		var form = new nui.Form("#editForm1");
		
		//页面间传输json数据
        function setFormData(data){
            //跨页面传递的数据对象，克隆后才可以安全使用
            var infos = nui.clone(data);
            //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
            nui.getbyName("pageType").setValue(infos.pageType);
            //如果是点击编辑类型页面
            if (infos.pageType == "edit") {
                var json = infos.record;
                json.master.prcscd = "eqd_dcmt_rec";
                form.setData(json);
            }
        }
		
		function saveData(){
			//提交表单数据
			var data = form.getData();      //获取表单多个控件的数据
			var json = nui.encode(data);   //序列化成JSON
			nui.ajax({
				url: "com.sunline.sunfi.sunfi_cm.busbiz.transferProcedure.biz.ext",
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