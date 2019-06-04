<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow/base" prefix="wfBase"%>
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/Graphic.js"></script>
<%
	String wkflid = request.getParameter("wkflid");
	request.setAttribute("wkflid", wkflid);
 %>
<title>标签显示</title>
<script type="text/javascript">
	 nui.parse();
</script>
</head>
<body>
	<wfBase:processGraph processInstID="@wkflid" zoomQuotiety="1" >
	</wfBase:processGraph>
</body>
</html>
