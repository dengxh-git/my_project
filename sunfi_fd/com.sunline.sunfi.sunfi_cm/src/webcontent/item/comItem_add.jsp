<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-27 15:35:04
- Description:
    --%>
    <head>
        <title>
            会计科目新增
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>        
        <div id="dataform1" style="padding-top:5px;">
           <input class="nui-hidden" name="comitem.stacid" value="1"/>           
            <table class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        科目代码:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comitem.itemcd" required="true" onvalidation="codevalidation"/>
                    </td>
                    <td class="nui-form-table-text">
                        上级代码:
                    </td>
                    <td>
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectItem" allowInput="false" name="comitem.sprrcd" textName="itemna"/>
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

            function saveData(){

                var form = new nui.Form("#dataform1");                         
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:"com.sunline.sunfi.sunfi_cm.comitembiz.addComItem.biz.ext",
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
				  /* 是否数字 */
			        function isNumber(v) {
			            var re = new RegExp("^[0-9]*$");
			            if (re.test(v)) return true;
			            return false;
			        }
			         //校验科目编码
			           function codevalidation(e){
			        	if(e.isValid){
				        	 if (isNumber(e.value) == false) {
			                     e.errorText = "必须输入数字";
			                     e.isValid = false;
			                     return;
	                			}
					          if(e.value.length !=4 && e.value.length !=6 && e.value.length !=8){
						          e.errorText = "科目代码必须为4、6、8位";
							      e.isValid = false;
							      return;
					          }	
			        	    var data = {itemcd:e.value};
			        		var json = nui.encode({template:data});
				        	$.ajax({
			                    url: "com.sunline.sunfi.sunfi_cm.comitembiz.validateItem.biz.ext",
			                    type: 'POST',
				                data: json,
				                cache: false,
				                contentType:'text/json',
			                    cache: false,
			                    async:false,
			                    success: function (text) {
			                       var o = nui.decode(text);
			                        if(o.data == "1"){
			                        	e.errorText = "科目代码不唯一，请请重新填写";
				        				e.isValid = false;
			                        }
			                    }
				           });
			        	}
			        }
                    
                </script>
            </body>
        </html>
