<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-12-29 09:17:24
  - Description:
-->
<head>
<%
   String wkflid = request.getParameter("wkflid");
   String emstype = request.getParameter("emstype");
   String fileid = request.getParameter("fileid");
   request.setAttribute("wkflid", URLDecoder.decode(wkflid,"UTF-8"));
   request.setAttribute("emstype", URLDecoder.decode(emstype,"UTF-8"));
   request.setAttribute("fileid", URLDecoder.decode(fileid,"UTF-8"));
 %>
 <style type="text/css">
      .mini-textbox-border,
      .mini-textbox-input,
      .mini-buttonedit-border,
      .mini-buttonedit-input,
      .mini-textboxlist-border{
        border:0;background:none;cursor:default;
       }
    </style>
<title>信息管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
    <div class="nui-tabs" id="tabs1" activeIndex="0" style="width:100%;height:100%; border: 0" plain="false">
     <div  title="详细信息" refreshOnClick="false">
     <!-- 基本信息  -->
     <div id="dataform1">
     <!-- 
		     <table style="width: 100%">
		                 
			     <tbody>
				     <tr>
					     <td style="font-size: 12px; text-align: right;">申请人:</td>
					     <td>
					     <input class="nui-hidden" id="master.fileid" name="master.fileid" readonly="readonly"/>
					     <input class="nui-textbox" id="master.userna" name="master.userna" readonly="readonly"/>
					      <input class="nui-hidden" id="master.expodd" name="master.expodd"/>
					     </td>
					     <td style="font-size: 12px; text-align: right;">申请部门:</td>
					     <td>
					     <input class="nui-textbox" id="master.dutyna" name="master.dutyna" readonly="readonly"/>
					     </td>
					     <td style="font-size: 12px; text-align: right;">申请日期:</td>
					     <td>
					     <input class="nui-textbox" id="master.bsnsdt" name="master.bsnsdt" readonly="readonly"/>
					     </td>
					 </tr>
					 <tr>    
					     <td style="font-size: 12px; text-align: right;">申请类型:</td>
					     <td>
					     <input class="nui-textbox" id="master.typena" name="master.typena" readonly="readonly"/>
					     </td>
					     <td style="font-size: 12px; text-align: right;">金额:</td>
					     <td>
					     <input class="nui-textbox" id="master.totlam" name="master.totlam" readonly="readonly"/>
					     </td>
					     <td style="font-size: 12px; text-align: right;">业务流水号:</td>
					     <td>
					     <input class="nui-textbox" style="width: 140px;" id="master.bsnssq" name="master.bsnssq" readonly="readonly"/>
					     <a  id="expbaoxiao" onclick='print()' style='font-size:12px; cursor:pointer;color:#6a9dd4;'>打印报销单</a>
					     </td>
				     </tr>
				     <tr>    
					     <td style="font-size: 12px; text-align: right;">申请事由:</td>
					     <td colspan="3">
					     <input class="nui-textbox" id="master.remark" name="master.remark" readonly="readonly" style="width: 530px;"/>
					     </td>
					     <td style="font-size: 12px; text-align: right;">档案号:</td>
					     <td>
					     <input class="nui-textbox" style="width: 200px;" id="master.transq" name="master.transq" readonly="readonly"/>
					     </td>
				     </tr>
			     </tbody>
		     </table>
     	-->
     </div>
     <!-- 审批记录历史 -->
     <div  class="nui-panel" title="审批记录" style="width: 100%;" showCollapseButton="true">
     <div id="datagrid"  class="nui-datagrid" showPager="false" dataField="WFWorkList" url="com.sunline.sunfi.sunfi_wf.workFlowQuery.queryFinshedWorkItemByProcessInstId.biz.ext">
     <div property="columns">
         <div field="workitemname" headerAlign="center" >审批角色</div>
         <div field="partiname" headerAlign="center" >审批人</div>
         <div field="annota" headerAlign="center" >审批意见</div>
         <div field="starttime" headerAlign="center" visible="false" dateFormat="yyyy-MM-dd HH:mm:ss" >接收时间</div>
         <div field="endtime" headerAlign="center"  dateFormat="yyyy-MM-dd HH:mm:ss" >审批时间</div>
         <div field="workitemid" headerAlign="center"  visible="false">工作项id</div>
         <div field="processinstid" headerAlign="center"  visible="false">流程实例id</div>
    </div>
    </div>
    </div>    
     <!-- 账务信息 -->
     
     <!-- 付款信息 -->

     
     <div  class="nui-panel" title="附件" style="width: 100%;border-bottom: 1px;" showCollapseButton="true">
     	<table class="nui-form-table" align="center"> 
     	 	<tr>
     	 		<td>
     	 			<table class="nui-form-table" align="center" id="filetab"> 
     	 			</table>
     	 		</td>		
     	 	</tr>
     	 	
     	 	
     	 </table>
     </div>
     
     <!--关闭 -->
     <div class="nui-toolbar" id="operate" style="border-bottom:0;padding:0px;">
	     <table style="width:100%;">
            <tr>
                 <td style="text-align:center;">
                            <input class="nui-hidden" name="workitemid" id="workitemid"/>
                            <input class="nui-hidden" name="activityinstid" id="activityinstid"/>
                 			<a class="nui-button" id="before"  onclick="before()">撤回</a>
                            &nbsp;&nbsp;
                            <a class="nui-button"  onclick="showInfo()">详细信息</a>
                            &nbsp;&nbsp;
                            <a class="nui-button"  onclick="closeWin()">
                                	关闭窗口
                            </a>
            </tr>
        </table>    
     </div>     
     </div>   
     <div  title="流程图" refreshOnClick="false" url="<%=request.getContextPath() %>/sunfi_wf/workitem/processGraph.jsp?wkflid=${wkflid}"></div>
    </div> 	
</body>
<script type="text/javascript">
       nui.parse();
       var form  =  new nui.Form("#dataform1");//将普通form转为nui的form
	   var grid = nui.get("datagrid");
	   //详情页面
	   var detailurl = null;
	   var wffiles = null;
		
	   grid.load({wkflid:'${wkflid}'});

		               
		  function closeWin(){
		    window.parent.close();
		  }
     //页面初始化		   
	 $(function(){
	        var data = {wkflid:'${wkflid}',fileid:'${fileid}'};	
			var json = nui.encode(data); 
			//详细信息 
			 $.ajaxFileUpload({
				     url: "com.sunline.sunfi.sunfi_wf.listworkitembiz.getExpInfo.biz.ext",
				     type: 'POST',
					 data: json,
					 fileElementId: '',
					 cache: false,
					 async:false,
					 contentType:'text/json',
				     success: function (text) {
				         var o = nui.decode(text);		
				         form.setData(o); 
				         var totlam = nui.formatNumber(o.master.totlam, "#,0.00");
				         nui.get("master.totlam").setValue(totlam);
                         form.setChanged(false);
                         grid2.load({bsnsdt:o.master.bsnsdt,bsnssq:o.master.bsnssq});
					  }
				   });   
			//附件信息 
	        $.ajax({
				     url: "com.sunline.sunfi.sunfi_wf.uploadfile.queryWfFile.biz.ext",
				     type: 'POST',
					 data: json,
					 cache: false,
					 async:false,
					 contentType:'text/json',
				     success: function (text) {
				     var o = nui.decode(text);			                     
				  
				     //文件不为空
				     if(o.WFFile[0]){  
						      var wffile = [];
						      wffiles = o.WFFile;
						      for(var index=0 ;index<o.WFFile.length ;index++){
						      	wffile =o.WFFile[index];
						      	//alert(wffile.filena);
						      	var filetab = document.getElementById("filetab");
								var otr = filetab.insertRow();  
						        var otd = otr.insertCell();
						        console.log(wffile.flpath);
						        var path = nui.encode(wffile.flpath);
						        otd.innerHTML="<a id='removeFile' href='javascript:void(0);' style='text-decoration: none' onclick='downFlie("+index+")'>"+wffile.filena+"</a>";
						      }
					   }
					  }
				   });
			//判断是否可撤回（费用报销）
			if('${emstype}'=="01"){
			 $("#expbaoxiao").show();
			 //查询是否可撤回
			  $.ajax({
				     url: "com.sunline.sunfi.sunfi_wf.listworkitembiz.queryIsRecall.biz.ext",
				     type: 'POST',
					 data: json,
					 cache: false,
					 async:false,
					 contentType:'text/json',
				     success: function (text) {				        
				         var o = nui.decode(text);
				         //查询不可撤回				        
				         if(o.wfworkitem.length==0){
				            $("#before").hide();
				         }else{
				         	$("#before").show();
				         	var wfworkitem=(o.wfworkitem)[0];
				         	nui.getbyName("workitemid").setValue(wfworkitem.workitemid);
				         	nui.getbyName("activityinstid").setValue(wfworkitem.activityinstid);
				         }
					  }
				   });			
			}else{
			 $("#before").hide();
			 $("#expbaoxiao").hide();
			}      
			
	 
	 });
	 
	    // 下载文件
		function downFlie(fileId){
		var data = {fileId:fileId};
		var json = nui.encode(data); 
		$.ajax({
                url: "com.sunline.sunfi.sunfi_cm.fileUpload.queryFile.biz.ext",
                type: 'POST',
                data: json,
                cache: false,
                async:false,
                contentType:'text/json',
                success: function (text) {
                 var o = nui.decode(text);
                 var filename = o.uploadFiles.fileName;
                 var srcPath = "<%=request.getContextPath() %>/downloadfile.jsp?filePath="+o.uploadFiles.filePath+"&&fileName="+filename;
		         window.open(srcPath);   					
                  }
                 });    					
		}	
		
		function showInfo(){
			 getDetailLink();
			 var tabs = nui.get("tabs1");
			 var url ="";
			 url = "<%= request.getContextPath() %>"+detailurl;//股权证登记
			 //url +="?wkflid=${wkflid}";
			 var tab = {title: "详细信息",showCloseButton:true,url:url};
		     tab = tabs.addTab(tab);     
			 tabs.activeTab(tab);
	   };
	   
	      //打印报销单号
		 function print(){
		  var jaspername= "exprgstPrint";
		  var expodd = nui.get("master.expodd").getValue();	      
		  var totlam = nui.get("master.totlam").getValue(); 
		  var data={jaspername:jaspername,expodd:expodd,totlam:totlam};
		  var json = nui.encode({params:data}); 
		  $.ajax({
	                url: "com.sunline.sunfi.sunfi_cm.comm.expPrint.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                async:false,
	                contentType:'text/json',
	                success: function (text) {
	                 var o = nui.decode(text);
		                 if(o.exception == null){
		                 var filepath = o.filepath;
			               if(filepath!=null&&filepath!=""){		    	     
					    	   var tempsrc = "<%= request.getContextPath() %>/sunfi_cm/com/IReportPrintPdf.jsp?isprnt=true&filePath=" + filepath;
					    	    window.open(tempsrc);			       
					    	 } 
		                 }else{
		                  nui.alert("打印报销单错误!","提示");
		                 }
	                  					
	                  }
	                 }); 
		 }
		//撤回
		function before(){
		var data = {wkflid:'${wkflid}',workitemid:nui.getbyName("workitemid").getValue(),activityinstid:nui.getbyName("activityinstid").getValue()};
		var json = nui.encode(data); 
		nui.confirm("你确定要撤回?", "系统提示", function(action){
				 if(action=="ok"){
					$.ajax({
	                url: "com.sunline.sunfi.sunfi_wf.listworkitembiz.beforeToCreator.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                async:false,
	                contentType:'text/json',
	                success: function (text) {
	                 var o = nui.decode(text);
			             if(o.result=="0"){
			             	nui.alert("撤回失败","提示");
			             }else if(o.result=="1"){
			             	nui.alert("撤回成功!","提示",function(action){
			             	  window.parent.close();
			             	});
			             }
	                  }
		          });
				 }
			});
		}  
		
	function getDetailLink(){
	 	var data = {wkflid:'${wkflid}'};
	 	var json = nui.encode(data);
	 	$.ajax({
	 		url:"com.sunline.sunfi.sunfi_wf.workFlowQuery.queryWorkLnkrl.biz.ext",
	 		type: 'POST',
                data: json,
                cache: false,
                async:false,
                contentType:'text/json',
            success:function(text){
            	var o = nui.decode(text);
            	detailurl=o.lnkurl;
            }
	 	});
	 }
	 
	 // 下载文件
		function downFlie(index){
			var wffile = wffiles[index];
			var srcPath = "<%=request.getContextPath() %>/downloadfile.jsp?filePath="+wffile.flpath+"&&fileName="+wffile.filena;
		    window.open(srcPath); 					
		}
    </script>
</html>