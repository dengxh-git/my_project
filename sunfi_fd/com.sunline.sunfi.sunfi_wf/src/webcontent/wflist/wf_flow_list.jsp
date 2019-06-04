<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2019-01-14 15:32:21
- Description:
    --%>
    <head>
        <title>
            WfFlowList查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>
     <div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="流程配置管理" visible="true" >            
            <div id="form1" class="nui-form" align="center" style="height:10%">
                <!-- 数据实体的名称 -->
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td class="form_label">
                            所属法人:
                        </td>
                        <td colspan="1">
                             <input class="nui-buttonedit" name="criteria/_expr[1]/brchcd" onbuttonclick="selectBrch" allowInput="false" textName="brchna"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                        </td>
                        <td class="form_label">
                            机构类型:
                        </td>
                        <td colspan="1">
                            <input class="nui-dictcombobox" dictTypeId="FI_FLOWTP" name="criteria/_expr[2]/flowtp"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                        <td class="form_label">
                            业务项目:
                        </td>
                        <td colspan="3">
                            <input class="nui-buttonedit" name="criteria/_expr[3]/typecd" onbuttonclick="selectType" allowInput="false" />
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
                <div id="datagrid1" dataField="wfflowlists" showModified="false" class="nui-datagrid" onload="onload" style="width:100%;height:100%;" url="com.sunline.sunfi.sunfi_wf.wfflowlistbiz.queryWfFlowLists.biz.ext" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="wfstid" headerAlign="center" allowSort="true" visible="false">
                           	     主键id
                        </div>
                        <div field="brchna" headerAlign="center" allowSort="true" >
                            	所属法人
                        </div>
                        <div field="flowtp" headerAlign="center" allowSort="true" renderer="renderbrchtype">
                            	机构类型
                        </div>
                        <div field="typena" headerAlign="center" allowSort="true" >
                           	        业务项目
                        </div>
                        <div field="minsum" headerAlign="center" allowSort="true" decimalPlaces="2" dataType="currency" currencyUnit="">
                            	金额自(大于)
                        </div>
                        <div field="maxsum" headerAlign="center" allowSort="true">
                            	 金额止(小于)
                        </div>
                        <div field="wfname" headerAlign="center" allowSort="true" >
                            	流程名称
                        </div> 
                        <div field="brchcd" headerAlign="center" allowSort="true" visible="false">
                           	         法人代码
                        </div>
                        <div field="flowid" headerAlign="center" allowSort="true" visible="false">
                           	       流程代码
                        </div> 
                        <div field="typecd" headerAlign="center" allowSort="true" visible="false">
                           	        业务项目
                        </div>                      
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
                    url: "<%=request.getContextPath() %>/sunfi_wf/wflist/wf_flow_form.jsp",
                    title: "新增记录", width: 640, height: 240,
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
                        url: "<%=request.getContextPath() %>/sunfi_wf/wflist/wf_flow_form.jsp",
                        title: "编辑数据",
                        width: 640,
                        height: 240,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{wfflowlist:row}};
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
                                    var json = nui.encode({wfflowlists:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.sunfi.sunfi_wf.wfflowlistbiz.deleteWfFlowLists.biz.ext",
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
                                function onload(){
                                 var rows = grid.getData();
				                 for (var i = 0, l = rows.length; i < l; i++){
				                    var row = rows[i];
				                    grid.updateRow(row,{
					                    typena:row.typena+"("+row.typecd+")"
					                    });
					               grid.updateRow(row,{
					                    maxsum:nui.formatNumber(row.maxsum, "#,0.00")
					                    });     
                                 }
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
			                    } //选择业务项目
			                    function selectType(){
			                    var btnEdit = this;
			                    nui.open({
							            url: "<%=request.getContextPath() %>/sunfi_cm/type/afpItem_select.jsp",
							            showMaxButton: false,
							            title: "选择业务项目",
							            width: 950,
							            height: 570,
							            allowResize:false,
							            ondestroy: function(action){
							                if (action == "ok") {
							                    var iframe = this.getIFrameEl();
						                        var data = iframe.contentWindow.getData();
						                        data = nui.clone(data);
						                        if (data) {
							                        btnEdit.setValue(data.typecd);
							                        btnEdit.setText(data.typena);				                       
						                       }
							                }else{
						                            btnEdit.setValue("");
							                        btnEdit.setText("");
						                       }
							            }
							        });
			                    }
                                function renderbrchtype(e) {
									return nui.getDictText("FI_FLOWTP",e.row.flowtp);
	                              } 
                            </script>
                        </body>
                    </html>
