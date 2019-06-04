<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-12-28 15:45:34
- Description:
    --%>
    <head>
        <title>
            待办
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body>   
    <div id="tabs" class="nui-tabs bg-toolbar" activeIndex="0" style="width:100%;height:100%; border: 0" plain="false">
    <div title="待办事项" refreshOnClick="true" url="<%=request.getContextPath() %>/sunfi_wf/listwork/unfinshedtask_list.jsp"></div>       
    <div title="已办事项" refreshOnClick="true" url="<%=request.getContextPath() %>/sunfi_wf/listwork/finshedtask_list.jsp"></div> 
</div>           
</body>
</html>
