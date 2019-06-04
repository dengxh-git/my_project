<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasishi82
  - Date: 2018-12-05 15:57:59
  - Description:
-->
<head>
<title>combrch_edit</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
 <%
    	String brchcd = request.getParameter("realId");
    	String type = request.getParameter("type");
    	String sprrcd = request.getParameter("pid");
    	request.setAttribute("brchcd", brchcd);
    	request.setAttribute("type", type);
    	request.setAttribute("sprrcd", sprrcd);
     %>
<body>
<div id="dataform1" style="padding-top:5px;">
            <table class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        机构性质:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="FI_BRCHTP" id="combrch.brchtp" name="combrch.brchtp" onvaluechanged="brchTypeChange" required="true" emptyText="请选择"  showNullItem="true" nullItemText="请选择"/>
                    </td>
                    <td class="nui-form-table-text">
                        机构代码:
                    </td>
                    <td>
                        <input class="nui-textbox" id="combrch.brchcd" name="combrch.brchcd" required="true" vtype="int"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        机构名称:
                    </td>
                    <td>
                        <input class="nui-textbox" name="combrch.brchna" required="true"/>
                    </td>
                    <td class="nui-form-table-text">
                        上级代码:
                    </td>
                    <td>
                        <input class="nui-buttonedit searchbox"  id="combrch.sprrcd" onbuttonclick="selectBrch" allowInput="false" name="combrch.sprrcd" textName="combrch.sprrna"/>
                        <input class="nui-hidden" name="combrch.brchsq" id="combrch.brchsq"/>
                        <input class="nui-hidden" name="combrch.oldsprrcd" id="combrch.oldsprrcd"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        机构流程类型:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_FLOWTP" valueField="dictID" textField="dictName" name="combrch.flowtp" required="true" emptyText="请选择"  showNullItem="true" nullItemText="请选择"/>
                    </td>
                    <td class="nui-form-table-text">
                        是否已使用:
                    </td>
                    <td>
                        <input class="nui-dictcombobox" dictTypeId="FI_USEDTP" valueField="dictID" textField="dictName" name="combrch.usedtp" required="true" emptyText="请选择"  showNullItem="true" nullItemText="请选择"/>
                    </td>
                    </tr>
                   <tr>
                    <td class="nui-form-table-text">
                        备注:
                    </td>
                    <td colspan="3">
                       <input class="nui-textarea" name="combrch.remark" style="width: 400px;height: 30px;"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button"  onclick="onOk()">
                                保存
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	setData();
			    	function saveData(){
			                //设置机构序列
			                 var brchsq=nui.get("combrch.brchsq");
			                 var brchcd=nui.get("combrch.brchcd").getValue(); 
			                 var sprrcd=nui.get("combrch.sprrcd").getValue();
			                 if(sprrcd){
			                 brchsq.setValue("."+sprrcd+"."+brchcd+".");
			                 }else{
			                 brchsq.setValue("."+brchcd+".");
			                 }
			                var form = new nui.Form("#dataform1");                         
			                form.validate();
			                if(form.isValid()==false) return;
			                //if(!codevalidation()) return;
			                var data = form.getData(false,true);
			                var json = nui.encode(data);
			                $.ajax({
			                    url:"com.sunline.sunfi.sunfi_cm.combrchbiz.updateCombrch.biz.ext",
			                    type:'POST',
			                    data:json,
			                    cache:false,
			                    contentType:'text/json',
			                    success:function(text){
			                        var returnJson = nui.decode(text);
			                        if(returnJson.exception == null){
			                              nui.alert("保存成功！");
			                              parent.refreshParentNode();
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
    				//页面间传输json数据
                    function setData(){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                   var brchcd = "${brchcd}"; 
                   var type =  "${type}";
                   var brchtp="0000";
                   if (type=="duty"){
                    brchtp="0001";
                   }else{
                    brchtp="0000";
                   }
                   var sprrcd = "${sprrcd}";
                   sprrcd = sprrcd.split("_")[1];
                        //如果是点击编辑类型页面         
                   	var json = nui.encode({combrch:{brchcd:brchcd,brchtp:brchtp,sprrcd:sprrcd}});     
                    $.ajax({
                    url: "com.sunline.sunfi.sunfi_cm.combrchbiz.getComBrch.biz.ext",
                    type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o); 
                        form.setChanged(false);
                        nui.get("combrch.brchtp").disable();
                        nui.get("combrch.brchcd").disable();
                        var oldsprrcd = nui.get("combrch.oldsprrcd"); 
                        oldsprrcd.setValue(o.combrch.sprrcd);   
                        brchTypeChange();
                      }
                    });
                   }
                   //关闭窗口
                    function CloseWindow(action) {
                        if (action == "close" && form.isChanged()) {
                            if (confirm("数据被修改了，是否先保存？")) {
                                saveData();
                            }
                        }
                        if (window.CloseOwnerWindow)
                        return window.CloseOwnerWindow(action);
                        else window.close();
                    }

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }
                  function brchTypeChange(e){
				  var type = nui.get("combrch.brchtp").getValue();
    		      nui.get("combrch.sprrcd").set({"required":type=="0001"});
    		      nui.get("combrch.sprrcd").set({"enabled":type=="0001"});
    		       if(type=="0000"){
    		        nui.get("combrch.sprrcd").setValue(null);
    		        nui.get("combrch.sprrcd").setText(null);
    		       }
				  }
				    //选择上级机构
			       function selectBrch(e) {
			        var btnEdit = this;
			        nui.open({
			            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select_by_not_power.jsp?brchtp=0000",
			            showMaxButton: false,
			            title: "选择上级机构",
			            width: 950,
			            height: 600,
			            allowResize:false,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                    data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.brchcd);
			                        btnEdit.setText(data.brchna);
			                    }
			                } if (action == "cancel" ||action == "close") {
			                        btnEdit.setValue(null);
			                        btnEdit.setText(null);
			                }
			            }
			        });            
			    }
			    //校验机构编码
			           function codevalidation(){
			        	    var brchcd = nui.get("combrch.brchcd").getValue();	
			        	    var sprrcd = nui.get("combrch.sprrcd").getValue();				         
			        	    var data = {brchcd:brchcd,sprrcd:sprrcd};
			        		var json = nui.encode({template:data});
				        	$.ajax({
			                    url: "com.sunline.sunfi.sunfi_cm.combrchbiz.validateBrch.biz.ext",
			                    type: 'POST',
				                data: json,
				                cache: false,
				                contentType:'text/json',
			                    cache: false,
			                    async:false,
			                    success: function (text) {
			                       var o = nui.decode(text);
			                        if(o.data == "1"){
			                        	  nui.alert("已存在该机构编码,请重新填写","提示");
			                        	  return false;
			                        }
			                        return true;
			                    }
				           });
			        	}
			        
    </script>
</body>
</html>