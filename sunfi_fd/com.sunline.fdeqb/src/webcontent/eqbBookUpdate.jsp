<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include  file="/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): dengxh
  - Date: 2019-04-24 19:01:00
  - Description:
-->
<head>
<%
	String nullselect = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("bmgd.public.nullselect"); //
%>
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
 <form id="form1" method="post">
        <div style="padding-left:11px;padding-bottom:5px;">
		    <table style="table-layout:fixed;">
		      <tr>
		        <td class="form-label">
		        	股权类型：
		        </td>
		        <td>
		          <input id="eqbbook.eqbktp" class="nui-dictcombobox " name="eqbbook.eqbktp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
		        </td>
		        <td class="form-label" >
		        	 凭证号码：
		        </td>
		        <td>
		          <input id="eqbbook.dcmtno" class="nui-textbox " name="eqbbook.dcmtno" required="true"/>
		        </td>
		        <td class="form-label">
		        	 经济性质：
		        </td>
		        <td>
		          <input id="eqbbook.ecmytp" class="nui-dictcombobox " name="eqbbook.ecmytp" required="true" valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
		        </td>
		      </tr>
		      <tr>
		        <td class="form-label">
		        	股东名称：
		        </td>
		        <td>
		          <input id="eqbbook.shhdcd" class="nui-buttonedit searchbox " name="eqbbook.shhdcd" onbuttonclick="selectshhdcd" allowInput="false" required="true"/><!-- valueField="eqbbook.shhdcd" textField="eqbbook.shhdna" -->
		        </td>
		        <td class="form-label">
		        	持股数：
		        </td>
		        <td>
		          <input id="eqbbook.stcknm" class="nui-textbox " name="eqbbook.stcknm" required="true" onblur="datacheck(0)" />
		        </td>
		        <td class="form-label">
		        	持股金额：
		        </td>
		        <td>
		          <input id="eqbbook.stckam" class="nui-textbox " name="eqbbook.stckam" required="true" />
		        </td>
		       </tr>
		       <tr>
		        <td class="form-label">
		        	每股价格：
		        </td>
		        <td>
		          <input id="eqbbook.stckpr" class="nui-textbox " name="eqbbook.stckpr" required="true"/>
		        </td>
		        <td class="form-label">
		        	股权金额：
		        </td>
		        <td>
		          <input id="eqbbook.eqtyam" class="nui-textbox " name="eqbbook.eqtyam" required="true"/>
		        </td>
		        <td class="form-label">
		        	溢价价格：
		        </td>
		        <td>
		          <input id="eqbbook.prumpr" class="nui-textbox " name="eqbbook.prumpr" allowInput="true" onblur="datacheck(0)"/>
		        </td>
		       </tr>
		       <tr>
		        <td class="form-label">
		        	溢价金额：
		        </td>
		        <td>
		          <input id="eqbbook.prumam" class="nui-textbox " name="eqbbook.prumam" allowInput="true"/>
		        </td>
		        <td class="form-label">
		        	入股日期：
		        </td>
		        <td>
		          <input id="eqbbook.entcdt" class="nui-datepicker " name="eqbbook.entcdt"  allowInput="false" required="true"/>
		        </td>
		        <td class="form-label">
		        	入股方式：
		        </td>
		        <td>
		          <input id="eqbbook.tranty" class="nui-dictcombobox " name="eqbbook.tranty" onvaluechanged="valueSet" required="true" valueField="dictID"  textField="dictName" dictTypeId="FI_TRANTY" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
		        </td>  
		      </tr>
		      <tr>
		        <td class="form-label">
		        	币种：
		        </td>
		        <td>
		          <input id="eqbbook.crcycd" class="nui-dictcombobox " name="eqbbook.crcycd"  valueField="dictID" textField="dictName" dictTypeId="FI_CRCYCD" showNullItem="true" nullItemText="<%=nullselect %>" emptyText="<%=nullselect %>"/>
		        </td>
		        <td class="form-label">
		        	账务部门：
		        </td>
		        <td>
		          <input id="eqbbook.acctbr" class="nui-buttonedit searchbox " name="eqbbook.acctbr" required="true" onbuttonclick="selectcomBrch" style="width: 130px;" allowInput="false"/>
		        </td>
		        <td class="form-label">
		        	股权备注：
		        </td>
		        <td>
		          <input id="eqbbook.remark" class="nui-textbox " name="eqbbook.remark" allowInput="true"/>
		        </td>
		      </tr>
		    </table>
    	</div>
    <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	    <table width="100%">
	      <tr>
	        <td style="text-align:center;">
	          <a class="nui-button" iconCls="icon-save" onclick="onOk">保存</a>
	          <span style="display:inline-block;width:25px;"></span>
	          <a class="nui-button" iconCls="icon-cancel" onclick="onCancel">取消</a>
	        </td>
	      </tr>
	    </table>
	 </div>
  </div>
 </form>
  <script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");
    form.setChanged(false);
    
    function SetData(data){
     data = nui.clone(data);
     var json = nui.encode({eqbbook:data});
      $.ajax({
        url:"com.sunline.sunfi.sunfi_eq.eqbbookbiz.getEqbBook.biz.ext",
        type:'POST',
        data:json,
        cache:false,
        contentType:'text/json',
        success:function(text){
	         var obj = nui.decode(text);
	          //根据name属性设置值
	          form.setData(obj);
	          //股东名称
	          nui.getbyName("eqbbook.shhdcd").setText(obj.eqbbook.shhdna);//设置显示值
	          //账务部门
	          nui.getbyName("eqbbook.acctbr").setText(obj.eqbbook.acctna);//设置显示值
	          
	          form.setChanged(false);
        }
      });
    }    
    
    function onOk(){
      saveData();
    }
    
    function saveData(){
     if(form.isChanged()){//检查表单数据变动
	      form.validate();//检查表单必输项
	      if(form.isValid()==false) 
	      	 return;
		 
	      if(!datacheck(1)){
			alert('股权金额+溢价金额<>持股金额');//股权金额+溢价金额<>持股金额
			return;
		  } 
	      var entcdt=nui.get("eqbbook.entcdt").getValue();//提交值    将提交值去掉时间
	      var data = form.getData();
	      data.eqbbook.entcdt=entcdt.substring(0,4) + entcdt.substring(5,7) + entcdt.substring(8,10);
	      var json = nui.encode(data);
	      $.ajax({
	        url:"com.sunline.sunfi.sunfi_eq.eqbbookbiz.updateEqbBook.biz.ext",
	        type:'POST',
	        data:json,
	        cache:false,
	        contentType:'text/json',
	        success:function(text){
	          var returnJson = nui.decode(text);
			  if(returnJson.exception == null){
				CloseWindow("saveSuccess");
			  }else{
				nui.alert("修改股权登记失败", "系统提示");
			  }
	        }
	      });
       }else{
          nui.alert("数据未改变");
       }
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
   	//选择股东名称
   	function selectshhdcd(e) {
   	      //临时保存有股东信息
   		  var shhdcd=e.sender.value;
   		  var shhdna=e.sender.text;
		  var btnEdit = this;
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqpShhdAllSelect.jsp?shhdcd="+ shhdcd,
	        	showMaxButton: false,
            	title: "股东名称_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.shhdcd);//提交值
		                        btnEdit.setText(data.shhdna);//显示值
		                    }
		                }if (action == "cancel" || action == "close") {
		                     //还原股东信息
		                        btnEdit.setValue(shhdcd);
		                        btnEdit.setText(shhdna);
		                }
		            }
		        });            
   		}
   		
   	function valueSet(){
	  	var tranty = nui.get("eqbbook.tranty").getValue();
	  	//继承     赠与       转让
	  	if(tranty == '3' || tranty == '4' || tranty == '5'){
	  	    //持股数
	  		nui.get("eqbbook.stcknm").setValue(0);
	  		//持股金额
	  		nui.get("eqbbook.stckam").setValue(0);
	  		//每股价格
	  		nui.get("eqbbook.stckpr").setValue(0);
	  		//股权金额
	  		nui.get("eqbbook.eqtyam").setValue(0);
	  		//溢价价格
	  		nui.get("eqbbook.prumpr").setValue(0);
	  		//溢价金额
	  		nui.get("eqbbook.prumam").setValue(0);
	  		
	  		nui.get("eqbbook.stcknm").disable();
	  		nui.get("eqbbook.stckam").disable();
	  		nui.get("eqbbook.stckpr").disable();
	  		nui.get("eqbbook.prumpr").disable();
	  	} 
	  	else{
	  		nui.get("eqbbook.stcknm").enable();
	  		nui.get("eqbbook.stckam").enable();
	  		nui.get("eqbbook.stckpr").enable();
	  		nui.get("eqbbook.prumpr").enable();
	  	}
	 }	
	 
    //股权金额、溢价金额等计算
	function datacheck(sign){
	    var stcknmstr = nui.get("eqbbook.stcknm").getValue(); //持股数
		var stckprstr = nui.get("eqbbook.stckpr").getValue(); //每股价格
		var prumprstr = nui.get("eqbbook.prumpr").getValue(); //溢价价格
		var stcknm,stckpr,prumpr,eqtyam,prumam;
		if(sign==0){
			if(stcknm != ''){
			    stcknm = new Number(stcknmstr);
				if(stckprstr != ''){
					stckpr = new Number(stckprstr);
					eqtyam =stcknm*stckpr;
					nui.get("eqbbook.eqtyam").setValue=eqtyam;//股权金额
					//numToMoneyField($name("eqbbook.eqtyam"));
				}
				if(prumprstr != ''){
					prumpr = new Number(prumprstr);
					prumam =stcknm*prumpr;
					nui.get("eqbbook.prumam").setValue=prumam;//溢价金额
					//numToMoneyField($name("eqbbook.prumam"));
				}
			}
		}else{
		    var stckam = new Number(nui.get("eqbbook.stckam").getValue());
			stcknm = new Number(stcknmstr);
			if(stckprstr == ''){
				nui.get("eqbbook.stckpr").setValue(0);
				stckprstr = "0";
			}
			if(prumprstr == ''){
			    nui.get("eqbbook.prumpr").setValue(0);
				prumprstr ="0";
			}
			stckpr = new Number(stckprstr);
			prumpr = new Number(prumprstr);
			eqtyam =stcknm*prumpr;
			prumam =stcknm*stckpr;
			nui.get("eqbbook.prumam").setValue(eqtyam);//溢价金额
			nui.get("eqbbook.eqtyam").setValue(prumam);//股权金额
			if(stckam != eqtyam + prumam){
				return false;
			}
		}
		return true;
	}
  </script>
</body>
</html>