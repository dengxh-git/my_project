<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/coframe/tools/skins/common.jsp" %>
<%--
- Author(s): Administrator
- Date: 2019-05-13 11:46:20
- Description:
--%>
<%
	//获取标签中使用的国际化资源信息
	String obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_book"); //
	String obj_search = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.search");//
	String obj_list = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.list"); //
	
	String opratp=request.getParameter("opratp");//业务类型: 解质押20-->质押19   解冻结22-->冻结21
	String pldgst=request.getParameter("pldgst");//质押状态
	String frozst=request.getParameter("frozst");//冻结状态
	
	request.setAttribute("opratp", opratp);
	request.setAttribute("pldgst", pldgst);
	request.setAttribute("frozst", frozst);
	

%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <%=obj %>
    </title>
  </head>
<body>
    <div id="form1" class="nui-form" style="height: 10%">
    <input name="params.opratp" class="mini-hidden" value="<%=opratp %>"/>
    <input name="params.pldgst" class="mini-hidden" value="<%=pldgst %>"/>
    <input name="params.frozst" class="mini-hidden" value="<%=frozst %>"/>
        <table id="table1" class="table" style="height:100%;width:100%;">
            <tr>
                <td style="font-size: 12px;text-align: right;">
                   	股权编号：
                </td>
                <td>
                    <input class="nui-textbox" name="params/eqbkno" value="${eqbkno}"/>
                </td>
                <td style="font-size: 12px;text-align: right;">
                  	股东代码：
                </td>
                <td>
                    <input class="nui-textbox" name="params/shhdcd"/>
                </td>
            </tr>
            <tr>
            <% if("19".equals(opratp)){ %>
                <td style="font-size: 12px;text-align: right;">
                  	质押日期：
                </td>
                <td>
                	<input class="nui-datepicker " name="params/pldgdt" allowInput="false"/>
                </td>
                <td style="font-size: 12px;text-align: right;">
                   	质押原因：
                </td>
                <td>
                    <input class="nui-textbox" name="params/pldgrs"/>
                </td>
            <% }else if("21".equals(opratp)){ %>
                <td style="font-size: 12px;text-align: right;">
                  	质押日期：
                </td>
                <td>
                	<input class="nui-datepicker " name="params/frozdt" allowInput="false"/>
                </td>
                <td style="font-size: 12px;text-align: right;">
                   	冻结原因：
                </td>
                <td>
                    <input class="nui-textbox" name="params/pldgrs"/>
                </td>
			<% } %>
			</tr>
			<tr>
                <td style="font-size: 12px;text-align: right;">
                   	申请文书号：
                </td>
                <td>
                    <input class="nui-textbox" name="params/aplyno"/>
                </td>
                <td style="font-size: 12px;text-align: right;">
                  	批准文书号：
                </td>
                <td>
                    <input class="nui-textbox" name="params/audtno"/>
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
            <div id="eqbPldggrid" dataField="pldgs" class="nui-datagrid" style="width:100%;height:100%;"
            	 url="com.sunline.sunfi.sunfi_eq.eqbpldgbiz.queryEqbpldgss.biz.ext"  pageSize="10"  showPageInfo="true" onrowdblclick="onOk">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
                    <div type="checkcolumn">选择</div>
		            <div field="eqbkno" headerAlign="center" allowSort="true">股权编号</div>    
		            <div field="bsnsdt" headerAlign="center" allowSort="true">业务日期</div>
		            <div field="bsnssq" headerAlign="center" allowSort="true">业务流水</div>
		            <div field="shhdcd" headerAlign="center" width="0">股东代码</div>
		            <div field="shhdna" headerAlign="center" width="0">股东名称</div>
		            <div field="dcmtno" headerAlign="center" width="0">凭证号码</div>
		            <div field="ecmytp" headerAlign="center" width="0" renderer="renderEcmytp">经济性质</div>
		            <div field="eqbktp" headerAlign="center" width="0" renderer="renderEqbktp">股权类型</div>
		            <div field="stcknm" headerAlign="center" dataType="int" width="0">持股数</div>
		            <div field="stckam" headerAlign="center" dataType="int" width="0">持股金额</div>
		            <div field="unfznm" headerAlign="center" dataType="int" width="0">解冻股数</div>
		            <% if("19".equals(opratp)) { %>
		        	<div field="pldgdt" headerAlign="center" allowSort="true" renderer="renderEntcdt">质押日期</div>
		        	<div field="pldgnm" headerAlign="center" allowSort="true" dataType="int" align="right">质押股数</div>	
		        	<div field="unpldt" headerAlign="center" allowSort="true" renderer="renderUnpldt">约定解质押日期</div>
		        	<div field="pldgrs" headerAlign="center" allowSort="true">质押原因</div>
		        	<% }else if("21".equals(opratp)){ %>
		        	<div field="pldgdt" headerAlign="center" allowSort="true" renderer="renderEntcdt">冻结日期</div>
		        	<div field="froznm" headerAlign="center" allowSort="true" dataType="int" numberFormat="n" align="right">冻结股数</div>
		        	<div field="unpldt" headerAlign="center" allowSort="true" renderer="renderUnpldt">约定解冻结日期</div>
		        	<div field="pldgrs" headerAlign="center" allowSort="true">冻结原因</div>
		            <% } %>
		            <div field="aplyno" headerAlign="center" allowSort="true">申请文书号</div>               
		        	<div field="audtno" headerAlign="center" allowSort="true">批准文书号</div>
		        	<div field="remark" headerAlign="center" allowSort="true">备注</div>
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
            var grid = nui.get("eqbPldggrid");    
            var param={ params :{ pldgst : "${pldgst}" , frozst : "${frozst}" , opratp : "${opratp}"}};
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

            function renderEqbktp(e) {
				return nui.getDictText("FI_EQBKTP",e.row.eqbktp);
            }
            function renderEcmytp(e) {
				return nui.getDictText("FI_ECMYTP",e.row.ecmytp);
            }
            function renderUnpldt(e) {
	            var value = e.value;
	            var date=nui.parseDate(value);
	            if (value) 
	               return nui.formatDate(date, 'yyyy-MM-dd');
	            return "";
            } 
        </script>    
	</body>
</html>
