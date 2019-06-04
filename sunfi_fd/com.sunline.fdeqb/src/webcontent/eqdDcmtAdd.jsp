<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): chenc
  - Date: 2019-04-04 15:10:04
  - Description:
-->
<head>
<title>新增股权证</title>
     <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/common/swfupload/swfupload.js"></script>
    
</head>
<body>

	    
            <div id="dataform1" style="padding-top:5px;" align="center" >
                <!--  hidden域 -->
                <div id="hiddenForm"></div>
			    <input class="nui-hidden" name="master.flowid" id="master.flowid" value=""/> <!-- 流程id -->
				<input class='nui-hidden' name="master.prcscd" value="eqd_dcmt_add">			   
			    <!-- 流程 -->
        		 <input class="nui-hidden" name="master.wfdena" value="com.sunline.sunfi.sunfi_wf_workflow.eqbApp" />
			     <input class="nui-hidden" name="master.wfinna" id="master.wfinna" value="股权证登记"/>
			     <input class="nui-hidden" name="master.wfinde" id="master.wfinde" value="股权证登记"/>
			     <input class="nui-hidden" name="master.lnkurl" id="master.lnkurl" value="fdeqb/eqdDcmtAdd.jsp"/>
		 	     <input class="nui-hidden" name="master.linkna" value="股权证登记" />
		 	     <input class="nui-hidden" name="master.entityna" value="com.sunline.fdeqb.eqd.EqdDcmtBrch" />
		 	     <input class="nui-hidden" name="master.brchcd" value="00016" />
		 	     
                <table  class="nui-form-table">
                    <tr>
	                    <td class="form_label">
	                      	  编码前缀:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" vtype="english" name="master.prefno"/>
	                    </td>
	                    <td class="form_label">
                        	登记日期:
	                    </td>  
	                    <td colspan="1">
	                        <input class="nui-datepicker" format="yyyyMMdd"  vtype="int" required="true" name="master.regtdt"/>
	                    </td>
	                    <td class="form_label">
                        	起始号:
	                    </td>  
	                    <td colspan="1">
	                        <input class="nui-textbox"  vtype="int" required="true" name="master.initno"/>
	                    </td>
	                  </tr>
	                  <tr>  
	                    <td class="form_label">
	                        	结束号:
	                    </td>
	                    <td colspan="1">
                        	<input class="nui-textbox" vtype="int" required="true"  name="master.finlno"/>
	                    </td>
	                    <td class="form_label">
	                        	登记数量:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" required="true"  vtype="int" name="master.tranam"/>
	                    </td>
                    
                    </tr>
                    <tr>
                    	<td class="form_label">
	                        	备注:
	                    </td>
	                    <td colspan="1">
                        	<input class="nui-TextArea" maxLength="10"   name="master.remark"/>
	                    </td>
                    </tr>
                </table>
                <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button"  onclick="onOk()">保存</a>
                            	<span style="display:inline-block;width:10px;"></span>
                            <a class="nui-button"  onclick="onOkAndSubmit()"> 保存并提交</a>
                            	<span style="display:inline-block;width:10px;"></span>
                            <a class="nui-button"  onclick="onCancel()">取消</a>
                        </td>
                    </tr>
                </table>
            </div>
	       </div>

	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");
    	function onOk(){
            saveData();
        }
 
        
        function saveData(){
             form.validate();//表单校验
             if(form.isValid()==false) {return false;}//判断校验
             //form.getData(true,false)
        	 var data = form.getData();
             var json = nui.encode(data);
             
             var initno = nui.getbyName("master.initno").getValue();
             var finlno = nui.getbyName("master.finlno").getValue();
             //var num = finlno - initno;
             var tranam = nui.getbyName("master.tranam").getValue();
             if((finlno - initno+1)!=tranam ){
             	nui.alert("份数应等于结束号码与起始号码之差加1", "提示" );
             	return false;
             }
            // return false;
             //提交
             $.ajax({
                    url:"com.sunline.fdeqb.eqddcmtbrchbiz.addEqdDcmtBrch.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                                });
                            }
                        }
                   });
        }
        function onOkAndSubmit(){
            
        	nui.confirm("是否保存数据并发起流程", "系统提示", function(action){
        		if(action == "ok"){
        			form.validate();
		            if(form.isValid()==false ) return;
		            
		            var data = form.getData();
	                var json = nui.encode(data);
	                $.ajax({
		                url:"com.sunline.sunfi.sunfi_wf.workFlowCom.startWorkFlowAndSaveDataForExp.biz.ext",
		                type:'POST',
		                data:json,
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
		                    var returnJson = nui.decode(text);
		                    if(returnJson.exception == null){
		                     if(returnJson.retmsg.retuin=="0"){
		                         var wkflid = returnJson.retmsg.wkflid;
						         var wfitid = returnJson.retmsg.wfitid;
						         var emstype = '03';//股权证登记
						         var transt = '8';
						         var usercd = 'test2';
							       window.open("<%=request.getContextPath() %>/sunfi_wf/workitem/unfinish_workitem_manager.jsp?wkflid="+wkflid+"&&wfitid="+wfitid+"&&emstype="+emstype+"&&transt="+transt+"&&usercd="+usercd); 
		                   			onCancel();
			                     }else{
			                        nui.alert("保存并发起流程失败", "系统提示");
			                     }
			                    }else{
			                        nui.alert("保存失败", "系统提示");
		                        }
		                    }
		               });
        		}
    		});
    	}
		function onCancel(){
              CloseWindow("cancel");
         }      
         function CloseWindow(action){
				if(action=="close"){}
                   else if(window.CloseOwnerWindow){
                      return window.CloseOwnerWindow(action);
                    }else{
                      return window.close();
            	}
            }               
    </script>
</body>
</html>