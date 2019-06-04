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
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="账套管理" visible="true" >     
            <div id="form1" class="nui-form" align="center" style="height:10%;">
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.sunline.sunfi.sunfi_cm.stac.ComStac">
                <!-- 排序字段 -->
                <table id="table1" class="table" style="height:100%;">
                    <tr>
                        <td style="font-size: 12px;">
                            账套名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/stacna"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">
                            业务日期:
                        </td>
                        <td colspan="1">
                            <input class="nui-datepicker" name="criteria/_expr[2]/bsnsdt"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>
        <!--footer-->
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
               <!--              <a class="nui-button" iconCls="icon-add" onclick="add()">
                                增加
                            </a> -->
                            <a id="update" class="nui-button"  onclick="edit()">
                                编辑
                            </a>
        <!--                     <a class="nui-button" iconCls="icon-remove" onclick="remove()">
                                删除
                            </a> -->
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="stacgrid" dataField="comstacs" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comstacbiz.queryComStacs.biz.ext" pageSize="10" showPageInfo="true"
                 multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="stacid" headerAlign="center" allowSort="true" visible="false"> 账套代码 </div>
                        <div field="stacna" headerAlign="center" allowSort="true" >账套名称</div>
                        <div field="brchna" headerAlign="center" allowSort="true" >机构名称</div>
                        <div field="crcycd" headerAlign="center" renderer="renderCrcyDic" allowSort="true" >币种</div>
                        <div field="bsnsdt" headerAlign="center" allowSort="true" >业务日期</div>
                        <div field="acctdt" headerAlign="center" allowSort="true" >账务日期</div>
                        <div field="glisdt" headerAlign="center" allowSort="true" >总帐日期</div>
                    </div>
                </div>
            </div>
       </div>
</div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("stacgrid");

            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);

           <%--  //新增
            function add() {
                nui.open({
                    url: "<%= request.getContextPath() %>/sunfi_cm/stac/ComStacForm.jsp",
                    title: "新增记录", width: 600, height: 300,
                    onload: function () {//弹出页面加载完成
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"add"};//传入页面的json数据
                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                    grid.reload();
                }
                });
            } --%>

            //编辑
            function edit() {
                var row = grid.getSelected();
                if (row) {
                    nui.open({
                        url: "<%= request.getContextPath() %>/sunfi_cm/stac/ComStacForm.jsp",
                        title: "编辑数据",
                        width: 600,
                        height: 240,
                        allowResize: false,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{comstac:row}};
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

                  /*   //删除
                    function remove(){
                        var rows = grid.getSelecteds();
                        if(rows.length > 0){
                            nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({comstacs:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_cm.comstacbiz.deleteComStacs.biz.ext",
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
                                    nui.get("update").enable();
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
                                        nui.get("update").disable();
                                    }else{
                                        nui.get("update").enable();
                                    }
                                }
                                 function renderCrcyDic(e) {
									return nui.getDictText("FI_CTCYCD",e.row.crcycd);
	                              }
                            </script>
                        </body>
                    </html>
