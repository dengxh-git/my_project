<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-12-28 18:07:02
  - Description:
-->
<head>
<title>finshedtask_list</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="form1" class="nui-form" align="center" style="height:10%">              
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td style="font-size: 12px;">
                            申请事由:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="params.remark"/>
                        </td>
                       
                        <td style="font-size: 12px;">
                            申请人:
                        </td>
                        <td colspan="3">
                            <input class="nui-buttonedit searchbox" name="params.usercd" allowinput="false"  textName="params.userna"
                               onbuttonclick="selectUser" />
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
            <div class="nui-fit">
                <div 
                        id="datagrid1"
                        dataField="listworkitems"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.sunline.sunfi.sunfi_wf.listworkitembiz.queryfinshedtask.biz.ext"
                        pageSize="10"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div field="bsnsdt" headerAlign="center" allowSort="true" visible="false">日期</div>
                        <div field="bsnssq" headerAlign="center" allowSort="true" visible="false">流水号</div>
                        <div field="processinstdesc" headerAlign="center" allowSort="true" >业务来源</div>
                        <div field="remark" headerAlign="center" allowSort="true" >申请事由</div>
                        <div field="dutycd" headerAlign="center" allowSort="true" visible="false">责任中心</div>
                        <div field="brchna" headerAlign="center" allowSort="true" >申请部门</div>
                        <div field="totlam" headerAlign="center" allowSort="true" visible="false" decimalPlaces="2" dataType="currency" currencyUnit="">金额</div>
                        <div field="usercd" headerAlign="center" allowSort="true" visible="false">用户代码</div>
                        <div field="creator" headerAlign="center" allowSort="true" >申请人</div>
                        <div field="endtime" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true" >审核时间</div>
                        <div field="workItemid" headerAlign="center" allowSort="true" visible="false">工作项id</div>
                        <div field="processinstid" headerAlign="center" allowSort="true" >流程实例id</div>
                        <div field="loadst" headerAlign="center" allowSort="true" visible="false">是否上传</div>
                        <div field="fileid" headerAlign="center" allowSort="true" visible="false">文件id</div>
                    </div>
                </div>
            </div>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false,true);
    	var timer;//监听器
        var winopen;//打开
        grid.load(formData);
        grid.on("drawcell", function (e) {
              var field= e.field,value = e.value;
              //remark列，超连接操作按钮
	            if (field == "remark") {
	                e.cellHtml = '<a href="javascript:void(0);" style="text-decoration: none;color:#6a9dd4;" onclick="showDetail()">'+value+'</a>';
	                   
	            }
              });
		       //流程详细信息      
		       function showDetail(){
		         var row = grid.getSelected();
		         var wkflid = row.processinstid;
		         var emstype = row.emstype; 
		         var fileid = row.fileid; 
		         var sigValue=encryptByDES(wkflid+emstype+fileid);	
		         winopen=window.open("<%=request.getContextPath() %>/sunfi_wf/workitem/finish_workitem_manager.jsp?wkflid="+wkflid+"&&emstype="+emstype+"&&fileid="+fileid+"&&sig="+sigValue); 
		         timer = window.setInterval("ifWindowClosed()", 500);
		        } 
				//判断打开的子页面是否关闭      
		        function ifWindowClosed(){
		             if(winopen.closed==true){
		                window.clearInterval(timer);
		                grid.reload();
		                return;
		             }
		        }   
              //重新刷新页面
               function refresh(){
	                var form = new  nui.Form("#form1");
	                var json = form.getData(false,true);
	                grid.load(json);//grid查询
                 }

                //查询
                function search() {
                    var form = new nui.Form("#form1");
                    var json = form.getData(false,true);
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
	            function selectbrch(e) {
			        var btnEdit = this;
			        var brchcd = nui.get("params.brchcd");
			        nui.open({
			            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select.jsp?brchtp=0001",
					            showMaxButton: false,
					            title: "选择报销部门",
					            width: 950,
					            height: 580,
					            allowResize:false,
					            ondestroy: function(action){
					                if (action == "ok") {
					                    var iframe = this.getIFrameEl();
					                    var data = iframe.contentWindow.getData();
					                    data = nui.clone(data);
					                    if (data) {
					                        btnEdit.setValue(data.brchcd);
					                        btnEdit.setText(data.brchna);
					                        brchcd.setValue(data.sprrcd);
					                    }
					                }if (action == "cancel" ||action == "close") {
					                        btnEdit.setValue(null);
					                        btnEdit.setText(null);
					                        brchcd.setValue(null);
					                }
					            }
					        });            
	   					 }
	   			 function selectUser(e){
			        var btnEdit = this;
			        nui.open({
			            url: "<%=request.getContextPath() %>/sunfi_cm/user/OrgEmployeeSelect.jsp",
			            showMaxButton: false,
			            title: "选择用户",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.userid);
			                        btnEdit.setText(data.userid);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                }
			            }
			        });    
	   			 }	
    </script>
</body>
</html>