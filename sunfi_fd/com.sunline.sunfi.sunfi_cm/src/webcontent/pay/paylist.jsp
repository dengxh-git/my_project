<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-22 18:17:31
  - Description:
-->
<head>
<title>付款信息列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
	<div title="付款信息管理" visible="true" >     
<div id="form1" class="nui-form" align="center" style="height:10%">
	<table id="table1" class="table" style="height:100%">
		<tr>
			<td style="font-size: 12px;">
			日期:
			</td>
			<td>
			<input class="nui-datepicker" name="params.bsnsdt" format="yyyyMMdd"/>	
			</td>
			<td>
			流水号:
			</td>
			<td>
			<input class="nui-textbox" name="params.bsnssq"/>
			</td>
			<td>
			转账类型:
			</td>
			<td>
			<input class="nui-dictcombobox" dictTypeId="FI_TAXPATP" name="params.recpty" allowinput="false"/>
			</td>
		</tr>
	</table>
</div>
 <div property="footer" style="margin-left: 8px;" align="center">
            <a class="nui-button" onclick="search()">
                查询
            </a>
            <a class="nui-button" onclick="reset()">
                重置
            </a>
            <form id="excelform" action=""  method="post" style="display: inline;"></form>
        </div>
<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">         
                    <a id="edit_btn" class="nui-button" onclick="exportExcel()">
                       	导出
                    </a>
                </td>
            </tr>
        </table>
    </div>
 <div class="nui-fit">             
<div  class="nui-datagrid" dataField="paylist"  multiSelect="true" id="datagrid" showPager="false" style="width:100%;height:100%;" url="com.sunline.sunfi.sunfi_cm.pay.queryPayList.biz.ext">
    <div property="columns">
    <div type="checkcolumn"></div>
        <div field="bsnsdt" width="" headerAlign="center" allowSort="true">日期</div>
        <div field="bsnssq" width="" headerAlign="center" allowSort="true">流水号</div>
        <div field="acctno" width="" headerAlign="center" allowSort="true">付款账号</div>
        <div field="acctna" width="" headerAlign="center" allowSort="true">付款账户名</div>
        <div field="bnmtam" width="" headerAlign="center" allowSort="true" decimalPlaces="2" dataType="currency" currencyUnit="">结算金额</div>
        <div field="suppna" width="" headerAlign="center" allowSort="true">收款账户名</div>
        <div field="cardnu" width="" headerAlign="center" allowSort="true">收款账号</div>
        <div field="brname" width="" headerAlign="center" allowSort="true">收款方开户行</div>
        <div field="recpty" width="" headerAlign="center" allowSort="true" renderer="rendertype">转账类型</div>
        <div field="area" width="" headerAlign="center" allowSort="true" visible="false">地区类型</div>
        <div field="urgent" width="" headerAlign="center" allowSort="true" visible="false">加急标志</div>
        <div field="remark1" width="" headerAlign="center" allowSort="true" visible="false">备注</div>
        <div field="remark" width="" headerAlign="center" allowSort="true">用途</div>
    </div>
</div>
</div>
</div>
</div>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid");
    	var formData = new nui.Form("#form1").getData(false,true);
    	grid.on("load", function () {
            grid.mergeColumns(["bsnsdt", "bsnssq"]);
        });
        grid.load(formData);
        function rendertype(e){
         return nui.getDictText("FI_TAXPATP",e.row.recpty);
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
         //导出excel
         function exportExcel(){
          var form = document.getElementById("excelform");
          var rows = grid.getSelecteds();
	         if(rows.length > 0){
	           var json = nui.encode(rows);
	            form.action = "com.sunline.sunfi.sunfi_cm.exportPay.flow?payment="+json;
				form.submit();
	         }else{
	          nui.alert("请选中一条记录","提示");
	         }
         }
    </script>
</body>
</html>