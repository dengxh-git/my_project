<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): chenc
- Date: 2019-03-30 11:35:20
- Description:
    --%>
<head>
    <title>
        Entity录入
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
</head>
    <body>
		<fieldset style="width:600px;border:solid 1px #aaa;position:relative;">
		<legend >基本信息</legend>
		<div id="editForm1" style="padding-top: 5px;" align="center">
	        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	        <input name="pageType" class="nui-hidden"/>
	        <input class="nui-hidden" name="master.prcscd" value="">
            <!-- hidden域 -->
            <input class="nui-hidden" name="master.brchcd" />
            <input class="nui-hidden" name="master.usercd" />
            <input class="nui-hidden" name="master.bsnssq" />
            <input class="nui-hidden" name="master.bsnsdt" />
            <input class="nui-hidden" name="master.wkflid" />
            <input class="nui-hidden" name="master.transt" />
             <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" align="right">凭证序号：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.dcmtid" readonly="true"/>
                    </td>
                    <td class="form_label" align="right">编码前缀：</td>
                    <td colspan="1" align="left">
                    	<input class="nui-dictcombobox nui-form-input" name="master.prefno" value="F" 
          				valueField="dictID" textField="dictName" dictTypeId="FI_PREFNO"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">起始号码：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.initno" required="true"/>
                    </td>
                    <td class="form_label" align="right">结束号码：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.finlno" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">份数：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.tranam" required="true"/>
                    </td>
                    <td class="form_label" align="right">登记日期：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.regtdt" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">凭证所属机构：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.brchcd" readonly="true" required="true"/>
                    </td>
                    <td class="form_label" align="right">备注：</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="master.remark"/>
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
            var form = new nui.Form("#editForm1");

            function saveData(){
                form.setChanged(false);
                form.validate();
                if(form.isValid()==false) return;
				var initno = nui.getbyName("master.initno").getValue();
				var finlno = nui.getbyName("master.finlno").getValue();
				 //var num = finlno - initno;
				var tranam = nui.getbyName("master.tranam").getValue();
				if((finlno - initno+1)!=tranam ){
					nui.alert("份数应等于结束号码与起始号码之差加1", "提示" );
					return false;
				}
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:"com.sunline.sunfi.sunfi_cm.busbiz.transferProcedure.biz.ext",
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

            //页面间传输json数据
            function setFormData(data){
                //跨页面传递的数据对象，克隆后才可以安全使用
                var infos = nui.clone(data);
                //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                nui.getbyName("pageType").setValue(infos.pageType);
                //如果是点击编辑类型页面
                if (infos.pageType == "edit") {
                    var json = infos.record;
                    json.master.prcscd = "eqd_dcmt_upd";
                    form.setData(json);
                    form.setChanged(false);
                }
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
