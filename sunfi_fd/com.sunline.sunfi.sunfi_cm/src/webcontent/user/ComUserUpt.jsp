<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): kaifasishi147
  - Date: 2018-12-17 10:28:44
  - Description:
-->
<head>
<title>用户信息修改</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />  
</head>
 <body>
        <div id="dataform1" style="padding-top:5px;">
            <table  class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        用户代码:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" name="comuser.usercd"  textName="comuser.usercd"
                        onbuttonclick="selectUser" allowInput="false" />
                    </td>
                    <td class="nui-form-table-text">
                        用户名称:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" id="comuser.userna" name="comuser.userna" allowinput="false" />
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        所属机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" id="comuser.brchcd" name="comuser.brchcd" textName="comuser.brchna" 
                        onbuttonclick="selectBrchcd" allowInput="false" />
                    </td>
                    <td class="nui-form-table-text">
                        所属责任中心:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" id="comuser.dutycd" name="comuser.dutycd" textName="comuser.dutyna" 
                        onbuttonclick="selectDutycd" allowInput="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="nui-form-table-text">
                        联系电话:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" id="comuser.phone" name="comuser.phone" vtype="int" required="true" />
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
                            <a class="nui-button"  onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            var form = new nui.Form("dataform1");
            function loadData(data){
            	data = nui.clone(data);
                form.setData({comuser:data});
            }

            function saveData(){
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.sunline.sunfi.sunfi_cm.comuserbiz.uptComUser.biz.ext";
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);

                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功","系统提示");
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    CloseWindow("saveFailed");
                                }
                                });
                            }
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
                    var bootPath = "<%=request.getContextPath() %>";
                     //查询OA用户
			       function selectUser() {
			        var btnEdit = this;
			        var userna = nui.get("comuser.userna");
			        nui.open({
			            url: bootPath + "/sunfi_cm/user/OrgEmployeeSelect.jsp",
			            showMaxButton: false,
			            title: "选择用户",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                        
			                    if (data) {
			                        btnEdit.setValue(data.userid);
			                        btnEdit.setText(data.userid);
			                        userna.setValue(data.empname);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                    userna.setValue(null);
			                }
			            }
			        });            
			       }
			         //查询机构信息
			       function selectBrchcd() {
			        var btnEdit = this;
			        nui.get("comuser.dutycd").setValue(null);
			        nui.get("comuser.dutycd").setText(null);
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
			          //查询责任中心信息
			       function selectDutycd() {
			        var btnEdit = this;
			        var brchcd = nui.get("comuser.brchcd").getValue();
			        
			        if(!brchcd){
			        	nui.alert("请先选择机构","提示");
			        	return;
			        }
			        nui.open({
			            url: bootPath + "/sunfi_cm/brch/combrch_select.jsp?brchtp=0001&sprrcd="+brchcd,
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
        </script>
    </body>
</html>