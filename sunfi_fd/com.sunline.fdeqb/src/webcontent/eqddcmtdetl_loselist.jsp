<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-05-17 11:12:05
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<style type="text/css">
    html, body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
	<div class="nui-panel" title="股权证挂失登记" iconCls="icon-add" style="width:100%;height:15%;" >
        <div id="form1" class="nui-form" align="center" style="height:100%">
            <!-- 数据实体的名称 -->
            <input class="nui-hidden" name="criteria/_entity" value="com.sunline.fdeqb.eqd.EqdDcmtCards">
            <!-- 排序字段 -->
            <table id="table1" class="table" style="height:100%">
                <tr>
                    <td class="form_label">股东编号:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[1]/shhdcd"/>
                        <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                    </td>
                    <td class="form_label">股东名称:</td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" name="criteria/_expr[2]/shhdna"/>
                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                        <input class="nui-hidden" name=criteria/_expr[2]/_likeRule value="=">
                    </td>
                    <td class="form_label">银行账号状态:</td>
                    <td colspan="1" align="left">
                    	<input class="nui-dictcombobox nui-form-input" name="criteria/_expr[3]/bknost" valueField="dictID" textField="dictName" dictTypeId="FI_BKNOST"/>
                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">股权状态:</td>
                    <td colspan="1" align="left">
                        <input class="nui-dictcombobox nui-form-input" name="criteria/_expr[4]/status" valueField="dictID" textField="dictName" dictTypeId="FI_EQSDST"/>
                        <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                    </td>
                    <td class="form_label">流程状态:</td>
                    <td colspan="1" align="left">
                        <input class="nui-dictcombobox nui-form-input" name="criteria/_expr[5]/transt" valueField="dictID" textField="dictName" dictTypeId="FI_TRANST"/>
                        <input class="nui-hidden" name="criteria/_expr[5]/_op" value="=">
                    </td>
                    <td class="form_label">结束号码:</td>
                    <td colspan="1" align="left">
                    	<a class="nui-button" onclick="search()">查询</a>
            			<a class="nui-button" onclick="reset()">重置</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="nui-panel" title="股权证登记列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
	    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;">
	            <tr>
	            <td style="width:100%;">
	                <a class="nui-button" iconCls="icon-add" onclick="add()">增加</a>
	                <a class="nui-button" iconCls="icon-edit" onclick="edit()">编辑</a>
	                <a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
	            </td>
	            <tr>
	        </table>
	    </div>
	    <div class="nui-fit">
			<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" pageSize="10" showPageInfo="true"
			    url="com.sunline.fdeqb.eqpshhbiz.queryEqpShhDetl.biz.ext" dataField="eqpshhdetls" idField="shhdcd" allowResize="true">
			    <div property="columns">
			        <div type="indexcolumn" ></div>
			        <div type="checkcolumn" ></div>
			        <div field="shhdcd" width="120" headerAlign="center">股东代码</div>
			        <div field="shhdna" width="120" headerAlign="center">股东名称</div>
			        <div field="shhdtp" width="100" headerAlign="center">股东类型</div>
			        <div field="brchcd" width="100" headerAlign="center">所属机构</div>
			        <div field="telpno" width="100" headerAlign="center">联系电话</div>
			        <div field="idcdtp" width="100" headerAlign="center">证件类型</div>
			        <div field="idcard" width="100" headerAlign="center">证件号</div>
			        <div field="bkacno" width="100" headerAlign="center">本行账号</div>
			        <div field="bknost" width="100" headerAlign="center">账号状态</div>
			        <div field="status" width="100" headerAlign="center">股权状态</div>
			        <div field="transt" width="100" headerAlign="center">审批状态</div>
			        <div field="remark" width="100" headerAlign="center">备注</div>
			    </div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>