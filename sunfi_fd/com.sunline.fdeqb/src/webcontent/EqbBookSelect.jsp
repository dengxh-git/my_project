<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <head>
        <title>
            	选择列表
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%
        	String isout=request.getParameter("param/isout");
        	String status=request.getParameter("param/status");
        	String pldgst=request.getParameter("param/pldgst");//质押状态
        	String frozst=request.getParameter("param/frozst");//冻结状态
        	String eqbkno=request.getParameter("param/eqbkno");

        	request.setAttribute("isout", isout);
        	request.setAttribute("status", status);
        	request.setAttribute("pldgst", pldgst);
        	request.setAttribute("frozst", frozst);
        	
        	request.setAttribute("eqbkno", eqbkno);
        %>
    </head>
<html>
<body>
    <div id="form1" class="nui-form" style="height: 10%">
            <table id="table1" class="table" style="height:100%;width:100%;">
                <tr>
                    <td style="font-size: 12px;text-align: right;">
                       	股权编号：
                    </td>
                    <td>
                        <input class="nui-textbox" name="param/eqbkno" value="${eqbkno}"/>
                    </td>
                    <td style="font-size: 12px;text-align: right;">
                      	股东名称：
                    </td>
                    <td>
                        <input class="nui-textbox" name="param/shhdna"/>
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
            <div id="eqbBookgrid" dataField="eqbbooks" class="nui-datagrid" style="width:100%;height:100%;"
            	 url="com.sunline.sunfi.sunfi_eq.eqbbookbiz.queryEqbBookss.biz.ext"  pageSize="10" 
                 showPageInfo="true" onrowdblclick="onOk">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
                    <div type="checkcolumn">选择</div>
		            <div field="eqbkno" headerAlign="center" allowSort="true">股权编号</div>    
		            <div field="eqbktp" headerAlign="center" allowSort="true" renderer="rendereqbktp">股权类型</div>
		            <div field="dcmtno" headerAlign="center" allowSort="true">凭证号码</div>               
		        	<div field="acctbr" headerAlign="center" allowSort="true">账务部门</div>
		        	<div field="ecmytp" headerAlign="center" allowSort="true" renderer="renderecmytp">经济性质</div>
		        	<div field="shhdcd" headerAlign="center" allowSort="true">股东代码</div>
		        	<div field="shhdna" headerAlign="center" allowSort="true">股东名称</div>
		        	<div field="stcknm" headerAlign="center" allowSort="true" dataType="float" decimalPlaces="2" align="right" allowSort="true">持股数</div>
		        	<div field="stckam" headerAlign="center" allowSort="true" dataType="currency" currencyUnit="￥" align="right" allowSort="true">持股金额</div>
		        	<% if("".equals(isout) || "null".equals(isout) || null ==isout){ %>
		        	<div field="pldgnm" headerAlign="center" allowSort="true" dataType="int" align="right" allowSort="true">质押股数</div>	
		        	<div field="froznm" headerAlign="center" allowSort="true" dataType="int" align="right" allowSort="true">冻结股数</div>	
		        	<% } %>
		        	<div field="entcdt" headerAlign="center" allowSort="true" renderer="renderEntcdt">入股日期</div>
		        	<div field="tranty" headerAlign="center" allowSort="true" renderer="rendertranty">入股方式</div>
		        </div>
            </div>
        </div>
    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
    	<a class="nui-button" style="width:60px;"  onclick="onOk()">选择</a>
    	<span style="display:inline-block;width:25px;"></span>
    	<a class="nui-button" style="width:60px;" onclick="onCancel()">取消</a>
	</div>
        <script type="text/javascript">
            nui.parse();
            //初始化页面时加载数据
            var grid = nui.get("eqbBookgrid");
            var param={ param :{isout : "${isout}" , eqbkno : "${eqbkno}" , pldgst : "${pldgst}" , frozst : "${frozst}" , status : "${status}"}};
            grid.load(param);
            
		    function getData() {
		        var row = grid.getSelected();
		        return row;
		    }
		
		    function CloseWindow(action) {
		        if (window.CloseOwnerWindow)
		        	return window.CloseOwnerWindow(action);
		        else 
		         	window.close();
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

            function rendertranty(e) {
				return nui.getDictText("FI_TRANTY",e.row.tranty);
            }
            function rendereqbktp(e) {
				return nui.getDictText("FI_EQBKTP",e.row.eqbktp);
            }
            function renderecmytp(e) {
				return nui.getDictText("FI_ECMYTP",e.row.ecmytp);
            }
            function renderEntcdt(e) {
	            var value = e.value;
	            var date=nui.parseDate(value);
	            if (value) 
	               return nui.formatDate(date, 'yyyy-MM-dd');
	            return "";
            } 
           </script>    
</body>
</html>