<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-14 11:37:32
  - Description:
-->
<head>
<title>法人股东</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<fieldset style="width:700px;border:solid 1px #aaa;position:relative;">
		<div id="editForm1" style="padding-top: 5px;" align="center">
			<!--  hidden域 -->
			<div id="hiddenForm"></div>
			<!-- 流程id -->
			<input class='nui-hidden' name="master.prcscd" value="eqp_shhd_add">
			<input class='nui-hidden' name="master.shhdcd" >
			<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
				<tr>
					<td class="form_label" align="right">股东名称:</td>
					<td colspan="1" align="left"><input name="master.shhdna" class="nui-textbox" required="true"/></td>
					<td class="form_label" align="right">股东代码:</td>
					<td colspan="1" align="left">
					 	<input id="lookup1" name="master.grupcd" class="nui-lookup"  
					 		textField="grupna" valueField="grupcd" popupWidth="auto"
							popup="#gridPanel" grid="#datagrid1" multiSelect="true" />
					</td>
				</tr>
				<tr>
					<td class="form_label"  align="right">股东前缀:</td>
					<td colspan="1" align="left">
						<input class="nui-textbox" name="master.shhpfx"  required="true"/>
	          		</td>
					<td class="form_label"  align="right">是否员工:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.empyst"  
	          			valueField="dictID" textField="dictName" dictTypeId="AFP_SFMJ"/>
	          		</td>
				</tr>
				<tr>
					<td class="form_label" align="right">股东类型:</td> 
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.shhdtp" disabled="true"  
	          			valueField="dictID" textField="dictName" dictTypeId="FI_SHHDTP"/>
	          		</td>
					<td class="form_label" align="right">所属机构:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.brchcd"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">单位性质:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.unittp" disabled="true"  
	          			valueField="dictID" textField="dictName" dictTypeId="FI_UNITTP"/>
	          		</td>
					<td class="form_label"  align="right">行业:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.indtry"  
	          			valueField="dictID" textField="dictName" dictTypeId="FI_INDTRY"/>
	          		</td>
				</tr>
				<tr>
					<td class="form_label"  align="right">法人代表:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.atfcna"  /></td>
					<td class="form_label"  align="right">统一社会信用代码:</td>
					<td colspan="1" align="left">
						<input class="nui-textbox" name="master.ognsno"  />
	          		</td>
				</tr>
				<tr>
					<td class="form_label"  align="right">性别:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.gender"  
	          			valueField="dictID" textField="dictName" dictTypeId="FI_GENDER"/>
					</td>
					<td class="form_label"  align="right">联系电话:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.telpno"  required="true"/></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">证件类型:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.idcdtp"  value="1"
	          			valueField="dictID" textField="dictName" dictTypeId="FI_IDCDTP" onvaluechanged="onIdcdtpChange"/>
	          		</td>
	          		<td class="form_label"  align="right">证件号码:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.idcard"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">本行账号:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.bkacno"  required="true"/></td>
	          		<td class="form_label"  align="right">账户户名:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.acctna"  required="true"/></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">客户号:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.custno"  /></td>
	          		<td class="form_label"  align="right">地址:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.addres"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">申请书文号:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.aplyno"  /></td>
	          		<td class="form_label"  align="right">股东资格审查机构:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.chckbr"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">批准文号:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.audtno"  /></td>
	          		<td class="form_label"  align="right">批准时间:</td>
					<td colspan="1" align="left"><input name="master.audtdt" class="nui-datepicker" format="yyyyMMdd" value="new Date();"/></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">高管兼职情况:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.plrzcs"  /></td>
	          		<td class="form_label"  align="right">股东之间互相参股情况:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.sharcs"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">股东被处罚情况:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.pnshcs"  /></td>
	          		<td class="form_label"  align="right">对其他金融机构投资情况:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.invtcs"  /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">是否欠款欠息:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.defi02" 
	          			valueField="dictID" textField="dictName" dictTypeId="FI_ISDEBT"/>
	          		</td>
					<td class="form_label"  align="right">是否表决:</td>
					<td colspan="1" align="left">
						<input class="nui-dictcombobox nui-form-input" name="master.vtrtst"  
	          			valueField="dictID" textField="dictName" dictTypeId="AFP_SFMJ"/>
	          		</td>
				</tr>
				<tr>
					<td class="form_label"  align="right">备注:</td>
					<td colspan="1" align="left"><input class="nui-textbox" name="master.remark" /></td>
				</tr>
			</table>
		</div>
		<div style="text-align:center;padding:10px;">               
		    <a class="mini-button" onclick="onSave" style="width:60px;margin-right:20px;">保存</a>       
		    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
		</div> 
	</fieldset>
	<div id="gridPanel" class="nui-panel" title="header" iconCls="icon-add" style="width:400px;height:250px;" 
	showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0">
		<!-- <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">
			<div id="form1" style="float:left;padding-bottom:2px;">
				<span>股东组代码：</span>
                <input class="nui-textbox" name="criteria/_expr[1]/grupcd" onenter="onSearchClick"/>
                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
				<span>股东组名称：</span>
				<input class="nui-textbox" name="criteria/_expr[2]/grupna" onenter="onSearchClick"/>
				<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
				<a class="nui-button" onclick="onSearchClick">查询</a>
				<a class="nui-button" onclick="onClearClick">清除</a>
			</div>
		</div> -->
		<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" borderStyle="border:0" showPageSize="false"
			showPageIndex="false" dataField="eqpgrups" url="com.sunline.fdeqb.eqpshhbiz.queryEqpGrup.biz.ext">
			<div property="columns" >
				<div type="checkcolumn" ></div>
				<div field="grupcd" width="100" headerAlign="center" allowSort="true">股东组代码</div>
				<div field="grupna" width="100" headerAlign="center" allowSort="true">股东组名称</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
		var editForm = new nui.Form("#editForm1");
		var obj = nui.getParams();
		var shhdcd = obj.shhdcd;
		var action = obj.action;
		var iframedata = {action:action, shhdcd:shhdcd};
		SetData(nui.decode(iframedata));
		
		/* var form = new nui.Form("#form1");
		var data = form.getData(true, false);
		var sdata = nui.encode(data);		 */
		grid.load();
		
		function onSave(){
    		//提交表单数据
			var data = editForm.getData();      //获取表单多个控件的数据
			data.master.audtdt = nui.getbyName("master.audtdt").getFormValue(); //日期需要特殊处理
			var shhpfx = nui.getbyName("master.shhpfx").getValue();
			var patt1 = /^GJ\d{2}/;
			var patt2 = /^FR\d{2}/;
			if(!patt1.test(shhpfx)&&!patt2.test(shhpfx)){
				nui.alert("输入股东前缀错误，格式为：GJ/FR+两位数字", "提示");
				return;
			}
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
                        CloseWindow("saveSuccess");
                    }else{
                        nui.alert("处理失败:"+returnJson.exception.message);
                    }
			    }
			});
    	}
    	
    	function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow){
            	return window.parent.CloseOwnerWindow(action);
            }else{
            	window.close();
            }
        }
    	
    	function onCancel(){
              CloseWindow("cancel");
         }   
    	
    	//标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                //data = nui.clone(data);
                $.ajax({
                    url: "com.sunline.fdeqb.eqpshhbiz.queryEqpShhDetlById.biz.ext" ,
                    data: data,
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        editForm.setData(o);
                        editForm.setChanged(false);
						nui.getbyName("master.prcscd").setValue("eqp_shdd_upp");
                        //onDeptChanged();
                    }
                });
            }
        }
        
        function onDeptChanged(e) {
            var deptCombo = nui.getbyName("dept_id");
            var positionCombo = nui.getbyName("position");
            var dept_id = deptCombo.getValue();

            positionCombo.load("../data/AjaxService.aspx?method=GetPositionsByDepartmenId&id=" + dept_id);
            positionCombo.setValue("");
        }
        
        function onIdcdtpChange(e){
        	var idcard = nui.getbyName("master.idcard");
        	var idcdtpCombo = nui.getbyName("master.idcdtp");
        	var idcdtp_id = idcdtpCombo.getValue();
        	if(idcdtp_id=="0"){
        		idcard.set({
	        		onvalidation:onIDCardsValidation
	        	});
        	}else{
        		idcard.set({
	        		onvalidation:""
	        	});
        	}
        	return 
        }
        
        function onIDCardsValidation(e) {
            if (e.isValid) {
                var pattern = /\d*/;
                if (e.value.length<15||e.value.length>18||pattern.test(e.value)== false) {
                    e.errorText = "必须输入15~18位数字";
                    e.isValid = false;
                }
            }
        }
        
    	
		
		function onSearchClick(e) {
			grid.load({
				grupcd:grupcd.value,
				grupna:grupna.value
			});
		}
		function onCloseClick(e) {
			var lookup2 = nui.get("lookup1");
			lookup2.hidePopup();
		}
		function onClearClick(e) {
			var lookup2 = nui.get("lookup1");
			lookup2.deselectAll();
		}
    </script>
</body>
</html>