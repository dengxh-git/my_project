<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@include file="/common.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-11-29 18:04:15
  - Description:
-->
<head>
<title>科目编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="form1">
 <table class="nui-form-table">
                     
                <tr>
                    <td class="nui-form-table-text">
                        科目代码:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comitem.itemcd" required="true" enabled="enabled"/>
                    </td>
                    <td class="nui-form-table-text">
                        上级代码:
                    </td>
                    <td>
                        <input class="nui-hidden" class="nui-hidden" id="oldsprrcd" name="comitem.oldsprrcd"/>
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectItem" allowInput="false" name="comitem.sprrcd" textName="comitem.sprrna"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        科目名称:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comitem.itemna" required="true"/>
                    </td>
                    <td class="nui-form-table-text">
                        科目类型:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_ITEMTP" name="comitem.itemtp" required="true" value="1"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        是否允许通用记账:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_YESORNO" name="comitem.itempr" required="true" value="1"/>
                    </td>
                    <td class="nui-form-table-text">
                        是否已使用:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_YESORNO" name="comitem.usedtp" required="true" value="1"/>
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
    	var form = new nui.Form("#form1");//将普通form转为nui的form
	    	  function saveData(){
	                form.validate();
	                if(form.isValid()==false) return;
	                var data = form.getData(false,true);
	                var json = nui.encode(data);
	                $.ajax({
	                    url:"com.sunline.sunfi.sunfi_cm.comitembiz.updateComItem.biz.ext",
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
                    function setData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                      data = nui.clone(data);
                        //如果是点击编辑类型页面              
                   	var json = nui.encode({comitem:data});
                   	
                    $.ajax({
                    url: "com.sunline.sunfi.sunfi_cm.comitembiz.getComItem.biz.ext",
                    type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o); 
                        var oldsprrcd = nui.get("oldsprrcd"); 
                        oldsprrcd.setValue(o.comitem.sprrcd);                                                                		               
                        form.setChanged(false);
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
    	
    	          //选择上级科目
			       function selectItem(e) {
			        var btnEdit = this;
			        nui.open({
			            url: "<%=request.getContextPath() %>/sunfi_cm/item/comItem_select.jsp",
			            showMaxButton: false,
			            title: "选择科目",
			            width: 950,
			            height: 580,
			            allowResize:false,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                    data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.itemcd);
			                        btnEdit.setText(data.itemna);
			                    }
			                }if (action == "cancel" ||action == "close") {
			                        btnEdit.setValue(null);
			                        btnEdit.setText(null);
			                }
			            }
			        });            
			    }
    </script>
</body>
</html>