<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//获取标签中使用的国际化资源信息
String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
%>
<head>
    <title>
        	选择列表
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%
        	String dcmtst1=request.getParameter("param/dcmtst1");
        	String dcmtst2=request.getParameter("param/dcmtst2");
        	String isView=request.getParameter("param/isView");
        	
        	request.setAttribute("dcmtst1", dcmtst1);
        	request.setAttribute("dcmtst2", dcmtst2);
        	request.setAttribute("isView", isView);
        %>    
</head>
<html>
<body>
        <div id="form1" class="nui-form" style="height: 10%">
                <table id="table1" class="table" style="height:100%;width:100%;">
                    <tr>
                        <td style="font-size: 12px;text-align: right;">
                           	凭证号码：
                        </td>
                        <td>
                            <input class="nui-textbox" name="param/dcmtno"/>
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                          	股东名称：
                        </td>
                        <td>
                            <input class="nui-textbox" name="param/shhdna"/>
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                          	证件号码：
                        </td>
                        <td>
                            <input class="nui-textbox" name="param/idcard"/>
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
                <div id="eqddcmtgrid" dataField="eqddcmts" class="nui-datagrid" style="width:100%;height:100%;"
                	 url="com.sunline.sunfi.sunfi_eq.eqddcmtbiz.queryEqdDcmtDetls.biz.ext" pageSize="10" 
                     showPageInfo="true" onrowdblclick="onOk">
			        <div property="columns">
			            <div type="indexcolumn" width="50px">序号</div>
                        <div type="checkcolumn">选择</div>
			            <div field="dcmtno" headerAlign="center" allowSort="true">凭证号码</div>               
			        	<div field="dcmtst" headerAlign="center" allowSort="true" renderer="renderDcmtst">凭证状态</div>
			        	<div field="opendt" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" renderer="renderOpendt">发证日期</div>
			        	<div field="opensq" headerAlign="center" allowSort="true">发证流水</div>
			        	<div field="shhdcd" headerAlign="center" allowSort="true">股东代码</div>
			        	<div field="shhdna" headerAlign="center" allowSort="true">股东名称</div>
			        	<div field="idcard" headerAlign="center" allowSort="true">证件号码</div>
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
            var grid = nui.get("eqddcmtgrid");
            var param={ "param/dcmtst1" : "${dcmtst1}" , "param/dcmtst2" : "${dcmtst2}" , "param/isView" : "${isView}" };
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
            function renderDcmtst(e){
         		return nui.getDictText("FI_DCMTST", e.row.dcmtst);
      		} 
           function renderOpendt(e) {
            var value = e.value;
            var date=nui.parseDate(value);
            if (value) 
               return nui.formatDate(date, 'yyyy-MM-dd');
            return "";
      		}   
           </script>    
</body>
</html>