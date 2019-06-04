<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): chenc
- Date: 2019-03-30 11:35:19
- Description:
    --%>
    
    <%
     String wkflid = request.getParameter("wkflid");
     request.setAttribute("wkflid", wkflid);
    
     %> 
    <head>
        <title>
            股权证登记
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
        </script>
    </head>
    <body style="width:98%;height:95%;">
        <div class="nui-panel" title="股权证登记" iconCls="icon-add" style="width:100%;height:15%;" showToolbar="false" showFooter="true">
        	
            <div id="form1" class="nui-form" align="center" style="height:100%">
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqd.EqdDcmtBrch">
                <!-- 排序字段 -->
                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="dcmtid">
                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
                <input class="nui-hidden" name="criteria/_expr[5]/wkflid" value=""/>
                <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td class="form_label">
                            起始号码:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/initno"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                        </td>
                        <td class="form_label">
                            结束号码:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[2]/finlno"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            登记日期:
                        </td>
                        <td colspan="1">
                            <input class="nui-datepicker" format="yyyyMMdd" name="criteria/_expr[3]/regtdt"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                        <td class="form_label">
                            凭证所属机构:
                        </td>
                        <td colspan="1">
                            <input class="nui-lookup" name="criteria/_expr[4]/brchcd"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>
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
        <div class="nui-panel" title="股权证登记列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" iconCls="icon-add" onclick="add()">
                                增加
                            </a>
                            
                            <a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">
                                编辑
                            </a>
                            <a class="nui-button" iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>
                            <a class="nui-button" iconCls="icon-expand" onclick="startWorkFlow()">
                                发起流程
                            </a>
 
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="datagrid1" dataField="eqddcmtbrchs" class="nui-datagrid" style="width:100%;height:100%;" url="com.sunline.fdeqb.eqddcmtbrchbiz.queryEqdDcmtBrchs.biz.ext" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        	
                        </div>
                        <div field="dcmtid" headerAlign="center" allowSort="true" >
                            凭证序号
                        </div>
                        <div field="prefno" headerAlign="center" allowSort="true" >
                            编码前缀
                        </div>
                        <div field="initno" headerAlign="center" allowSort="true" >
                            起始号码
                        </div>
                        <div field="finlno" headerAlign="center" allowSort="true" >
                            结束号码
                        </div>
                        <div field="tranam" headerAlign="center" allowSort="true" >
                            份数
                        </div>
                        <div field="regtdt" headerAlign="center" allowSort="true" >
                            登记日期
                        </div>
                        <div field="brchcd" headerAlign="center" allowSort="true" >
                            凭证所属机构
                        </div>
                        <div field="usercd" headerAlign="center" allowSort="true" >
                            操作员
                        </div>
                        <div field="remark" headerAlign="center" allowSort="true" >
                            备注
                        </div>
                        <div field="bsnsdt" headerAlign="center" allowSort="true" >
                            业务日期
                        </div>
                        <div field="bsnssq" headerAlign="center" allowSort="true" >
                            业务流水
                        </div>
                        <div field="transt" headerAlign="center" allowSort="true"  renderer="renderTranst" >
                            处理状态
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
 			var bootPath = "<%=request.getContextPath() %>";
           	var timer;//监听器
        	var winopen;//打开
            setData();//设置数据
            var formData = new nui.Form("#form1").getData(false,false);
           
            grid.load(formData);

            //新增  fdeqb/EqdDcmtBrchForm.jsp
           /*  function add() {
                nui.open({
                    url: "/default/fdeqb/EqdDcmtBrchForm.jsp",
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
            } */
			//新增
            function add() {
                nui.open({
                    url: bootPath+"/fdeqb/eqdDcmtAdd.jsp",
                    title: "新增股权证",
                    width: 1200, 
                    height: 775,
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
                        url: "EqdDcmtBrchForm.jsp",
                        title: "编辑数据",
                        width: 600,
                        height: 300,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{eqddcmtbrch:row}};
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
                                    var json = nui.encode({eqddcmtbrchs:rows,
                                						master:{remark:'123',
                                								wfdena:'com.sunline.sunfi.sunfi_wf_workflow.eqbApp'
                                								}
                                    										});
                                    
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.sunline.fdeqb.eqddcmtbrchbiz.deleteEqdDcmtBrchs.biz.ext",
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
                                //发起流程
                    function startWorkFlow(){
                        var rows = grid.getSelecteds();
                        if(rows.length>0){
                        	var eqbdcmt = {} ;
                        	var eqbdcmts=rows;
                        	for (var a =0 ;a<rows.length ; a++ ){
                        		eqbdcmt = rows[a];
                        		
                        		if(eqbdcmt.wkflid){
                        		 	nui.alert("凭证序号序号为："+rows[a].dcmtid+'的记录已发起过流程！');
                        			return false ;
                        		}
                        		eqbdcmt = {} 
                        		eqbdcmt.bsnsdt = rows[a].bsnsdt;
                        		eqbdcmt.bsnssq = rows[a].bsnssq;
                        		eqbdcmt.transt = rows[a].transt;
                        		eqbdcmt.wkflid = rows[a].wkflid;
                        		eqbdcmts[a]=eqbdcmt;
                       		}
                       		
                       		  nui.confirm("确定对选中记录发起流程？","系统提示", 
                       		  		function(action){
                       		  		
                       		  			 if(action=="ok"){
                       		  			 	
                       		  			 	var json = nui.encode({detail:eqbdcmts,
                                						master:{remark:'股权证登记'+rows.length+'个',
                                								wfdena:'com.sunline.sunfi.sunfi_wf_workflow.eqbApp',
                                								tbname:'eqd_dcmt',
                                								prcscd:'eqd_dcmt_add',
                                								wfinna:'股权证登记',
                                								wfinde:'股权证登记',
                                								lnkurl:'/fdeqb/EqdDcmtBrchList.jsp?wkflid=',
                                								linkna:'股权证登记',
                                								entityna:'com.sunline.fdeqb.eqd.EqdDcmtBrch'
                                								}
                                    										});
                                 			 $.ajax({
		                                        url:"com.sunline.sunfi.sunfi_wf.doExecuteWf.startWorkFlowForAjax.biz.ext",
		                                        type:'POST',
		                                        data:json,
		                                        cache: false,
		                                        contentType:'text/json',
		                                        success:function(text){
		                                            var returnJson = nui.decode(text);
		                                            //console.log(text);
		                                             if(returnJson.exception == null){
		                                				//alert('wkflid:'+returnJson.retmsg.wkflid+'wfitid:'+returnJson.retmsg.wfitid );
		                                				//console.log(returnJson);
		                                				var wkflid = returnJson.retmsg.wkflid;
		                                				var wfitid = returnJson.retmsg.wfitid;
		                                				winopen = window.open("<%=request.getContextPath() %>/sunfi_wf/workitem/unfinish_workitem_manager.jsp?wkflid="+wkflid+"&&wfitid="+wfitid+"&&emstype=&&transt=&&fileid=&&usercd="); 
			                       						 //onCancel();
			                       						 timer = window.setInterval("ifWindowClosed()", 500);
		                                			 }
		                                	
											}
											});   										
                       		  			 }
                       		  		}
                       		  );
                        	
                        
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
                                    var rows = grid.getSelecteds();
                                    if(rows.length>1){
                                        nui.get("update").disable();
                                    }else{
                                        nui.get("update").enable();
                                    }
                                }
                                //流程查询初始化
                                function setData(){
                                	var wkflid = '${wkflid}';
                                	//nui.getbyName('criteria/_expr[5]/bsnsdt').setValue(bsnsdt);
                                	//nui.getbyName('criteria/_expr[6]/bsnssq').setValue(bsnssq);
                                	nui.getbyName('criteria/_expr[5]/wkflid').setValue(wkflid);
                                }
                                
                                function renderTranst(e){
					            	return nui.getDictText("FI_TRANST",e.row.transt);
					            }
					              //判断打开的子页面是否关闭      
						        function ifWindowClosed(){
						             if(winopen.closed==true){
						                window.clearInterval(timer);
						                grid.reload();
						                return;
						             }
						        } 
					            
                            </script>
                        </body>
                    </html>
