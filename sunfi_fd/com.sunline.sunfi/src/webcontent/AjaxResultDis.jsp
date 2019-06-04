<%@page pageEncoding="UTF-8"%>
<%@include file="/common.jsp"%>

<html>
<!-- 
  - Author(s): 熊哲昆
  - Date: 2012-03-23 01:29:42
  - Description:
-->
<head>
<title>AjaxResultDis</title>
</head>
<body onload='init();'>
 <table width="100%">
 	<tr>
 		<td >
 			<br/><br/>
 		</td>
 	</tr>
 	<tr>
 		<td id="inArg" >
 			
 		</td>
 	</tr>
 	<tr>
 		<td align="center">
 			<br/>
 			<input type="button" value='<b:message key="bmgd.public.close"/>' onclick="closeaa()" class="button">
 		</td>
 	</tr>
 </talbe>
</body>
</html>

<script language="JavaScript">
        function init(){
            //取得主页面传过来的参数
            var paraArray= window["dialogArguments"].split(",");
            
            if(null==paraArray || paraArray.length<2){
            	var td=$id("inArg");
            	td.innerHTML="解析结果错误";
            	return;
            }

            if("1"==paraArray[0]){
            	var key=paraArray[1];

            	var params=new Array(paraArray.length-1);
				
				//调用逻辑流
				myAjax = new Ajax("com.sunline.sunfi.util.resourcesmessage.getI18nResourceMessageWithPara.biz");
				
				var i=0;
				for(i=0;i<paraArray.length;i++){
					myAjax.addParam('params['+i+"]",paraArray[i+2]);
				}            		
           		myAjax.addParam('key',key);
           		
            	//开始调用
				myAjax.submit();
				//取得调用后的结果(xml对象)
				var returnNode =myAjax.getResponseXMLDom();
				var message = myAjax.getValue("/root/data/message");
            
            	var td=$id("inArg");
            	td.innerHTML=message;
            }else if("2"==paraArray[0]){
            	var key=paraArray[1];

            	//调用逻辑流
				myAjax = new Ajax("com.sunline.sunfi.util.resourcesmessage.getI18nResourceMessage.biz");	
           		myAjax.addParam('key',key);
            	//开始调用
				myAjax.submit();
				//取得调用后的结果(xml对象)
				var returnNode =myAjax.getResponseXMLDom();
				var message = myAjax.getValue("/root/data/message");
            
            	var td=$id("inArg");
            	td.innerHTML=message;
            }else if("3"==paraArray[0]){
            	var message =paraArray[1];
            	var td=$id("inArg");
            	td.innerHTML=message;
            }

        }
		
		function closeaa(){
			 window.close()

		}

		
</script>

