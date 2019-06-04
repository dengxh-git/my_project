<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): chenc
- Date: 2019-03-30 11:35:19
- Description:
    --%>
    
    
<head>
    <title> 股权证打印</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
</head>
<body style="width:98%;height:95%;">
    <div class="nui-panel" title="股权证打印" iconCls="icon-add" style="width:100%;height:15%;" showToolbar="false" showFooter="true">
        <div id="form1" class="nui-form" align="center" style="height:100%">
            <!-- 数据实体的名称 -->
            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqd.EqdDcmtDetlPrint">
            <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="bsnsdt">
            <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
            <!-- 排序字段 -->
            <table id="table1" class="table" style="height:100%">
               <tr>
                    <td class="form_label">股权编号:</td>
                    <td colspan="1">
                        <input class="nui-textbox" name="criteria/_expr[1]/eqbkno"/>
                        <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                    </td>
                    <td class="form_label">股权类型:</td>
                    <td colspan="1">
                        <input class="nui-dictcombobox nui-form-input" name="criteria/_expr[2]/eqbktp" valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP"/>
                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                    </td>
                    <td class="form_label">发证日期:</td>
                    <td colspan="1">
                        <input class="nui-datepicker" format="yyyyMMdd" name="criteria/_expr[5]/opendt"/>
                        <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                    </td>
                </tr>
                <tr>
                    <td class="form_label">股东代码:</td>
                    <td colspan="1">
                        <input class="nui-textbox" name="criteria/_expr[3]/shhdcd"/>
                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                    </td>
                    <td class="form_label">股东名称:</td>
                    <td colspan="1">
                        <input class="nui-textbox" name="criteria/_expr[4]/shhdna"/>
                        <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                    </td>
                    <td class="form_label">是否打印:</td>
                    <td colspan="1">
                        <input class="nui-dictcombobox nui-form-input" name="criteria/_expr[6]/iprint" valueField="dictID" textField="dictName" dictTypeId="FI_PRINTDI" value="0"/>
                        <input class="nui-hidden" name="criteria/_expr[6]/_op" value="=">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!--footer-->
    <div property="footer" align="center">
        <a class="nui-button" onclick="search()">查询</a>
        <a class="nui-button" onclick="reset()">重置</a>
    </div>
    <div class="nui-panel" title="股权证列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" iconCls="icon-add" onclick="print()">打印</a>
                        <a class="nui-button" iconCls="icon-edit" onclick="edit()">编辑</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="datagrid1" dataField="eqddcmtdetlprints" class="nui-datagrid" style="width:100%;height:100%;" url="com.sunline.fdeqb.eqddcmtbrchbiz.queryEqdDcmtDetlPrint.biz.ext" pageSize="10" showPageInfo="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                <div property="columns">
                    <div type="indexcolumn"></div>
                    <div type="checkcolumn"></div>
                    <div field="eqbkno" headerAlign="center" allowSort="true" >股权编号</div>
                    <div field="eqbktp" headerAlign="center" allowSort="true" renderer="onEqbktpRenderer">股权类型</div>
                    <div field="dcmtno" headerAlign="center" allowSort="true" >股权证编号</div>
                    <div field="shhdcd" headerAlign="center" allowSort="true" >股东代码</div>
                    <div field="shhdna" headerAlign="center" allowSort="true" >股东名称</div>
                    <div field="shhdtp" headerAlign="center" allowSort="true" renderer="onShhdtpRenderer">股东类型</div>
                    <div field="stcknm" headerAlign="center" allowSort="true" >持股数</div>
                    <div field="entcdt" headerAlign="center" allowSort="true" >入股日期</div>
                    <div field="tranty" headerAlign="center" allowSort="true" renderer="onTrantyRenderer">入股方式</div>
                    <div field="stckam" headerAlign="center" allowSort="true" renderer="onStckamRenderer">每股价格</div>
                    <div field="iprint" headerAlign="center" allowSort="true" renderer="onIprintRenderer">是否打印</div>
                </div>
            </div>
        </div>
    </div>
    <div>
    	<iframe id="back" height="0" width="0"  frameborder=no scrolling="no"></iframe>
    </div>
    
    <script type="text/javascript">
        nui.parse();
        var grid = nui.get("datagrid1");
 		var bootPath = "<%=request.getContextPath() %>";
        var formData = new nui.Form("#form1").getData(false,false);
        grid.load(formData);

		//新增
        function print() {
            var row = grid.getSelected();
            if (row) {
            	var dcmtno = row.dcmtno;
            	if(typeof(dcmtno)=="undefined" || dcmtno==""){
            		nui.alert("未指定对应股权证，请选择股权证","系统提示",function(action){
            			if(action == "ok" || action == "close"){
                        	edit();
                        }
            		});
            	}else{
	            	var json = {params:{eqbkno:row.eqbkno,shhdtp:row.shhdtp}};
	            	nui.ajax({
	                    url:"com.sunline.fdeqb.eqddcmtbrchbiz.printEqdDcmtDetl.biz.ext",
	                    type:'POST',
	                    data:json,
	                    cache:false,
	                    contentType:'text/json',
	                    success:function(text){
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                           openPrintWindown(returnJson);
	                        }else{
	                            nui.alert("保存失败", "系统提示", function(action){
	                                if(action == "ok" || action == "close"){
	                                }
	                            });
	                        }
	                    }
	                }); 
            	}
            } else {
                alert("请选中一条记录");
            }
        }
        
        function edit(){
        	var row = grid.getSelected();
            if (row) {
            	var dcmtno = row.dcmtno;
            	if(typeof(dcmtno)!="undefined" && dcmtno!=""){
            		nui.alert("已经分配了股权证，无需编辑！","系统提示");
            		return;
            	}
                nui.open({
                    url: bootPath + "/fdeqb/eqddcmtdetl_printEdit.jsp",
                    title: "编辑股权", width: 650, height: 480,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "edit", recode:row };
                        iframe.contentWindow.load(data);
                    },
                    ondestroy: function (action) {
                        //var iframe = this.getIFrameEl();
                        grid.reload();
                    }
                });
            } else {
                alert("请选中一条记录");
            }
        }
        
        function openPrintWindown(data){
        	var filePath1 = data.filePath;
		    //var filePathCp = filePath.replace(".pdf","Cp.pdf");
        	nui.open({
                url: bootPath+"/fdeqb/ireportPrintMode.jsp?filePath="+filePath1,
                title: "股权证打印", width: 800, height: 600,
                onload: function (txt) {
					
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        }

        //重新刷新页面
        function refresh(){
            var form = new  nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
        }

        //查询
        function search() {
            var form = new nui.Form("#form1");
            var json = form.getData(true,false);
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
        }
            
        function onEqbktpRenderer(e){
			return nui.getDictText("FI_EQBKTP", e.row.eqbktp);
		}
		function onStckamRenderer(e){
			return nui.formatNumber(e.row.stckam,"#,##0.00");
		}
		function onIprintRenderer(e){
			return nui.getDictText("FI_PRINTDI",e.row.iprint);
		}
		function onTrantyRenderer(e){
			return nui.getDictText("FI_TRANTY",e.row.tranty);
		}
		function onShhdtpRenderer(e){
			return nui.getDictText("FI_SHHDTP",e.row.shhdtp);
		}
        </script>
    </body>
</html>
