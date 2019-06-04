<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-27 15:35:03
- Description:
    --%>
    <head>
        <title>
            会计科目管理
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />        
    </head>
    <body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="会计科目管理" visible="true" >   
            <div id="form1" align="center" class="nui-form" style="height: 10%;">                        
                <table id="table1" class="table" style="height:100%;">
                    <tr>
                        <td style="font-size: 12px;">
                            科目代码:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[1]/itemcd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;">
                            科目名称:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[2]/itemna"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;">
                            是否允许通用记账:
                        </td>
                        <td>
                            <input class="nui-dictcombobox" dictTypeId="FI_YESORNO" name="criteria/_expr[3]/itempr"  emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;">
                            科目类型:
                        </td>
                        <td>
                            <input class="nui-dictcombobox"   dictTypeId="FI_ITEMTP" name="criteria/_expr[4]/itemtp"  emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>          
        <div property="footer" align="center">
            <a class="nui-button" onclick="search()">
                查询
            </a>
            <a class="nui-button" onclick="reset()">
                重置
            </a>
        </div> 
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="add()">
                                增加
                            </a>
                            <a id="edit_btn" class="nui-button" onclick="edit()">
                                编辑
                            </a>
           <!--                  <a class="nui-button" iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>       -->                  
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="itemgrid" dataField="comitems" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comitembiz.queryComItems.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                    <div property="columns">
                        <div type="checkcolumn"></div>                       
                        <div field="itemcd" headerAlign="center" allowSort="true">科目代码 </div>
                        <div field="itemna" headerAlign="center" allowSort="true">科目名称</div>
                        <div field="sprrcd" headerAlign="center" allowSort="true">上级代码</div>
                        <div field="itemtp" headerAlign="center" allowSort="true" renderer="renderitemtype">科目类型 </div>
                        <div field="detltg" headerAlign="center" allowSort="true" renderer="renderitemdetl">是否末级 </div>
                        <div field="usedtp" headerAlign="center" allowSort="true" renderer="renderitemused">是否使用</div>                       
                    </div>
                </div>
            </div>
	</div>
</div>            
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("itemgrid");

            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);

            //新增
            function add() {
                nui.open({
                    url: "<%= request.getContextPath() %>/sunfi_cm/item/comItem_add.jsp",
                    title: "科目新增", width: 600, height: 230,
                    allowResize:false,                    
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
                        url: "<%= request.getContextPath() %>/sunfi_cm/item/comItem_edit.jsp",
                        title: "科目编辑",
                        width: 600,
                        height: 230,
                        allowResize:false,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = row;
                            //直接从页面获取，不用去后台获取
                            iframe.contentWindow.setData(data);
                            },
                            ondestroy: function (action) {
                                grid.reload();
                            }
                            });
                        } else {
                            nui.alert("请选中一条记录","提示");
                        }
                    }

                   /*  //删除
                    function remove(){
                        var rows = grid.getSelecteds();
                        if(rows.length > 0){
                            nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({comitems:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.comitembiz.deleteComItems.biz.ext",
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
                                } */

                                //重新刷新页面
                                function refresh(){
                                    var form = new  nui.Form("#form1");
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                    nui.get("edit_btn").enable();
                                }

                                //查询
                                function search() {
                                    var form = new nui.Form("#form1");
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                }

                                //重置查询条件
                                function reset(){
                                    var form = new nui.Form("#form1");//将普通form转为nui的form
                                    form.reset();
                                }

                                //enter键触发查询
                                function onKeyEnter(e) {
                                    search();
                                }

                                //当选择列时
                                function selectionChanged(){
                                    var rows = grid.getSelecteds();
                                    if(rows.length>1){
                                        nui.get("edit_btn").disable();
                                    }else{
                                        nui.get("edit_btn").enable();
                                    }
                                }
                                
                                 function renderitemtype(e) {
									return nui.getDictText("FI_ITEMTP",e.row.itemtp);
	                              }
	                             function renderitemused(e) {
									return nui.getDictText("FI_YESORNO",e.row.usedtp);
	                              }
	                             function renderitemdetl(e) {
									return nui.getDictText("FI_YESORNO",e.row.detltg);
	                              }                              
                            </script>
                        </body>
                    </html>
