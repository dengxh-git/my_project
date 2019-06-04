<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-12-05 10:58:26
  - Description:
-->
<head>
<title>combrch_manager</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div id="layout1" class="nui-layout" style="width:100%;height:100%;">
	<div id="region1" region="west" title="机构信息管理" showHeader="true" class="sub-sidebar" 
	width="240" allowResize="false">
			<ul id="tree1" class="nui-tree" url="com.sunline.sunfi.sunfi_cm.combrchbiz.queryComBrchTreeNode.biz.ext" 
			style="width:98%;height:98%;padding:5px;" showTreeIcon="true" textField="text" idField="id" resultAsTree="false" 
			parentField="pid" showTreeLines="true" onnodeclick="onNodeClick" allowDrag="true" allowDrop="true" dataField="data"
			contextMenu="#brchTreeMenu" onbeforeload="onBeforeTreeLoad" style="background:#fafafa;">
	    	</ul>
	    	<ul id="brchTreeMenu" class="nui-contextmenu"  onbeforeopen="onBeforeOpen">
			</ul>
    </div>
    <div title="center" region="center" style="border:0;">
    	<!--Tabs-->
       <div id="brchtabs" class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div name="brch_list_tab"
		    title="机构信息列表" url="<%=request.getContextPath() %>/sunfi_cm/brch/combrch_list.jsp" visible="true" >
		    </div>
		</div>
	</div>
</div>


<script type="text/javascript">
    nui.parse();
    var tree = nui.get("tree1");
    function onBeforeTreeLoad(e) {
		e.params.nodeType = e.node.type;
		e.params.nodeId = e.node.realId;
    }
	var brch_list  = { title: '机构信息列表', path: '<%=request.getContextPath() %>/sunfi_cm/brch/combrch_list.jsp' };
	var brch_info  = { title: '机构信息', path: '<%=request.getContextPath() %>/sunfi_cm/brch/combrch_info.jsp' };	
	var brchtabs_map = {};
	brchtabs_map["root"] = [brch_list];
	brchtabs_map["brch"] = [brch_info];
	brchtabs_map["duty"] = [brch_info];
	function setUrlParam(url,params){
		if(!url){
			return url;
		}
		var paramsStr = [];
		for(var prop in params){
			paramsStr.push(prop + "=" + params[prop]);
		}
		if(url.indexOf("?")>=0){
			return url + "&" + paramsStr.join("&");
		}else{
			return url + "?" + paramsStr.join("&");
		}
	
	}
	
	function refreshTab(node){
		var tabs = nui.get("brchtabs");
		var brchtabs = brchtabs_map[node.type];
		for(var i=0;i<brchtabs.length;i++){
			var obj = brchtabs[i];
			obj.url = setUrlParam(obj.path,node);
		}
		tabs.setTabs(brchtabs);
	}
	//树左键点击触发事件
	function onNodeClick(e){
		var node = e.node;
		refreshTab(node);
	}
	
	function addbrch(){
		nui.open({
            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_add.jsp?brchtp=0000",
            title: "新增法人机构", 
            width: 800, 
            height: 300,
            allowResize:false,
            ondestroy: function (action) {
            	if (action == "saveSuccess") {
            		var node = tree.getSelectedNode();
                	tree.selectNode(node);
                	refreshTab(node);
                	refresh();
                }
            }
        });
	}
	
	function addduty(){
		nui.open({
            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_add.jsp?brchtp=0001",
            title: "新增责任中心", 
            width: 800, 
            height: 300,
            allowResize:false,
            ondestroy: function (action) {
	        	if (action == "saveSuccess") {
	        		var node = tree.getSelectedNode();
	            	tree.selectNode(node);
	            	refreshTab(node);
	            	refresh();
	            }
            }
        });
	}
	function editbrch(){
		nui.open({
            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_edit.jsp",
            title: "修改法人机构", 
            width: 800, 
            height: 300,
            onload: function () {
            	var node = tree.getSelectedNode();
           		var data = {brchcd:node.realId,brchtp:"0000"};
            	var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(data);
            },
            ondestroy: function (action) {
                if (action == "saveSuccess") {
                	var node = tree.getSelectedNode();
                	tree.selectNode(node);
                	refreshTab(node);
                	refreshParentNode();
                }
            }
        });
	}
	function editduty(){
		nui.open({
            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_edit.jsp",
            title: "修改责任中心", 
            width: 800, 
            height: 300,
            onload: function () {
            	var node = tree.getSelectedNode();
           		var data = {brchcd:node.realId,brchtp:"0001",sprrcd:(node.pid).substr()};
            	var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(data);
            },
            ondestroy: function (action) {
                if (action == "saveSuccess") {
                	var node = tree.getSelectedNode();
                	tree.selectNode(node);
                	refreshTab(node);
                	refreshParentNode();
                }
            }
        });
	}			
	function refresh(){
		var node = tree.getSelectedNode();
		if(!node){
			node = tree.getNode("root_root");
		}
		tree.loadNode(node);
	}
	
	function refreshParentNode(){
		var node = tree.getSelectedNode();
		var parentNode = tree.getParentNode(node);
	    tree.loadNode(parentNode);
	    tree.selectNode(parentNode);
	    refreshTab(parentNode);
		
	}
	//应用功能树右键菜单
	function onBeforeOpen(e) {
	    var obj = e.sender;
	    var node = tree.getSelectedNode();
	    if (!node) {
	        e.cancel = true;
	        return;
	    }
	    
	    if(node.type=="root"){
	    	var array = [{id: "addbrch", text: "新建机构", iconCls:"icon-add", onclick:"addbrch"},
						{id: "separator", text: "", cls:"mini-separator"},
						{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refresh"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);
	    }
	    
	    if(node.type=="brch"){
	    	var array = [{id: "addduty", text: "新建责任中心", iconCls:"icon-add", onclick:"addduty"},
						{id: "separator", text: "", cls:"mini-separator"},
						{id: "editbrch", text: "修改法人机构", iconCls:"icon-edit", onclick:"editbrch"},
						{id: "separator", text: "", cls:"mini-separator"},
						{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refresh"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);			
	    }
	    if(node.type=="duty"){
	    	var array = [{id: "editbrch", text: "修改责任中心", iconCls:"icon-edit", onclick:"editduty"},
						{id: "separator", text: "", cls:"mini-separator"},
						{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refresh"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);			
	    }	    	    
	}
</script>
</body>
</html>