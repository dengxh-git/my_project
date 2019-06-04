<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-12-28 11:10:24
  - Description:
-->
<head>
<%
 String rolecode = request.getParameter("rolecode");
 request.setAttribute("rolecode", rolecode);

 %>
<title>selectParticipant</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
     <div id="master.islead" name="master.islead" class="nui-checkbox" checked="true" readOnly="false" text="是否领导审批" onvaluechanged="onValueChanged"></div>
     <table >
        <tr>
            <td >
                <div id="grid1" class="nui-datagrid" style="width:180px;height:200px;"
                    idField="id" multiSelect="true" dataField="Participant"
                    url="com.sunline.sunfi.sunfi_wf.participant.getParticipant.biz.ext" resultAsData="true" showPager="false">
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div header="国家" field="id"></div>
                        <div header="国家" field="name"></div>
                    </div>
                </div>
            </td>
            <td style="width:60px;text-align:center;">
                <input type="button" value=">" onclick="add()" style="width:40px;"/><br />
                <input type="button" value=">>" onclick="addAll()" style="width:40px;"/><br />
                <input type="button" value="&lt;&lt;" onclick="removeAll()" style="width:40px;"/><br />
                <input type="button" value="&lt;" onclick="remove()" style="width:40px;"/><br />

            </td>
            <td>
                <div id="grid2" class="nui-datagrid" style="width:250px;height:200px;"                     
                    idField="id"  multiSelect="true" showPager="false"
                    allowCellEdit="true" allowCellSelect="true" >
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div header="ID" field="id" width="30"></div>
                        <div header="国家" field="NAME">
                            <input property="editor" class="nui-textbox" style="width:100%"/>
                        </div>
                    </div>
                </div>
            </td>
            <td style="width:50px;text-align:center;vertical-align:bottom">
                <input type="button" value="Up" onclick="upItem()" style="width:55px;"/>
                <input type="button" value="Down" onclick="downItem()" style="width:55px;"/>

            </td>
        </tr>
    
    </table>  

	<script type="text/javascript">
    	nui.parse();
    	var grid1 = nui.get("grid1");
    	grid1.load({rolecode:'${rolecode}'});
    </script>
</body>
</html>