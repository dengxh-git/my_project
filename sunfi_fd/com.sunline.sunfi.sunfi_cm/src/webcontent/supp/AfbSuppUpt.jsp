<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<!-- 
  - Author(s): kaifasanshi93
  - Date: 2018-12-06 09:48:52
  - Description:
-->
<head>
<title>供应商详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
   <div id="dataform1" style="padding-top:5px;">
      <input class="nui-hidden" id="afbsupps.suppid" name="afbsupps.suppid" />
         <table class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                       供应商名称(户名):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afbsupps.suppna" required="true" enabled="enabled" />
                    </td>
                    <td class="nui-form-table-text">
                       开户银行:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit searchbox" onbuttonclick="selectBank" allowInput="false" id="afbsupps.brname" name="afbsupps.brname" textName="afbsupps.brname" />
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        收款账户号:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afbsupps.bankno" required="true" onvalidation="codevalidation"/>
                    </td>
                    <td class="nui-form-table-text">
                        收款账户类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="FI_TAXPATP" name="afbsupps.recpty" required="true" />
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        公私标志:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="FI_PUBPRITP" name="afbsupps.puprsi" required="true" />
                    </td>
                    <td class="nui-form-table-text">
                        开户省:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="afbsupps.acoppr"/>
                    </td>
                </tr>
                <tr>                   
                    <td class="nui-form-table-text">
                         开户市:
                    </td>
                    <td colspan="3">
                        <input class="nui-textbox" name="afbsupps.opanac"/>
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
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button"  onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
             </div>
          </div>   

	<script type="text/javascript">
	
    	nui.parse();
    	var form = new nui.Form("#dataform1");      
    	var bootPath = "<%=request.getContextPath() %>";
			       
		function selectBank() {
			        var btnEdit = this;
			        nui.get("afbsupps.brname").setValue(null);
			        nui.get("afbsupps.brname").setText(null);
			        nui.open({
			            url: bootPath + "/sunfi_cm/bank/bank_select.jsp",
			            showMaxButton: false,
			            title: "选择开户行",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        btnEdit.setValue(data.brname);
			                        btnEdit.setText(data.brname);
			                    }
			                }else {
			                	btnEdit.setValue(null);
			                    btnEdit.setText(null);
			                }
			            }
			        });            
			       }
		
		//判断是否数字	       
		function isNumber(v) {
			       var re = new RegExp("^[0-9]*$");
			       if (re.test(v)) return true;
			       return false;
			    }
		
		//校验收款账号	    
		function codevalidation(e){
			        	if(e.isValid){
				        	 if (isNumber(e.value) == false) {
			                     e.errorText = "必须输入数字";
			                     e.isValid = false;
			                     return;
	                			}					          
			        	    /* var data = {acctno:e.value};
			        		var json = nui.encode({template:data});
				        	$.ajax({
			                    url: "com.sunline.sunfi.sunfi_cm.comacctbiz.checkAcctno.biz.ext",
			                    type: 'POST',
				                data: json,
				                contentType:'text/json',
			                    cache: false,
			                    async: false,
			                    success: function (text) {
			                       var o = nui.decode(text);
			                        if(o.data == "1"){
			                        	e.errorText = "付款账号已存在，请请重新填写";
				        				e.isValid = false;
			                        }
			                    }
				           }); */
			        	}
			        }			        
    	
    	function saveData(){
			    form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
			    /* $.ajax({			    
			        url: "com.sunline.sunfi.sunfi_cm.afbsuppbiz.getSuppNo.biz.ext",
			        type: 'POST',
				    data: json,
				    contentType:'text/json',
			        cache: false,
			        async: false,
			        success: function (text) {
			        var o = nui.decode(text);
			        var suppid = o.suppnu;
			        var len = (suppid.toString()).length;
			        var str="0";
			        if(parseInt(len)<=parseInt(10)){	   	
		   		      for(var i=0;i<10-(len);i++){
		   		        str += "0";
		   		    }		   		
		   		        suppid = "AF"+str+suppid;
		   		    }else{
		   		        suppid = "AF"+suppid;	   		
		   		       }
		   		       nui.get("afbsupp.suppid").setValue(suppid);	   		       		   		       
			        }
			      });
			    form.validate();
                if(form.isValid()==false) return;
                var data1 = form.getData(false,true);
                var json1 = nui.encode(data1);		    
                $.ajax({
			        url: "com.sunline.sunfi.sunfi_cm.afbsuppbiz.checkSuppAdd.biz.ext",
			        type: 'POST',
				    data: json1,
				    contentType:'text/json1',
			        cache: false,
			        async: false,
			        success: function (text) {
			        var o = nui.decode(text);
			        if(o.retuin == null){
			            nui.alert("获取供应商失败!","提示");
				        return false;
			          }
			        if(o.retuin == "1"){
			            nui.alert("供应商编号已存在,请重新录入!","提示");
				        return false;
			          } */
                $.ajax({
                    url:"com.sunline.sunfi.sunfi_cm.afbsuppbiz.uptAfbSupp.biz.ext",
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
			       /* }
				}); */							
       }
                    
                    //页面间传输json数据
                    function setData(data){
                      //跨页面传递的数据对象，克隆后才可以安全使用
                      data = nui.clone(data);
                      //如果是点击编辑类型页面              
                   	  var json = nui.encode({afbsupps:data});
                   	
                    $.ajax({
                    url: "com.sunline.sunfi.sunfi_cm.afbsuppbiz.getAfbSupp.biz.ext",
                    type: 'POST',
	                data: json,
	                contentType:'text/json',
                    cache: false,
                    success: function (text) {
                        var o = nui.decode(text);
                        form.setData(o);
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

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
    </script>
</body>
</html>