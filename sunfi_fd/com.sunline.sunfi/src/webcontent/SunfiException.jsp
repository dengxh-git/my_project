<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common.jsp"%>
<style>
body{
	font:12px Arial, Helvetica, sans-serif;
	color:#424242;
	margin:0 auto;
	padding:0;
}
.error-container{
	width:100%;
	height:100%;
	overflow:hidden;
	position:relative；
}
.error{
	position:absolute;
	top:20px;
	left:25%;
	margin: 100px auto;
	background:url(<%=contextPathStr %>/common/skins/<%=_headskin %>/images/error.jpg) no-repeat;
	width:669px;
	height:360px;
}
.error-top {
	margin:100px 50px 100px 200px;
	
}
.error-font {
	font-weight:700;
	font-size: 14px;
	
}
.button1, .button2{
	display:black;
	width:102px;
	height:33px;
	margin-right:5px;
	border:0;
	font-size:12px;
}
.button1{
	background: url(<%=contextPathStr %>/common/skins/<%=_headskin %>/images/inquiry.gif) 0 center no-repeat;
}
.button2{
	background: url(<%=contextPathStr %>/common/skins/<%=_headskin %>/images/inquiry2.gif) 0 center no-repeat;
	color:#222;
}
</style>
<%@page import="com.sunline.sunfi.bus.FIException"%>
<%@page import="com.eos.system.exception.EOSException"%>
<%@page import="com.eos.system.exception.EOSRuntimeException"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<html>
<%

    Object eobj =request.getAttribute("_exception");
    String errorCode = null;
    String errorMsg = null;
    boolean isFIException = false;
    boolean isEosException = false;
    if (eobj instanceof FIException) {
    	FIException fie = (FIException)eobj;    
        errorCode = fie.getErrorCode();   
        errorMsg = fie.getErrorMessage();
        isFIException = true;
    } else if (eobj instanceof EOSException) {
    	EOSException eose = (EOSException)eobj;
        Throwable t = eose.getException();
        if(t instanceof FIException){
        	FIException fie = (FIException)t;    
        	errorCode = fie.getErrorCode();   
        	errorMsg = fie.getErrorMessage();
        	isFIException = true;
        }else{
        	errorCode = eose.getCode();    
        	errorMsg = eose.getMessageOnly(DataContextManager.current().getCurrentLocale());
        }
        isEosException = true;
    } else if (eobj instanceof com.eos.system.exception.EOSRuntimeException) {
        EOSRuntimeException eosre = (EOSRuntimeException)eobj;
        errorCode = eosre.getCode();
        errorMsg = eosre.getMessageOnly(DataContextManager.current().getCurrentLocale());
    }
	//详细错误信息
	String l_error_info = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_error_info");
	//错误提示信息
	String l_error_promote = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_error_promote");
	//联系信息提示
	String l_contact_promote = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_contact_promote");
	//无权限信息提示
	String l_no_permission = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_no_permission");
	//堆栈错误提示
	String l_stack_promote = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_stack_promote");
	
	
 %>
<body>
  <div class="error-container">
	<div class="error">
    	<div class="error-top">
        	<span class="error-font"> <!-- 只有errorCode以msg结尾才需要国际化 -->
        	<%if(isFIException){ %>
				 <%=errorMsg %>
		  	<%}else if(isEosException){ 
		  		if(errorCode.endsWith("msg")){
		  	%> 
		  		<b:message key="<%=errorMsg %>"/>
		  	<%
		  		}else{
		  	%> 	
		  			<%=errorMsg %>
		  	<%	
		  		}
			}else{ %>
		  		<%= l_error_promote %>，<%=l_contact_promote %>！
		  	<%} %>
        	</span>
        </div>
		<div align="center" style="padding-left:60px;">
		  <input type="submit" value="<b:message key="l_back"/>" id="validate_btn" name="method:confirm"  onclick="javascript:history.go(-1);" onmouseover="this.className='button2'" onmouseout="this.className='button1'" class="button1" />
		  <input type="submit" value="<b:message key="l_print"/>" id="validate_btn" name="method:confirm" onclick="javascript:print();" onmouseover="this.className='button2'" onmouseout="this.className='button1'" class="button1" />
		  <input type="submit" value="<b:message key="l_mailto"/>" id="validate_btn" name="method:confirm" onclick="javascript:window.location.href='mailto:'" onmouseover="this.className='button2'" onmouseout="this.className='button1'" class="button1" />
		</div>
    </div>
  </div>
  <%if(!isFIException){ %>
    <w:panel id="e" title="<%=l_stack_promote %>" expand="false">
      <h:exception showStacktrace="true"/>
    </w:panel>
  <%} %>
</body>
<script>

window.onload= function(){ 
	try{
		unMaskTop(); 
	}catch(e){	}
}
</script>
<script language="javascript">
    //初始化页面按钮样式
     eventManager.add(window, "load", initButtonStyle); 
</script>
</body>
</html>
