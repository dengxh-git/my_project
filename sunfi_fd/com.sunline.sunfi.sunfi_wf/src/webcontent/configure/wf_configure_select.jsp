<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>	
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-14 16:57:26
  - Description:
-->
<head>
<title>wf_configure_select</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />    
</head>
<body>
<div id="form1" class="nui-form" style="height: 10%">
               <table id="table1" class="table" style="height:100%; width: 100%;">
                    <tr>
                        <td style="font-size: 12px;text-align: right;">
                            流程编号:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[1]/flowid"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            流程名称:
                        </td>
                        <td colspan="1">
                            <input class="nui-textbox" name="criteria/_expr[2]/wfname"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>                    
                        <td style="font-size: 12px;text-align: right;">
                            法人名称:
                        </td>
                        <td colspan="3">
                            <input class="nui-buttonedit" name="criteria/_expr[3]/brchcd" onbuttonclick="selectBrch" allowInput="false" textName="brchna"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
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
            <div class="nui-fit">
                <div id="datagrid" dataField="wfconfigures" class="nui-datagrid" style="width:100%;height:100%;" 
                url=com.sunline.sunfi.sunfi_wf.wfconfigurebiz.queryWfConfigures.biz.ext pageSize="10" showPageInfo="true" 
                  onrowdblclick="onOk">
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
        <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;"  onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;"  onclick="onCancel()">取消</a>
    </div>
	<script type="text/javascript">
    	  nui.parse();
    	  var grid = nui.get("datagrid");
    	  var formData = new nui.Form("#form1").getData(false,false);    
          grid.load(formData);
	          function getData() {
		        var row = grid.getSelected();
		        return row;
		      }
							
		     function CloseWindow(action) {
		        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		        else window.close();
		     }
							
		     function onOk() {
		        CloseWindow("ok");
		     }
		     function onCancel() {
		        CloseWindow("cancel");
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