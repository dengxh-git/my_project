 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2019-01-03 15:16:26
  - Description:
-->
<%
    String wkflid = request.getParameter("wkflid");
    String wfitid = request.getParameter("wfitid");
    String emstype = request.getParameter("emstype");
    String usercd = request.getParameter("usercd");
    String transt = request.getParameter("transt");
    String fileid = request.getParameter("fileid");
    request.setAttribute("wkflid", wkflid);
    request.setAttribute("wfitid", wfitid);
    request.setAttribute("emstype", emstype);
    request.setAttribute("usercd", usercd);
    request.setAttribute("transt", transt);
    request.setAttribute("fileid", fileid);
 %>
<head>
<title>待办信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    span{
     font-size: 12px;
    }
    </style>
</head>
<body>
<div class="nui-tabs" id="tabs1" activeIndex="0" style="width:100%;height:100%; border: 0" plain="false">
<div title="待办详细信息" refreshOnClick="false" >
<!-- 基本信息  -->
     <form id="dataform1" action="com.sunline.sunfi.sunfi_wf.workFlowCom.submitWorkFlow.biz.ext" method="post" enctype="multipart/form-data">
     	<input class="nui-hidden"  name="wkflid" value="<%=wkflid %>"/>
		<input class="nui-hidden"  name="wfitid" value="<%=wfitid %>"/>
     <!-- 
     <table style="width: 100%">
                 
	     <tbody>
		     <tr>
			     <td style="font-size: 12px; text-align: right;">申请人:</td>
			     <td>
			     <input class="nui-hidden" id="master.fileid" name="master.fileid"/>
			     <input class="nui-hidden" id="master.expodd" name="master.expodd"/>
			     <input class="nui-hidden" id="master.prjdno" name="master.prjdno"/>
			     <input class="nui-hidden" id="master.userna" name="master.userna"/>
			     <div id="hiddenuserna"></div>
			     </td>
			     
			     <td style="font-size: 12px; text-align: right;">申请日期:</td>
			     <td>
			     <input class="nui-hidden" id="master.bsnsdt" name="master.bsnsdt"/>
			     <div id="hiddenbsnsdt"></div>
			     </td>
			 </tr>
			 <tr>    
			     
			     <td style="font-size: 12px; text-align: right;">业务流水号:</td>
			     <td>		     
			     <input class="nui-hidden" id="master.bsnssq" name="master.bsnssq"/>
			     <div id="hiddenbsnssq" style="display: inline-block;"></div>
			     </td>
		     </tr>
		     <tr>    
			     <td style="font-size: 12px; text-align: right;">申请事由:</td>
			     <td colspan="3">
			     <input class="nui-hidden" id="master.remark" name="master.remark"/>
			     <div id="hiddenremark"></div>
			     </td>
			    
		     </tr>
	     </tbody>
     </table>   
      -->  
     <!-- 审批记录历史 -->
     <div  class="nui-panel" title="审批记录" style="width: 100%;" showCollapseButton="true">
     <div id="datagrid"  class="nui-datagrid" showPager="false" dataField="WFWorkList" url="com.sunline.sunfi.sunfi_wf.workFlowQuery.queryFinshedWorkItemByProcessInstId.biz.ext">
     <div property="columns">
         <div field="workitemname" headerAlign="center" >审批角色</div>
         <div field="partiname" headerAlign="center" >审批人</div>
         <div field="messag" headerAlign="center" >审批意见</div>
         <div field="starttime" headerAlign="center" visible="false" dateFormat="yyyy-MM-dd HH:mm:ss" >接收时间</div>
         <div field="endtime" headerAlign="center"  dateFormat="yyyy-MM-dd HH:mm:ss" >审批时间</div>
         <div field="workitemid" headerAlign="center"  visible="false">工作项id</div>
         <div field="processinstid" headerAlign="center"  visible="false">流程实例id</div>
    </div>
    </div>
    </div>
     
     <div  class="nui-panel" title="附件" style="width: 100%;border-bottom: 1px;" showCollapseButton="true">
     	 
     	 <table class="nui-form-table" align="center"> 
     	 	<tr>
     	 		<td class="nui-form-table-text" style="width: 30%">流程附件：</td>
     	 		<td class="nui-form-table-text" style="width: 70%"><a class="nui-button" onclick="addfile()">添加附件</a> </td>
     	 	</tr>
     	 	<tr>
     	 		<td></td>
     	 		<td>
     	 			<table class="nui-form-table" align="center" id="filetab"> 
     	 			</table>
     	 		</td>
     	 	</tr>
     	 	
     	 </table>
     		
     </div>
     <!-- 审批意见及下一处理人 -->
     <div  class="nui-panel" title="审批" style="width: 100%;">
	     <table class="nui-form-table" align="center">
		      <tr>
			     <td class="nui-form-table-text" style="width: 30%">下一处理步骤:</td>
			     <td><input class="nui-hidden" name="selectNextusercd"  style="width: 400px;"/>
			     	 <input class="nui-dictcombobox"  onvaluechanged="onChanged" id="appFlow" name="appFlow" style="width: 80px;"  textField="text" valueField="id"/></td>
		     </tr>
		      <tr>
			     <td class="nui-form-table-text">意见:</td>
			     <td><input class="nui-textarea" name="message" style="width: 400px; height: 50px;"/></td>
		     </tr>
	     </table>
     </div>
     <!--关闭 -->
     <div class="nui-toolbar" id="operate" style="border-bottom:0;padding:0px;">
	     <table style="width:100%;">
            <tr>
                 <td style="text-align:center;">
                            <a class="nui-button"  onclick="showInfo()">
                                	详细信息
                            </a>
                  			<a class="nui-button"  onclick="ok()">
                                	提交
                            </a>
                            <a class="nui-button" onclick="closeWin()">
                                	关闭
                            </a>
            </tr>
        </table>    
     </div>
</form>
</div>
</div>  
	<script type="text/javascript">
       nui.parse();
       var itable = nui.get("itable");
       
       var form  =  new nui.Form("#dataform1");//将普通form转为nui的form
       var tabs = nui.get("tabs1");
	   var grid = nui.get("datagrid");
	   //详情页面
	   var detailurl= null;
	   //储存已提交文件
	   var wffiles =null;
	   
	   //用于定义新增文件id
	   var fileindex=0;	
	   //var grid1 = nui.get("datagrid1");
	   //var grid2 = nui.get("datagrid2");
	   grid.load({wkflid:'${wkflid}'});
	   //grid1.load({wkflid:'${wkflid}'});
	   var result;//费用报销角色标识	
	   var retCode;//最后角色标识	  
	 
		  //提交业务
		  function ok(){
		      var appFlow = nui.get("appFlow").getValue();
		      var message = nui.getbyName("message").getValue();
		      var selectNextusercd = nui.getbyName("selectNextusercd").getValue();
		      //var uploadFiles = nui.get("uploadFile");
		     
		      var data ={wkflid:'${wkflid}',wfitid:'${wfitid}',appFlow:appFlow,message:message}; 
		      var json = nui.encode(data);
		       
				var fileElementId=[];
				$(":file").each(function (i){
					fileElementId[i]=this.id;
					
				});
		      	  nui.confirm("你确定要提交吗?", "系统提示", function(action){
		          if(action=="ok"){
		           $.ajaxFileUpload({
	                    url:"com.sunline.sunfi.sunfi_wf.workFlowCom.submitWorkFlow.biz.ext",
	                    type:'POST',
	                    data:data,
	                    fileElementId: 'file0',
	                    dataType:'content',
	                    success:function(text, status){
	                    	text = jQuery.parseJSON(jQuery(text).text()); 
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                            if(returnJson.execMsg.erorcd=="0"){
	                             	
								 	nui.alert("操作成功!","提示",function(action){
							          if(action=="ok") window.parent.close();
							        });	                            
	                            }else{
	                            	nui.alert("操作失败", "系统提示");
	                            }
	                        }else{
	                            nui.alert("操作失败", "系统提示");
	                            }
	                        },
	                        error: function(data, status, e) {  //提交失败自动执行的处理函数。
			                    console.error(e);
			                }
	                   });
		          
		          };
		      
		      });
		  }              
		  //关闭窗口             
		  function closeWin(){
		    window.parent.close();
		  }
     //页面初始化		   
	 $(function(){
            nui.get("appFlow").setUrl("<%=request.getContextPath() %>/sunfi_wf/workitem/role_fm_chck.txt");
            nui.get("appFlow").select(0);
            nui.getbyName("message").setValue("同意");
            
	        var data = {wkflid:'${wkflid}',wfitid:'${wfitid}',transt:'${transt}',usercd:'${usercd}',fileid:'${fileid}'};	
			var json = nui.encode(data); 
			
   
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
						        console.log(path);
						        otd.innerHTML="<a id='removeFile' href='javascript:void(0);' style='text-decoration: none' onclick='downFlie("+index+")'>"+wffile.filena+"</a>";
						      }
					   }
					  }
				   });
	  		 //获取当前审批角色
	  		
	  		 //待办接口
	  		
		  	

	 });
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
     //下一处理人		
	 function showPeople(wkflid){
	    nui.getbyName("selectNextusername").setValue("");
	    nui.getbyName("selectNextusercd").setValue("");
	    nui.open({
                url: "<%= request.getContextPath() %>/sunfi_wf/workitem/findNextUsers.jsp",
                title: "下一处理人信息",
                width: 620,
                height: 380,
                showMaxButton: false,
                allowResize:false,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {wkflid:wkflid,usercd:'${usercd}'};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setData(data);
                    },
                    ondestroy: function (action) {
                        if(action=="ok"){
                            var iframe = this.getIFrameEl();
					        var data = iframe.contentWindow.getData();
					        data = nui.clone(data);
					        if (data) {
					                var empname="",userid="";
					                for(var i=0;i<data.length;i++){
					                var row = data[i];
					                empname +=row.empname;
					                userid +=row.userid;
						                if(i !=data.length -1){
						                empname +=",";
						                userid +=",";
						                }  
					                }
			                        nui.getbyName("selectNextusername").setValue(empname);
			                        nui.getbyName("selectNextusercd").setValue(userid);
			                    }
                        }
                    }
               });
	 }; 
	 function onChanged(){
		 var appFlow = nui.get("appFlow").getValue();
		 if(appFlow=="AGREE"){
		   nui.getbyName("message").setValue("同意");
		   //不是最后节点
		   if(retCode=="0")
		   //不是财务初审、财务复核
		   if(result==null){
		    $("#nextuserinfo").show();
		   }
		 }else if(appFlow=="ROLLBACK"){
		   nui.getbyName("message").setValue("退回");
		   //不是最后节点
		   if(retCode=="0")
		   //不是财务初审、财务复核
		   if(result==null){
		    $("#nextuserinfo").hide();
		   }		   
		 }else if(appFlow=="CANCEL"){
		  nui.getbyName("message").setValue("作废");
		   //不是最后节点
		   if(retCode=="0")
		   //不是财务初审、财务复核
		   if(result==null){
		    $("#nextuserinfo").hide();
		   }
		 }else if(appFlow=="REFUSE"){
		  nui.getbyName("message").setValue("撤回");
		   //不是最后节点
		   if(retCode=="0")
		   //不是财务初审、财务复核
		   if(result==null){
		    $("#nextuserinfo").hide();
		   }
		 };	 
	 };
	//查看详细信息不可修改（领导审核） 
	function showInfo(){	    
		//detailurl
		getDetailLink();
		 var url ="";
		 url = "<%= request.getContextPath() %>"+detailurl;//股权证登记
		 //url +="?wkflid=${wkflid}";
		 var tab = {title: "详细信息",showCloseButton:true,url:url};
	     tab = tabs.addTab(tab);     
		 tabs.activeTab(tab);
			
	}
	//查看详细信息可修改 
	function addInfo(){
	 var bsnsdt = nui.get("master.bsnsdt").getValue();
	 var bsnssq = nui.get("master.bsnssq").getValue();
	 var fileid = nui.get("master.fileid").getValue();
	 var expodd = nui.get("master.expodd").getValue();
	 var prjdno = nui.get("master.prjdno").getValue();
	 var emstype = '${emstype}';
	 var url ="";
	 if(emstype=="01"){
	 url = "<%= request.getContextPath() %>/sunfi_af/expBaoXiao/ExpRgstUpdate.jsp";
	 }else if(emstype=="02"){
	 url = "<%= request.getContextPath() %>/sunfi_af/expAeuv/expAeuv_update.jsp";
	 }else if(emstype=="03"){
	 	 url = "<%= request.getContextPath() %>/fdeqb/EqdDcmtBrchList.jsp";//股权证登记
	 }else{
	 
	 }
	  url +="?bsnsdt="+bsnsdt;
	  url +="&&bsnssq="+bsnssq;
	  url +="&&fileid="+fileid;
	  url +="&&expodd="+expodd;
	  url +="&&prjdno="+prjdno;
	 var tab = {title: "详细信息",showCloseButton:true,url:url};
	  tab.ondestroy = function (e) {
	    location.reload();
	  };
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
	 
	 function addfile(){
		var filetab = document.getElementById("filetab");
		var otr = filetab.insertRow();  
        var otd = otr.insertCell();
        //设置fileid
        var fileid = "file"+fileindex;
        otd.innerHTML="<input  type='file' id='"+fileid+"' unselectable='on' name=\"uploadFile\" size='90' />&nbsp;<input type='button' value='删除' class='button' onclick='deleteFileInput(this);'>";
        fileindex = fileindex+1;
        //var inputs = otd.firstChild.calssname="mini-fileupload";
	 }
	function deleteFileInput(obj) {//删除表格
	    var tr = obj.parentElement.parentElement;
	    var filetab = document.getElementById("filetab");
		filetab.deleteRow(tr.rowIndex);
		return;
	}
    </script>
</body>
</html>