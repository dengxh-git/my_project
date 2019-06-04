<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <head>
        <title>
            	选择列表
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%
        	String shhdcd=request.getParameter("shhdcd");
        	request.setAttribute("shhdcd", shhdcd);
        %>
    </head>
<html>
<body>
        <div id="form1" class="nui-form" style="height: 10%">
            <table id="table1" class="table" style="height:100%;width:100%;">
                <tr>
                    <td style="font-size: 12px;text-align: right;">
                       	股东代码：
                    </td>
                    <td>
                        <input class="nui-textbox" name="param/shhdcd" value="${shhdcd}"/>
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
                <div id="eqpshhdgrid" dataField="eqpshhds" class="nui-datagrid" style="width:100%;height:100%;"
                	 url="com.sunline.sunfi.sunfi_eq.eqpshhdbiz.queryAllEqpShhd.biz.ext?param/shhdcd=${shhdcd}"  pageSize="10" 
                     showPageInfo="true" onrowdblclick="onOk">
			        <div property="columns">
			            <div type="indexcolumn" width="50px">序号</div>
                        <div type="checkcolumn">选择</div>
			        	<div field="shhdcd" headerAlign="center" allowSort="true">股东代码</div>
			        	<div field="shhdna" headerAlign="center" allowSort="true">股东名称</div>
			        	<div field="grupcd" headerAlign="center" allowSort="true">股东组代码</div>
			        	<div field="shhdtp" headerAlign="center" allowSort="true" renderer="renderShhdtp">股东类型</div>
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
            var grid = nui.get("eqpshhdgrid");
            grid.load();

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

            function renderShhdtp(e) {
				return nui.getDictText("FI_SHHDTP",e.row.shhdtp);
            }
            
           </script>    
</body>
</html>