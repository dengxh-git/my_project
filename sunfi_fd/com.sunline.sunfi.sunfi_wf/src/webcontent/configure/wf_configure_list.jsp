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
            流程配置查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>
    <div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="流程配置管理" visible="true" >        
            <div id="form1" class="nui-form" align="center" style="height:15%">
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td class="form_label">
                            流程编号:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/flowid"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td class="form_label">
                            流程名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[2]/wfname"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>                    
                        <td class="form_label">
                            法人名称:
                        </td>
                        <td colspan="3">
                            <input class="nui-buttonedit" name="criteria/_expr[3]/brchcd" onbuttonclick="selectBrch" allowInput="false" textName="brchna"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
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
                <div 
                        id="datagrid1"
                        dataField="wfconfigures"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.sunline.sunfi.sunfi_wf.wfconfigurebiz.queryWfConfigures.biz.ext"
                        pageSize="10"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="flowid" headerAlign="center" allowSort="true">流程编号</div>
                        <div field="brchna" headerAlign="center" allowSort="true" >法人名称</div>
                        <div field="wfname" headerAlign="center" allowSort="true" >流程名称</div>
                        <div field="wfpath" headerAlign="center" allowSort="true" >流程路径</div>
                        <div field="usedtp" headerAlign="center" allowSort="true" renderer="renderusedtp">是否使用</div>
                        <div field="brchcd" headerAlign="center" allowSort="true" width="0">法人代码</div>
                    </div>
                </div>
            </div> 
         </div>
     </div>      
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");

            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);

            //新增
            function add() {
                nui.open({
                    url: "<%= request.getContextPath() %>/sunfi_wf/configure/wf_configure_add.jsp",
                    title: "新增记录", width: 850, height: 600,
                    onload: function () {},
                    ondestroy: function (action) {//弹出页面关闭前
                    if(action=="saveSuccess"){
                        grid.reload();
                    }
                }
                });
            }

            //编辑
            function edit() {
                var row = grid.getSelected();
                if (row) {
                    nui.open({
                        url: "<%= request.getContextPath() %>/sunfi_wf/configure/wf_configure_update.jsp",
                        title: "编辑数据",
                        width: 850,
                        height: 600,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = row;
                            //直接从页面获取，不用去后台获取
                            iframe.contentWindow.setData(data);
                            },
                            ondestroy: function (action) {
                                if(action=="saveSuccess"){
                                    grid.reload();
                                }
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
                                    var json = nui.encode({wfconfigures:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_wf.wfconfigurebiz.deleteWfConfigures.biz.ext",
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
                                 function renderusedtp(e){
                                  return nui.getDictText("FI_USEDTP",e.row.usedtp);
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
                            </script>
                        </body>
                    </html>
