<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-14 20:13:31
  - Description:
-->
<head>
<title>queryExpAeuv</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div title="账务管理" visible="true" >            
            <div id="form1" class="nui-form" align="center" style="height:15%">              
                <table id="table1" class="table" style="height:100%">
                    <tr>
                        <td style="font-size: 12px;">业务日期:</td>
                        <td>
                            <input class="nui-datepicker" id="bsnsdt" name="criteria/_expr[1]/bsnsdt" format="yyyyMMdd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;">业务流水:</td>
                        <td>
                            <input class="nui-textbox" id="bsnssq" name="criteria/_expr[2]/bsnssq"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">分录来源:</td>
                        <td>
                            <input class="nui-dictcombobox" name="criteria/_expr[3]/acetna" dictTypeId="FI_ACETSR_NEW" emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;">录入人:</td>
                        <td>
                            <input class="nui-buttonedit"  name="criteria/_expr[4]/usercd" onbuttonclick="selectUser" allowInput="false"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>                     
                    	<td style="font-size: 12px;">入账日期:</td>
                        <td>
                            <input class="nui-datepicker"  name="criteria/_expr[5]/trandt" format="yyyyMMdd"/>
                            <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                        </td>
                    </tr>
                    <tr>                      
                        <td style="font-size: 12px;">档案号:</td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[6]/transq" format="yyyyMMdd"/>
                            <input class="nui-hidden" name="criteria/_expr[6]/_op" value="=">
                        </td>                      
                        <td style="font-size: 12px;">账务状态:</td>
                        <td>
                            <input class="nui-dictcombobox" dictTypeId="FI_STRKST" name="criteria/_expr[7]/strkst" emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[7]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;">金额:</td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[8]/totlam" vtype="float" required="true"/>                         
                        </td>                    
                        <td style="font-size: 12px;">摘要:</td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[9]/remark"/>
                            <input class="nui-hidden" name="criteria/_expr[9]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[9]/_likeRule" value="all">
                        </td>
                        <td style="font-size: 12px;">原业务日期:</td>
                        <td>
                            <input class="nui-datepicker" name="criteria/_expr[10]/odbsdt" format="yyyyMMdd"/>
                            <input class="nui-hidden" name="criteria/_expr[10]/_op" value="=">
                        </td>
                    </tr>
                    <tr>                        
                        <td style="font-size: 12px;">原业务流水:</td>
                        <td>
                            <input class="nui-textbox"  name="criteria/_expr[11]/odbssq"/>
                            <input class="nui-hidden" name="criteria/_expr[11]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;">交易机构:</td>
                        <td>
                            <input class="nui-buttonedit"  name="criteria/_expr[12]/brchcd" onbuttonclick="selectBrch" allowInput="false"/>
                            <input class="nui-hidden" name="criteria/_expr[12]/_op" value="=">
                        </td>                                    
                        <td style="font-size: 12px;">责任中心:</td>
                        <td>
                            <input class="nui-buttonedit" name="criteria/_expr[13]/dutycd" onbuttonclick="selectDuty" allowInput="false"/>
                            <input class="nui-hidden" name="criteria/_expr[13]/_op" value="=">
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
            <a class="nui-button" onclick="ExportExcel()">
                                                                      导出excel
            </a>
            <form id="excelform" action=""  method="post" style="display: inline;"></form>
        </div>          
            <div class="nui-fit">
                <div id="datagrid" dataField="expaeuvs" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comm.queryExpAeuvList.biz.ext" pageSize="10" showPageInfo="true" 
                multiSelect="true" showModified="false" onload="onLoad" allowSortColumn="false">
                    <div property="columns">
                        <div field="bsnsdt" name="bsnsdt" headerAlign="center" allowSort="true">业务日期</div>
                        <div field="bsnssq" name="bsnssq" headerAlign="center" allowSort="true">业务流水 </div>
                        <div field="brchna" headerAlign="center" allowSort="true">账务机构 </div>
                        <div field="dutyna" headerAlign="center" allowSort="true">责任中心</div>
                        <div field="itemna" headerAlign="center" allowSort="true">科目名称</div>
                        <div field="totlamD" headerAlign="center" allowSort="true" decimalPlaces="2" dataType="currency" currencyUnit="">借方金额</div>
                        <div field="totlamC" headerAlign="center" allowSort="true" decimalPlaces="2" dataType="currency" currencyUnit="">贷方金额</div>
                        <div field="acetna" headerAlign="center" allowSort="true" renderer="renderAcetDic">分录来源</div>
                        <div field="userna" headerAlign="center" allowSort="true">录入人</div>
                        <div field="crcycd" headerAlign="center" allowSort="true" renderer="renderCrcyDic">币种</div>
                        <div field="transt" headerAlign="center" allowSort="true" renderer="renderTranst">处理状态</div>                        
                        <div field="trandt" headerAlign="center" allowSort="true" >入账时间</div>
                        <div field="transq" headerAlign="center" allowSort="true" >档案号</div>
                        <div field="odbsdt" headerAlign="center" allowSort="true" >原业务日期</div>
                        <div field="odbssq" headerAlign="center" allowSort="true" >原业务流水</div>
                        <div field="strkst" headerAlign="center" allowSort="true" renderer="renderStrkDic">账务状态</div>
                        <div field="remark" headerAlign="center" allowSort="true" >备注</div>
                        <div field="usercd" headerAlign="center" allowSort="true" visible="false">录入人代码</div>
                        <div field="brchcd" headerAlign="center" allowSort="true" visible="false">机构代码</div>
                        <div field="dutycd" headerAlign="center" allowSort="true" visible="false">责任中心代码</div>
                        <div field="itemcd" headerAlign="center" allowSort="true" visible="false">科目代码</div>
                        <div field="totlam" headerAlign="center" allowSort="true" visible="false">记账金额</div>
                        <div field="stacid" headerAlign="center" allowSort="true" visible="false">账套</div>
                        <div field="wkflid" headerAlign="center" allowSort="true" visible="false">流程实例id</div>
                        <div field="usercd" headerAlign="center" allowSort="true" visible="false">录入人代码</div>
                        <div field="amntcd" headerAlign="center" allowSort="true" visible="false">借贷方向</div>
                        <div field="fileId" headerAlign="center" allowSort="true" visible="false">文件id</div>
                    </div>
                </div>
            </div>
     </div>
</div>


	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid");
        var formData = new nui.Form("#form1").getData(true,false);
         grid.on("load", function () {
            grid.mergeColumns(["bsnsdt", "bsnssq"]);
            grid.frozenColumns(0, 4);
        });
        grid.load(formData);
        
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
        
        function onLoad(){
           var rows = grid.getData();
            for(var i=0;i<rows.length;i++){
                var row = rows[i];
	            if(row.amntcd=="C"){
				     grid.updateRow(row,{
					    totlamC:row.totlam
					   });
				 }
				 if(row.amntcd=="D"){
				     grid.updateRow(row,{
					    totlamD:row.totlam
					   });
				 }
				  grid.updateRow(row,{
					    brchna:row.brchna+"("+row.brchcd+")"
					   });
			      grid.updateRow(row,{
					    dutyna:row.dutyna+"("+row.dutycd+")"
					   });
			      grid.updateRow(row,{
			           itemna:row.itemna+"("+row.itemcd+")"
			           });		   
             }
         }
         function renderCrcyDic(e){
           return nui.getDictText("FI_CTCYCD",e.row.crcycd);
         }
         function renderAcetDic(e) {
			return nui.getDictText("FI_ACETSR_NEW",e.row.acetna);
          }
         function renderTranst(e) {
			return nui.getDictText("FI_TRANST",e.row.transt);
          }
         function renderStrkDic(e) {
			return nui.getDictText("FI_STRKST",e.row.strkst);
          }
           //所属机构
	       function selectBrch() {
	        var btnEdit = this;	      
	        nui.open({
	            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select.jsp?brchtp=0000",
	            showMaxButton: false,
	            title: "选择所属机构",
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
	                    }
	                }
	            }
	        });            
	    }
	     //所属部门
	       function selectDuty() {
	        var btnEdit = this;	       
	        nui.open({
	            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select.jsp?brchtp=0001",
	            showMaxButton: false,
	            title: "选择所属部门",
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
	                    }
	                }
	            }
	        });            
	    } 
	   //查询OA用户
       function selectUser() {
        var btnEdit = this;     
        nui.open({
            url: "<%=request.getContextPath() %>/sunfi_cm/user/OrgEmployeeSelect.jsp",
            showMaxButton: false,
            title: "选择录入人",
            width: 870,
            height: 480,
            ondestroy: function(action){
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.getData();
                        data = nui.clone(data);
                        
                    if (data) {
                        btnEdit.setValue(data.userid);
                        btnEdit.setText(data.empname);
                    }
                }else {
                	btnEdit.setValue(null);
                    btnEdit.setText(null);
                }
            }
        });            
       }
        //导出Excel
        function ExportExcel(){
             var form = document.getElementById("excelform");
             var bsnsdt = nui.get("bsnsdt").getFormValue();
             var bsnssq = nui.get("bsnssq").getValue();           
		     form.action = "com.sunline.sunfi.sunfi_cm.exportExpAeuvList.flow?bsnsdt="+bsnsdt+"&&bsnssq="+bsnssq;
		     form.submit();
        }         
    </script>
</body>
</html>