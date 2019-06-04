<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            业务项目查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body> 
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="业务项目管理" visible="true" >           
            <div id="typeForm" class="nui-form" align="center" style="height:10%">
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.sunline.sunfi.sunfi_cm.type.afpItems">
                <!-- 排序字段 -->
                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="typecd">
                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td style="font-size: 12px;">
                            业务代码:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/typecd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">
                            业务名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[2]/typena"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">
                            科目代码:
                        </td>
                        <td colspan="1">
                            <input class="nui-buttonedit searchbox" name="criteria/_expr[3]/itemcd" onbuttonclick="selectItem" allowinput="false"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">
                            报账类型:
                        </td>
                        <td colspan="1">
                            <input class="nui-dictcombobox" dictTypeId="FI_EXPTP" name="criteria/_expr[4]/rpstcd"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;">
                            是否启用:
                        </td>
                        <td colspan="1">
                            <input class="nui-dictcombobox" dictTypeId="FI_YESORNO" name="criteria/_expr[5]/isedit"/>
                            <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>    
        <!--footer-->
        <div property="footer" align="center">
            <a class="nui-button" onclick="search()">查询</a>
            <a class="nui-button" onclick="reset()"> 重置</a>
        </div>      
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button"  onclick="add()">
                                增加
                            </a>
                            <a id="update" class="nui-button"  onclick="edit()">
                                编辑
                            </a>
                            <a class="nui-button"  onclick="remove()">
                                删除
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="datagrid1" dataField="afpitems" class="nui-datagrid" style="width:100%;height:100%;" url="com.sunline.sunfi.sunfi_cm.afpitembiz.queryAfpItems.biz.ext" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="typecd" headerAlign="center" allowSort="true" > 业务代码</div>
                        <div field="typena" headerAlign="center" allowSort="true" > 业务名称</div>
                        <div field="itemcd" headerAlign="center" allowSort="true" > 对应科目</div>
                        <div field="itemna" headerAlign="center" allowSort="true" > 对应科目名称</div>
                        <div field="rpstcd" headerAlign="center" allowSort="true" renderer="renderExptp"> 报账类型</div>
                        <div field="market" headerAlign="center" allowSort="true" > 说明        </div>
                        <div field="isedit" headerAlign="center" allowSort="true" renderer="renderIsedit"> 是否启用</div>
                    </div>
                </div>
            </div>
        </div>
   </div>
	<script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
            var bootPath = "<%=request.getContextPath() %>";
            var formData = new nui.Form("#typeForm").getData(false,false);
            grid.load(formData);

            //新增
            function add() {
                nui.open({
                    url: bootPath + "/sunfi_cm/type/AfpItemForm.jsp",
                    title: "新增业务项目", width: 600, height: 200,
                    allowResize:false,
                    onload: function () {//弹出页面加载完成
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"add"};//传入页面的json数据
                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                    grid.reload();
                }
                });
            }

            //编辑
            function edit() {
                var row = grid.getSelected();
                if (row) {
                    nui.open({
                        url: bootPath+"/sunfi_cm/type/AfpItemForm.jsp",
                        title: "编辑数据",
                        width: 600,
                        height: 200,
                        allowResize:false,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{afpitem:row}};
                            //直接从页面获取，不用去后台获取
                            iframe.contentWindow.setFormData(data);
                            },
                            ondestroy: function (action) {
                                grid.reload();
                            }
                            });
                        } else {
                            nui.alert("请选中一条记录","提示");
                        }
                    }

                    //删除
                    function remove(){
                        var rows = grid.getSelecteds();
                        if(rows.length > 0){
                            nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({afpitems:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.afpitembiz.deleteAfpItems.biz.ext",
                                        type:'POST',
                                        data:json,
                                        cache: false,
                                        contentType:'text/json',
                                        success:function(text){
                                            var returnJson = nui.decode(text);
                                            if(returnJson.exception == null){
                                                grid.reload();
                                                nui.alert("删除成功", "系统提示", function(action){
                                                    });
                                                }else{
                                                    grid.unmask();
                                                    nui.alert("删除失败", "系统提示");
                                                }
                                            }
                                            });
                                        }
                                        });
                                    }else{
                                        nui.alert("请选中一条记录！");
                                    }
                                }

                                //重新刷新页面
                                function refresh(){
                                    var form = new  nui.Form("#typeForm");
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                    nui.get("update").enable();
                                }

                                //查询
                                function search() {
                                    var form = new nui.Form("#typeForm");
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                }

                                //重置查询条件
                                function reset(){
                                    var form = new nui.Form("#typeForm");//将普通form转为nui的form
                                    form.reset();
                                }

                                //enter键触发查询
                                function onKeyEnter(e) {
                                    search();
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

                                //当选择列时
                                function selectionChanged(){
                                    var rows = grid.getSelecteds();
                                    if(rows.length>1){
                                        nui.get("update").disable();
                                    }else{
                                        nui.get("update").enable();
                                    }
                                }
                                
                                function renderExptp(e){
	                            	return nui.getDictText("FI_EXPTP",e.row.rpstcd);
	                            }
	                            function renderIsedit(e){
	                            	return nui.getDictText("FI_YESORNO",e.row.isedit);
	                            }
        </script>
    </body>
</html>
