<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-04 14:12:48
  - Description:
-->
<%
   String wkflid = request.getParameter("wkflid");
   String wfitid = request.getParameter("wfitid");
   request.setAttribute("wkflid", URLDecoder.decode(wkflid,"UTF-8"));
   request.setAttribute("wfitid", URLDecoder.decode(wfitid,"UTF-8"));
 %>
<head>
<%@include  file="/common.jsp"%>
<title>information</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
      .mini-textbox-border,
      .mini-textbox-input,
      .mini-buttonedit-border,
      .mini-buttonedit-input,
      .mini-textboxlist-border{
        border:0;background:none;cursor:default;
       }
    </style>
</head>
<body>
   <!-- 基本信息  -->
     <div id="dataform1">
     <table style="width: 100%">
                 
	     <tbody>
		     <tr>
			     <td style="font-size: 12px; text-align: right;">申请人:</td>
			     <td>
			     <input class="nui-hidden" id="master.fileid" name="master.fileid" readonly="readonly"/>
			     <input class="nui-textbox" id="master.userna" name="master.userna" readonly="readonly"/>
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
			     <input class="nui-textbox" style="width: 200px;" id="master.bsnssq" name="master.bsnssq" readonly="readonly"/>
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
     </div>
     <!-- 审批记录历史 -->
     <div  class="nui-panel" title="审批记录" style="width: 100%;" showCollapseButton="true">
     <div id="datagrid"  class="nui-datagrid" showPager="false" dataField="WFWorkList" url="com.sunline.sunfi.sunfi_wf.listworkitembiz.queryProcessLogs.biz.ext">
     <div property="columns">
         <div field="workitemname" headerAlign="center" >审批角色</div>
         <div field="partiname" headerAlign="center" >审批人</div>
         <div field="messag" headerAlign="center" >审批意见</div>
         <div field="starttime" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" >接收时间</div>
         <div field="endtime" headerAlign="center"  dateFormat="yyyy-MM-dd HH:mm:ss" >审批时间</div>
         <div field="workitemid" headerAlign="center"  visible="false">工作项id</div>
         <div field="processinstid" headerAlign="center"  visible="false">流程实例id</div>
    </div>
    </div>
    </div>    
     <!-- 账务信息 -->
     <div  class="nui-panel" title="账务信息" style="width: 100%;" showCollapseButton="true" expanded="false">
     <div id="datagrid1" class="nui-datagrid" onload="onLoad" showModified="false" showPager="false" dataField="expAeuvDetl" url="com.sunline.sunfi.sunfi_wf.listworkitembiz.queryExpAeuvDetl.biz.ext">
     <div property="columns">
        <div field="dutyna"  headerAlign="center" >责任中心</div>
        <div field="itemna"  headerAlign="center" >科目名称</div>
        <div field="tranamC" headerAlign="center"  decimalPlaces="2" dataType="currency" currencyUnit="">借方金额</div>
        <div field="tranamD" headerAlign="center"  decimalPlaces="2" dataType="currency" currencyUnit="">贷方金额</div>
        <div field="smrytx"  headerAlign="center" >备注</div>
        <div field="tranam"  headerAlign="center"  visible="false">金额</div>
        <div field="amntcd"  headerAlign="center"  visible="false">借贷方向</div>
        <div field="wkflid"  headerAlign="center"  visible="false">流程实例id</div>
     </div>
     </div>
     </div>
      <!-- 付款信息 -->
     <div  class="nui-panel" title="付款信息" style="width: 100%;" showCollapseButton="true" expanded="false">
     <div id="datagrid2" class="nui-datagrid" showModified="false" showPager="false" dataField="payments" url="com.sunline.sunfi.sunfi_wf.listworkitembiz.queryPayMent.biz.ext">
     <div property="columns">
        <div field="acctna"  headerAlign="center">付款账户</div>
        <div field="acctno"  headerAlign="center">付款账号</div>
        <div field="suppna" headerAlign="center">收款人</div>
        <div field="cardnu" headerAlign="center">收款账户</div>
        <div field="brname"  headerAlign="center">开户行</div>
        <div field="bnmtam"  headerAlign="center" decimalPlaces="2" dataType="currency" currencyUnit="">金额</div>
     </div>
     </div>
     </div>
     
     <div  class="nui-panel" title="附件" style="width: 100%;border-bottom: 1px;" showCollapseButton="true">
     <div id="showUpload"></div>
     </div>
     
     <!--关闭 -->
     <div class="nui-toolbar" id="operate" style="border-bottom:0;padding:0px;">
	     <table style="width:100%;">
            <tr>
                 <td style="text-align:center;">
                            <a class="nui-button" id="close" iconCls="icon-close" onclick="showInfo()">详细信息</a>
                            &nbsp;&nbsp;
                            <a class="nui-button" id="close" iconCls="icon-close" onclick="closeWin()">
                                	关闭窗口
                            </a>
            </tr>
        </table>    
     </div>
	<script type="text/javascript">
       nui.parse();
       var form  =  new nui.Form("#dataform1");//将普通form转为nui的form
	   var grid = nui.get("datagrid");
	   var grid1 = nui.get("datagrid1");
	   var grid2 = nui.get("datagrid2");
	   grid.load({wkflid:'${wkflid}'});
	   grid1.load({wkflid:'${wkflid}'});	  
	   function onLoad(){
		                var rows = grid1.getData();
		                 for (var i = 0, l = rows.length; i < l; i++){
		                    var row = rows[i];
		                    if(row.amntcd=="C"){
		                    grid1.updateRow(row,{
			                    tranamC:row.tranam
			                    });
			                }
			                if(row.amntcd=="D"){
		                    grid1.updateRow(row,{
			                    tranamD:row.tranam
			                    });
			                }
			               grid1.updateRow(row,{
			                    dutyna:row.dutyna +"("+row.dutycd+")"
			                    });
			               grid1.updateRow(row,{
			                    itemna:row.itemna +"("+row.itemcd+")"
			                    });           
		                 }
		               };
		               
		  function closeWin(){
		    window.parent.close();
		  }
     //页面初始化		   
	 $(function(){
	        var data = {wkflid:'${wkflid}'};	
			var json = nui.encode(data); 
			//详细信息
			 $.ajax({
				     url: "com.sunline.sunfi.sunfi_wf.listworkitembiz.getExpInfo.biz.ext",
				     type: 'POST',
					 data: json,
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
				     url: "com.sunline.sunfi.sunfi_wf.listworkitembiz.queryFileForProcessinstid.biz.ext",
				     type: 'POST',
					 data: json,
					 cache: false,
					 async:false,
					 contentType:'text/json',
				     success: function (text) {
				     var o = nui.decode(text);			                     
				     // 文件表主键id
				     var file_id = o.uploadFiles.fileId;
				     //文件不为空
				     if(file_id !="" && file_id !=undefined){				     			        
			          var userhtml = "<a id='removeFile' href='javascript:void(0);' style='text-decoration: none' onclick='downFlie("+o.uploadFiles.wkflid+")'>"+o.uploadFiles.fileName+"</a>";
				      $("#showUpload").append(userhtml);  
					   }
					  }
				   });    
	 
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
                 var srcPath = "<%=request.getContextPath() %>/download.jsp?filePath="+o.uploadFiles.filePath+"&&fileName="+filename;
		         window.open(srcPath);   					
                  }
                 });    					
		}	
		
		function showInfo(){
		 var bsnsdt = nui.get("master.bsnsdt").getValue();
		 var bsnssq = nui.get("master.bsnssq").getValue();
		 var fileid = nui.get("master.fileid").getValue();
		 nui.open({
                url: "<%= request.getContextPath() %>/sunfi_af/expAeuv/expAeuv_update.jsp",
                title: "查看详细信息",
                width: 900,
                height: 600,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {bsnsdt:bsnsdt,bsnssq:bsnssq,transt:"1",fileid:fileid};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setData(data);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
                            grid.reload();
                        }
                    }
               });
		
		}     
    </script>
</body>
</html>