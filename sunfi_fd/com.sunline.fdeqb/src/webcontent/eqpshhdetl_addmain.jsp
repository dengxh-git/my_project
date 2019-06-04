<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ym
  - Date: 2019-05-14 10:28:49
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    body{
        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
    }    
    </style>
    
</head>
<body>
	<div class="nui-fit">
	    <div id="tabs" class="nui-tabs" activeIndex="0"  style="height:100%">
	        
	    </div>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	
    	function load(data){
    		var tabs = nui.get("tabs");
    		if(data.action=="new"){
	            //add tab
	            var tab1 = {title: "法人股东",url:"./eqpshhdetl_addcp.jsp"};
	            var tab2 = {title: "自然人股东",url:"./eqpshhdetl_addnp.jsp"};
	            tab1 = tabs.addTab(tab1);
	            tab2 = tabs.addTab(tab2);        
	            //active tab
	            tabs.activeTab(tab1);
    		}else if(data.action=="edit"){
    			var arr = [0,1,2,5];
    			data = nui.clone(data);
    			if(data.shhdtp in arr){
    				var tab = {title: "法人股东",url:"./eqpshhdetl_addcp.jsp?action=edit&shhdcd="+data.shhdcd};
    				tab = tabs.addTab(tab);
    				tabs.activeTab(tab);
    			}else{
    				var tab = {title: "自然人股东",url:"./eqpshhdetl_addnp.jsp?action=edit&shhdcd="+data.shhdcd};
    				tab = tabs.addTab(tab);
    				tabs.activeTab(tab);
    			}
    		}
    	}
    	
    	
    </script>
</body>
</html>