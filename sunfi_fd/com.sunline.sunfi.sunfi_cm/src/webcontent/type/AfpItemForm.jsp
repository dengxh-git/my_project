<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<%--
- Author(s): kaifasishi147
- Date: 2019-01-02 10:19:39
- Description:
    --%>
    <head>
        <title>
            业务项目录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="afpitem.typecd"/>
            <table  class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        业务代码:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afpitem.typecd"/>
                    </td>
                    <td class="nui-form-table-text">
                        业务名称:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afpitem.typena"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        对应科目:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" id="afpitem.itemcd" name="afpitem.itemcd" textName="afpitem.itemna"
                        onbuttonclick="selectItem" allowinput="false"/>
                    </td>
                    <td class="nui-form-table-text">
                        报账类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="FI_EXPTP" name="afpitem.rpstcd"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        备注:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afpitem.market"/>
                    </td>
                    <td class="nui-form-table-text">
                        是否启用:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="FI_YESORNO" name="afpitem.isedit"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button"  onclick="onOk()">保存</a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a class="nui-button"  onclick="onCancel()">  取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            var bootPath = "<%=request.getContextPath() %>";

            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.sunline.sunfi.sunfi_cm.afpitembiz.addAfpItem.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.sunline.sunfi.sunfi_cm.afpitembiz.updateAfpItem.biz.ext";
                }
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

                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
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
                    function selectItem(){
                        var btnEdit = this;
                    	nui.open({
			            	url: bootPath + "/sunfi_cm/item/comItem_select.jsp?detltg="+1,
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
                </script>
            </body>
        </html>
