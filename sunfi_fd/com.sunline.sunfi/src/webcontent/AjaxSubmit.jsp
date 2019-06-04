<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
	//获取标签中使用的国际化资源信息
	String waitinfo = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.waitinfo");   //系统正在处理中，请稍候......
 %>
<!--如下两个div标签用于提交过程中屏蔽页面内容-->
<div id="div_message" class="title" style="position:absolute;top:0px;FILTER: alpha(opacity=30);background-color:#000000;color:#000000; z-index:2; left: 0px;display:"none";"></div>
<div id="div_layer" align="center" style="position:absolute; z-index:3; width: 400; left:expression((document.body.offsetWidth-400)/2); top: expression((document.body.offsetHeight-170)/2);font-size:14px;font-weight:bolder;background-color:#ffffff;display:none;" valign="center">
	<%=waitinfo %>  
</div>
<script language="javascript">
 function showLayer()
 {
     document.getElementById("div_message").style.width="100%";
	 document.getElementById("div_message").style.height="100%";
	 document.getElementById("div_message").style.display="block";
	 document.all.div_layer.style.display="block";
 }  

 function hiddenLayer()
 {
     document.getElementById("div_message").style.display="none";
     document.all.div_layer.style.display="none";
 }
</script>
