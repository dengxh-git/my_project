<%@page import="com.primeton.ext.engine.component.LogicComponentFactory"%>
<%@page import="com.eos.engine.component.ILogicComponent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  %>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@page import="com.sunline.sunfi.util.UrlTools"%>
  
    <%-- <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/tripledes2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/cipher-core.js"></script> --%>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/tripledes2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/cipher-core.js"></script>  
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/core.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/mode-ecb.js"></script> 
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/3des/md5.js"></script>
    <%
    IMUODataContext muo = DataContextManager.current().getMUODataContext();
	IUserObject userobjectUrlFilter = muo.getUserObject();
	//UrlTools.getRandom(26);
	String radm=(String) userobjectUrlFilter.get("sigCache");
	if(("").equals(radm)||radm==null){
		Object[] result = null;
		String componentName = "com.sunline.sunfi.util.enDecrypt";
		String operationName = "updateEmpRandom_ems";
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		int size = 2;
		// 逻辑流的输入参数
		Object[] params = new Object[size];
		params[0]=null;
		params[1]="EMS";
		try{
			result = logicComponent.invoke(operationName, params);
			radm=result[1].toString();
			System.out.println("重新获取加密字符串："+radm);
		}catch(Throwable a){
		}
	}else{}
	%>


	<script type="text/javascript">
    	function encryptByDES(mess) {  
    		var message=mess+"<%=radm %>";
    		var key="abcdefghabcdefghabcdefghabcdefgh";
            var keyHex = CryptoJS.enc.Utf8.parse(key);  
            var encrypted = CryptoJS.DES.encrypt(message, keyHex, {    
            mode: CryptoJS.mode.ECB,    
            padding: CryptoJS.pad.Pkcs7    
            });   
            return encrypted.toString();    
    	} 
    </script>