<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%--
- Author(s): Administrator
- Date: 2019-05-05 15:12:32
- Description:
--%>
<%
		//获取标签中使用的国际化资源信息
		String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
		String opratp = request.getParameter("opratp");
		String obj = ""; //
		String obj_pldgnm = "";
		String obj_froznm = "";
		String obj_pldgdt = "";
		String obj_pldgrs = "";
		String obj_unpldt = "";
		String addprcscd=""; 
		String entprcscd="";
		if(opratp.equals("19")){
			addprcscd="eqb_pld_add";
			entprcscd="eqb_pld_etr";
			obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_pledge"); //质押
			obj_pldgnm = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_pldg.pldgnm");//质押股数
			obj_froznm = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_freezenm");//冻结股数
			obj_pldgdt = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_pldg.pldgdt");//质押日期
			obj_pldgrs = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_pldg.pldgrs");//质押原因
			obj_unpldt = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_pldg.unpldt");//约定解质押日期
		}else if(opratp.equals("21")){
			addprcscd="eqb_frz_add";
			entprcscd="eqb_frz_etr";
			obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_freeze"); //冻结
			obj_pldgnm = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_freezenm");//冻结股数
			obj_froznm = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqb_pldg.pldgnm");//质押股数
			obj_pldgdt = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_freezedt");//冻结日期
			obj_pldgrs = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_freezers");//冻结原因
			obj_unpldt = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.eqbpldg_ydslufrzedt");//约定解冻结日期
		}
		String obj_input = obj + com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.input");//
		
		request.setAttribute("opratp", opratp);
%>
<%
		String wkflid = request.getParameter("wkflid");//流程ID
		request.setAttribute("wkflid", wkflid);
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <%=obj_input %>
    </title>
  </head>
  <body style="width:100%;overflow:hidden;">
  	 <form id="form1" method="post">
  	 	<div style="padding-left:11px;padding-bottom:5px;">
        <input name="detail.eqbkno" class="nui-hidden"/>
        <input name="detail.bsnsdt" class="nui-hidden"/>
        <input name="detail.bsnssq" class="nui-hidden"/>
        <input name="master.wfdena" class="nui-hidden" value="com.sunline.sunfi.sunfi_wf.eqApp"/>
        <input name="master.wfinna" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.wfinde" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.linkna" class="nui-hidden" value="<%=obj_input %>"/>
        <input name="master.entityna" class="nui-hidden" value="com.sunline.sunfi.sunfi_eq.eqb.EqbBook"/>
        <input name="master.cityno" class="nui-hidden" value="param/cityno"/>
        <input name="detail.ismain" class="nui-hidden" value="0"/>
        <input name="master.prcscd" class="nui-hidden" value="<%=addprcscd %>"/>
        <input name="detail.calPrcscd" class="nui-hidden" value="eqb_com_cal"/>
        <input name="detail.addPrcscd" class="nui-hidden" value="<%=addprcscd %>"/>
        <input name="detail.enterPrcscd" class="nui-hidden" value="<%=entprcscd %>"/>
        <input name="master.lnkurl" class="nui-hidden" value="/sunfi_eq/EqbPldgQuery.jsp?opratp=${opratp}&wkflid="/>
        <input name="detail.lnkurl" class="nui-hidden" value="/sunfi_eq/EqbPldgQuery.jsp?opratp=${opratp}&wkflid="/>
        
        <input name="eqbpldg.bsnsdt" class="nui-hidden"/>
	    <input name="eqbpldg.bsnssq" class="nui-hidden"/>
           <div style="padding:5px;">
	            <table style="table-layout:fixed;">
	                <tr>
	                    <td style="width:100px;">股权编号：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-buttonedit searchbox" name="eqbpldg.eqbkno" onbuttonclick="selecteqbkno" allowInput="false" />
	                    </td>
				        <td style="width:100px;">凭证号码：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="eqbpldg.dcmtno" required="true"/>
				        </td>
				        <td style="width:100px;">经济性质：</td>
				        <td style="width:150px;">
				            <input class="nui-dictcombobox " name="eqbpldg.ecmytp" allowInput="false" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;">股东代码：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="eqbpldg.shhdcd" allowInput="false" required="true"/>
				        </td>
	                    <td style="width:100px;">股东名称：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="eqbpldg.shhdna" allowInput="false" required="true"/>
	                    </td>
	                    <td style="width:100px;">股权类型：</td>
	                    <td style="width:150px;">
				            <input class="nui-dictcombobox " name="eqbpldg.eqbktp" allowInput="false" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
				        </td>
	                </tr> 
	                <tr>
	                	<td style="width:100px;">持股数：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="eqbpldg.stcknm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td>
	                	<td style="width:100px;">持股金额：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="eqbpldg.stckam" allowInput="false" required="true" emptyText="0" vtype="float"/>
				        </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;">历史<%=obj_pldgnm %>：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="eqbpldg.h_froznm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td> 
	                	<td style="width:100px;">历史<%=obj_froznm %>：</td>
				        <td style="width:150px;">
				          	<input class="nui-textbox " name="eqbpldg.h_pldgnm" allowInput="false" required="true" emptyText="0" vtype="int"/>
				        </td>
	                    <td style="width:100px;"><%=obj_pldgnm %>：</td>
	                    <td style="width:150px;">
	                    	<input class="nui-textbox " name="eqbpldg.thisam"  required="true" emptyText="0" vtype="int"/>
	                    </td>
	                </tr>
	                <tr>
	                	<td style="width:100px;"><%=obj_pldgdt %>：</td>
				        <td style="width:150px;">
				        	<input class="nui-datepicker " name="eqbpldg.pldgdt" allowInput="false" required="true" />
				        </td>
	                    <td style="width:100px;"><%=obj_pldgrs %>：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="eqbpldg.pldgrs" />
	                    </td>	                	
	                    <td style="width:100px;"><%=obj_unpldt %>：</td>
				        <td style="width:150px;">
				        	<input class="nui-datepicker " name="eqbpldg.unpldt" allowInput="false" required="true" />
				        </td>
	                </tr>
	                <tr>
	                    <td style="width:100px;">申请文书号：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="eqbpldg.aplyno" />
	                    </td>
	                    <td style="width:100px;">批准文书号：</td>
	                    <td style="width:150px;">    
	                    	<input class="nui-textbox " name="eqbpldg.audtno" />
	                    </td>
	                    <td style="width:100px;">备注：</td>
				        <td style="width:150px;">
				            <input class="nui-textbox " name="eqbpldg.remark" />
				        </td>
	                </tr>
	            </table>
             </div>
        </div>
        <div style="text-align:center;padding:10px;">               
            <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a> 
            <a class="nui-button" onclick="onOkAndSubmit()">保存并提交</a>         
            <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");

    var opratp="${opratp}";
    
    function SetData(data){
     data = nui.clone(data);
     var json = nui.encode({eqbpldg:data});
      $.ajax({
        url:"com.sunline.sunfi.sunfi_eq.eqbpldgbiz.getEqbPldg.biz.ext",
        type:'POST',
        data:json,
        cache:false,
        contentType:'text/json',
        success:function(text){
	         var obj = nui.decode(text);
	          //根据name属性设置值
	          form.setData(obj);
	          nui.getbyName("eqbpldg.eqbkno").setText(obj.eqbpldg.eqbkno);
	          
	          nui.getbyName("eqbpldg.h_froznm").setValue(obj.eqbpldg.froznm);
	          
	          nui.getbyName("eqbpldg.h_pldgnm").setValue(obj.eqbpldg.pldgnm);

	          form.setChanged(false);
	          
        }
      });
    }   
	
    function onOk(){
      saveData();
    }
    
    function saveData(){
    	if(form.isChanged()){  
    		  form.validate();
		      if(form.isValid()==false) 
		      	return;
			  //数据有效性检查
		      if(!dataCheck())
		         return ;
		          
		      //获取整个form中的input数据转换object对象
		      var data = form.getData(false,true);
		    
		      var pldgdt=nui.getbyName("eqbpldg.pldgdt").getValue();
		      data.detail.pldgdt=pldgdt.substring(0,4) + pldgdt.substring(5,7) + pldgdt.substring(8,10);
		      var unpldt=nui.getbyName("eqbpldg.unpldt").getValue();
		      data.detail.unpldt=unpldt.substring(0,4) + unpldt.substring(5,7) + unpldt.substring(8,10);
		      return ;
		      //将表单数据转换成json字符串
		      var json = nui.encode({param : data});
		      $.ajax({
		        url:"com.sunline.sunfi.sunfi_eq.eqbpldgbiz.updateEqbPldgAndEqbbook.biz.ext",
		        type:'POST',
		        data:json,
		        cache:false,
		        //async:true,//同步
		        contentType:'text/json',
		        success:function(text){ debugger;
		            var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.retmsg.retuin == 0){ 
							nui.alert("保存<%=obj %>成功", "系统提示", function(action){
								if(action == "ok" || action == "close"){
									CloseWindow("saveSuccess");
								}
							});
						}
					}else{
						nui.alert("更新<%=obj %>失败", "系统提示", function(action){
							if(action == "ok" || action == "close"){
								CloseWindow("saveFailed");
							}
						});
					}
		        }
		      });
    	}else{
          nui.alert("数据未改变");
       }

    }
    
    function dataCheck(){
    	if(nui.getbyName("eqbpldg.pldgdt").getValue() > nui.getbyName("eqbpldg.unpldt").getValue()){
			if(opratp == "19"){
				alert('质押日期不能大于约定解质押日期!');
			}else{
				alert('冻结日期不能大于约定解冻结日期!');
			}
			return false;
		}
        var thisam=new Number(nui.getbyName("eqbpldg.thisam").getValue());
       
        var stcknm=new Number(nui.getbyName("eqbpldg.stcknm").getValue());//持股数
          
    	var froznm=new Number(nui.getbyName("eqbpldg.h_froznm").getValue());//历史冻结股数
    	var pldgnm=new Number(nui.getbyName("eqbpldg.h_pldgnm").getValue());//历史质押股数
        
    	if(thisam > stcknm - froznm - pldgnm)
    	{
        	alert("<%=obj_pldgnm %>不能大于总持股数-己冻结股数-己质押股数！");//质押股数不能大于总持股数减已冻结股数
        	return false;
    	}
    	return true;
    }
    
    function onOkAndSubmit(){
         form.validate();
		 if(form.isValid()==false )
		    return;
		    
        //数据有效性检查
        dataCheck();
        
        nui.confirm("是否保存数据并发起流程", "系统提示", function(action){
        		if(action == "ok"){
		            var data = form.getData();
	                var json = nui.encode(data);
	                $.ajax({
		                url:"com.sunline.sunfi.sunfi_wf.doExecuteWf.startWorkFlowForAjax.biz.ext",
		                type:'POST',
		                data:json,
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
			                    var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									submitWorkFlow(returnJson);
									CloseWindow("saveSuccess");
								}else{
									nui.alert("保存提交<%=obj %>流程失败", "系统提示", function(action){
										if(action == "ok" || action == "close"){
											CloseWindow("saveFailed");
										}
									});
								}
		                    }
		               });
        		}
    		});
    	}
    
    function onReset(){
      form.reset();
      form.setChanged(false);
    }
    
    function onCancel(){
      CloseWindow("cancel");
    }
    
    function CloseWindow(action){
      if(action=="close" && form.isChanged()){
        if(confirm("数据已改变,是否先保存?")){
          return false;
        }
      }else if(window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
      else
        return window.close();
    } 
      //选择股权编号
   	  function selecteqbkno(e) {
		  var btnEdit = this;
		  var eqbkno=this.value;//临时保存
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqbBookSelect.jsp?param/pldgst=2&param/status=0", //未全部冻结且股权正常
	        	showMaxButton: false,
            	title: "股权编号_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.eqbkno);//提交值
		                        btnEdit.setText(data.eqbkno);//显示值
		                        
		                        nui.getbyName("eqbpldg.eqbktp").setValue(data.eqbktp);//股权类型
		                        
		                        nui.getbyName("eqbpldg.ecmytp").setValue(data.ecmytp);//经济性质
		                        
								nui.getbyName("eqbpldg.dcmtno").setValue(data.dcmtno);//凭证号码
								
		                        nui.getbyName("eqbpldg.shhdcd").setValue(data.shhdcd);//股东代码
		                        
		                        nui.getbyName("eqbpldg.stcknm").setValue(data.stcknm);//持股数
		                        
		                        nui.getbyName("eqbpldg.stckam").setValue(data.stckam);//持股金额
		                        
		                        nui.getbyName("eqbpldg.shhdna").setValue(data.shhdna);//股东名称
								
								//查询股权编号质押与冻结数
								var json = nui.encode({eqbkno : data.eqbkno});
								$.ajax({
			                        url:"com.sunline.sunfi.sunfi_eq.eqbpldgbiz.selectEqbbook.biz.ext",
			                        type:'POST',
			                        data:json,
			                        cache: false,
			                        async:false,
			                        contentType:'text/json',
			                        success:function(text){
				                            var returnJson = nui.decode(text);
				                            if(returnJson.exception == null){
				                            	//if(opratp=='19'){//质押
												   nui.getbyName("eqbpldg.h_froznm").setValue(returnJson.froznm);
												   
												   nui.getbyName("eqbpldg.h_pldgnm").setValue(returnJson.pldgnm);
												/*  }else{//冻结
												   nui.getbyName("detail.h_thisam").setValue(returnJson.pldgnm);
												   
												   nui.getbyName("detail.h_pldgnm").setValue(returnJson.froznm);
												 } */
				                            }
			                            }				  	
		                    });
		                   }
		                }
		                if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(eqbkno);
		                        btnEdit.setText(eqbkno);
		                }
		            }
		        });            
   		}

    //选择账务部门
    function selectcombrch(e) {
	  var btnEdit = this;
	  nui.open({
	        url: "<%=request.getContextPath() %>" + "/sunfi_cm/ComBrchSelect.jsp",
	      	showMaxButton: false,
	        	title: "账务机构_选择列表",
	        	width: 1200,
	        	height: 580,
	        	allowResize:false,
	        	ondestroy: function(action){
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.getData();
	                    data = nui.clone(data);
	                    if (data) {
	                        btnEdit.setValue(data.brchcd);//提交值
	                        btnEdit.setText(data.brchna);//显示值
	                    }
	                }if (action == "cancel" || action == "close") {
	                        btnEdit.setValue(null);
	                        btnEdit.setText(null);
	                }
	            }
	        });            
		}

    //开启工作流
    function submitWorkFlow(returnJson){
		//工作流程实例ID
		var wkflid=returnJson.wkflid;
		if(wkflid !=null){
		//url:"<%=request.getContextPath() %>"+"/sunfi_wf/beforeWorkFolw.jsp?wkflid="+ wkflid,
		//com.sunline.sunfi.sunfi_wf.submitWorkFlow.flow
		  nui.open({
          url:"<%=request.getContextPath() %>"+"/sunfi_wf/com.sunline.sunfi.sunfi_wf.submitWorkFlow.flow?wkflid=" + wkflid,
          title:'流程审批',
          width:800,
          height:400,
          onload:function(){
          		 },
          ondestroy:function(action){
             			if(action == "ok" || action == "close"){
							CloseWindow("saveSuccess");
						}
          			}
                 });
		}else{
			nui.alert("提交流程失败", "系统提示", function(action){
			if(action == "ok" || action == "close"){
				CloseWindow("saveSuccess");
			}
			});
		}	
    }
  </script>
</body>
</html>