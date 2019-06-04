<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-27 15:35:03
- Description:
    --%>
    <head>
        <title>
            机构信息列表
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
    </head>
    <body>
            <div id="form1" class="nui-form" style="height: 10%">                        
                <table id="table1" class="table" style="height:100%;width:100%;">
                    <tr>
                        <td style="font-size: 12px;">
                            机构代码:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[1]/brchcd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;">
                            机构名称:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[2]/brchna"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                        </td>
                        <td>                           
                        <td style="font-size: 12px;">
                            机构性质:
                        </td>
                        <td>
                            <input id="brchtp" class="nui-dictcombobox" style="font-size: 12px;"  dictTypeId="FI_BRCHTP" name="criteria/_expr[3]/brchtp"  emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                         <td style="font-size: 12px;">
                            上级代码:
                        </td>
                        <td>
                            <input id="sprrcd" class="nui-textbox" style="font-size: 12px;" name="criteria/_expr[4]/sprrcd"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="like">
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
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="brchgrid" dataField="combrchs" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.combrchbiz.queryComBrchNotPower.biz.ext" pageSize="10" showPageInfo="true" 
                  onrowdblclick="onOk">
                    <div property="columns">
                        <div type="checkcolumn"></div>                       
                        <div field="brchcd" headerAlign="center" allowSort="true">机构代码 </div>
                        <div field="brchna" headerAlign="center" allowSort="true">机构名称</div>
                        <div field="sprrcd" headerAlign="center" allowSort="true">上级代码</div>
                        <div field="usedtp" headerAlign="center" allowSort="true" renderer="renderusedtp"> 是否使用 </div>
                        <div field="brchtp" headerAlign="center" allowSort="true" renderer="renderbrchtype">机构类型 </div>
                    </div>
                </div>
            </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("brchgrid");

            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);

            //新增
            function add() {
                nui.open({
                    url: "<%= request.getContextPath() %>/sunfi_cm/brch/combrch_add.jsp",
                    title: "机构新增", width: 800, height: 250,
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
                        url: "<%= request.getContextPath() %>/sunfi_cm/brch/combrch_edit.jsp",
                        title: "机构修改",
                        width: 800,
                        height: 250,
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
                                 function renderusedtp(e){
                                  return nui.getDictText("FI_USEDTP",e.row.usedtp);
                                 }
                                 function renderbrchtype(e) {
									return nui.getDictText("FI_BRCHTP",e.row.brchtp);
	                              }                           
                            </script>
                        </body>
                    </html>