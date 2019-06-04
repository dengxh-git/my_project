<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2019-01-14 09:54:52
- Description:
    --%>
    <head>
        <title>
            WfConfigure录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>       
<div id="dataform1" style="padding-top:5px;">
                <!-- hidden域 -->
                <input class="nui-hidden" name="wfconfigure.wfConfigureDetls" id="wfconfigure.wfConfigureDetls"/>
                <table class="nui-form-table">
                    <tr><td class="nui-form-table-text">
                            法人名称:
                        </td>
                        <td colspan="1">                          
                           <input class="nui-buttonedit" style="width: 220px;" required="true" name="wfconfigure.brchcd" onbuttonclick="selectBrch" allowInput="false" textName="wfconfigure.brchna"/>
                        </td>                   
                        <td class="nui-form-table-text">
                           流程名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="wfconfigure.wfname" required="true"/>
                        </td>
                    </tr>
                    <tr>
                       <td class="nui-form-table-text">
                           是否使用:
                        </td>
                        <td colspan="1">
                            <input class="nui-dictcombobox" name="wfconfigure.usedtp" dictTypeId="FI_YESORNO" value="1" valueField="dictID" textField="dictName"/>
                        </td>
                        <td class="nui-form-table-text">
                            流程路径:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="wfconfigure.wfpath" style="width: 300px;" required="true"/>
                        </td>                  
             
                    </tr>
                </table>       
        <!-- 从表的修改 -->
        <div style="margin:0px 2px 0px 2px;" >                         
                    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                        <table style="width:100%;">
                            <tr>                               
                                <td >
                                    <a class="nui-button"  onclick="gridAddRow('grid_0')"  plain="true" tooltip="增加">
                                       	        新增
                                    </a>
                	                <a class="nui-button"  onclick="gridRemoveRow('grid_0')"  plain="true" tooltip="删除">
                                        	删除
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="grid_0" class="nui-datagrid" style="width:100%;height:390px;" showPager="false"
                    allowCellValid="true" oncellvalidation="onCellValidation" sortMode="client" allowCellEdit="true" allowCellSelect="true" multiSelect="true" editNextOnEnterKey="true" >
                        <div property="columns">
                            <div type="checkcolumn">
                            </div>
                            <div field="fldcid" allowSort="true" align="left" headerAlign="center" width="">
                               流程明细代码                              
                            </div>
                            <div field="wfnode" allowSort="true" align="left" headerAlign="center" width="">
                               流程节点                              
                            </div>
                            <div field="wfrole" displayField="rolena" vtype="required" allowSort="true" align="left" headerAlign="center" width="">
                               流程角色
                                <input class="nui-buttonedit" onbuttonclick="selectRole"  property="editor" visible="true"/>
                            </div>
                        </div>
                    </div>                   
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
</div>
        <script type="text/javascript">
            nui.parse();
            var form = new nui.Form("#dataform1");
            var grid = nui.get("grid_0");     
            form.setChanged(false);

            function onOk(){
                saveData();
            }

            function gridAddRow(datagrid){                             
                var i=1;
                var row  = grid.getData();
                if(row.length !=0){
                  i=row.length+1;
                };
                grid.addRow({fldcid:i,wfnode:"流程节点"+i});
            }

            function gridRemoveRow(datagrid) {              
                var rows = grid.getSelecteds();
                if (rows.length > 0) {
                    grid.removeRows(rows, true);
                }
            }

            function setGridData(datagrid,dataid){
                var grid_data = grid.getChanges();
                nui.get(dataid).setValue(grid_data);
            }

            function saveData(){
                form.validate();
                grid.validate();
                if(form.isValid()==false || grid.isValid()==false) {
                var error = grid.getCellErrors()[0];
                nui.alert(error.errorText);
                grid.beginEditCell(error.record, error.column);
                return;
                }; 
                if(grid.getData().length==0){
                alert("请录入明细","提示");
                return;
                };
                setGridData("grid_0","wfconfigure.wfConfigureDetls");
                var data = form.getData(false,true);
                var json = nui.encode(data);

                $.ajax({
                    url:"com.sunline.sunfi.sunfi_wf.wfconfigurebiz.addWfConfigure.biz.ext",
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

                    function onReset(){
                        form.reset();
                        form.setChanged(false);
                    }

                    function onCancel(){
                        CloseWindow("cancel");
                    }

                    function CloseWindow(action){

                        if(action=="close"){

                            }else if(window.CloseOwnerWindow)
                            return window.CloseOwnerWindow(action);
                            else
                            return window.close();
                        }
                    //选择法人
                    function selectBrch(){
                    var btnEdit = this;
                    nui.open({
				            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select_by_not_power.jsp?brchtp=0000",
				            showMaxButton: false,
				            title: "选择法人",
				            width: 950,
				            height: 600,
				            allowResize:false,
				            ondestroy: function(action){
				                if (action == "ok") {
				                    var iframe = this.getIFrameEl();
			                        var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                        if (data) {
				                        btnEdit.setValue(data.brchcd);
				                        btnEdit.setText(data.brchna);				                       
			                       }
				                }else{
			                            btnEdit.setValue("");
				                        btnEdit.setText("");
			                       }
				            }
				        });
                    }
                    //选择角色    
                    function selectRole(){
	                    nui.open({
				            url: "<%=request.getContextPath() %>/sunfi_cm/user/capRoleSelect.jsp",
				            showMaxButton: false,
				            title: "选择角色",
				            width: 950,
				            height: 600,
				            allowResize:false,
				            ondestroy: function(action){
				                if (action == "ok") {
				                    var iframe = this.getIFrameEl();
				                    var data = iframe.contentWindow.getData();
				                    data = nui.clone(data);
				                    grid.cancelEdit();
				                    var row = grid.getSelected();
				                    grid.updateRow(row,{
				                    wfrole:data.roleId,
				                    rolena:data.roleName
				                    });
				                }
				            }
				        });    
                    } 
				function onCellValidation(e) {
		            if (e.field == "wfrole") {		              
		                if (e.value =="" || e.value ==undefined) {	
		                    e.isValid = false;
		                    e.errorText = "流程角色不能为空";
		                }
		            }
	             }     
                    </script>
                </body>
            </html>
