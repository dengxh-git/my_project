<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-29 10:24:01
- Description:
    --%>
    <head>
        <title>
            账套管理
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="comstac.stacid"/>
            <table class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        账套代码:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comstac.stacid" id="comstac.stacid"/>
                    </td>
                    <td class="nui-form-table-text">
                        账套名称:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comstac.stacna"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        机构名称:
                    </td>
                    <td>
                        <input class="nui-textbox" name="comstac.brchna"/>
                    </td>
                    <td class="nui-form-table-text">
                        币种:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_CTCYCD" name="comstac.crcycd"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        账务日期:
                    </td>
                    <td>
                        <input class="nui-datepicker" name="comstac.acctdt"/>
                    </td>
                    <td class="nui-form-table-text">
                        总帐日期:
                    </td>
                    <td>
                        <input class="nui-datepicker" name="comstac.glisdt"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        业务日期:
                    </td>
                    <td colspan="3">
                        <input class="nui-datepicker" name="comstac.bsnsdt"/>
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
                form.setChanged(false);
                //保存
                var urlStr = "com.sunline.sunfi.sunfi_cm.comstacbiz.addComStac.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.sunline.sunfi.sunfi_cm.comstacbiz.updateComStac.biz.ext";
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
                            nui.get("comstac.stacid").disable();
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
