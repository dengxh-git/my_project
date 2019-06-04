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
		//获取标签中使用的国际化资源信息
		String obj = com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("sunfi.sunfi_eq.book_price.update"); //股本调整
%>
</head>
<body>
 <form id="form1" method="post">
        <input name="id" class="mini-hidden"/>
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
		      <tr>
		 		<td class="form-label">
		        	股权编号：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.eqbkno"  enabled="false"/>
		          <input class="nui-hidden" name="eqbbook.cardsq"/>
		        </td>
		        <td class="form-label" >
		        	 凭证号码：
		        </td>
		        <td>
		          <input class="nui-buttonedit searchbox" onbuttonclick="selectdcmtno" allowInput="false" name="eqbbook.dcmtno"  style="width: 200px;"/>
		        </td>
		        <td class="form-label">
		        	 经济性质：
		        </td>
		        <td>
		          <input class="nui-dictcombobox " name="eqbbook.ecmytp"  valueField="dictID" textField="dictName" dictTypeId="FI_ECMYTP" enabled="false"/>
		        </td>
		      </tr>
              <tr>
		        <td class="form-label">
		        	股东代码：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.shhdcd" enabled="false"/>
		        </td>
		        <td class="form-label">
		        	股东名称：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.shhdna" enabled="false"/>
		        </td>
		        <td class="form-label">
		        	持股数：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.stcknm" />
		        </td>
		      </tr>
		      <tr>
		        <td class="form-label">
		        	持股金额：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.stckam" />
		        </td>
		        <td class="form-label">
		        	入股日期：
		        </td>
		        <td>
		          <input class="nui-datepicker" name="eqbbook.entcdt" allowInput="false" /> <!--默认格式：format="yyyy-MM-dd" 该控件提交类型为date timeFormat="H:mm:ss" showTime="true" onvalidation="onCompare" -->
		        </td>
		        <td class="form-label">
		        	股权状态：
		        </td>
		        <td>
		          <input class="nui-dictcombobox " name="eqbbook.status"  valueField="dictID" textField="dictName" dictTypeId="FI_EQSTUS" />
		        </td>
		      </tr>
		      <tr>
		        <td class="form-label">
		        	股权类型：
		        </td>
		        <td>
		          <input class="nui-dictcombobox " name="eqbbook.eqbktp"  valueField="dictID" textField="dictName" dictTypeId="FI_EQBKTP" />
		        </td>
		        <td class="form-label">
		        	调整方式：
		        </td>
		        <td>
		          <input class="nui-dictcombobox " name="eqbbook.defi01"  valueField="dictID" textField="dictName" dictTypeId="FI_TRIMWY" />
		        </td>
		        <td class="form-label">
		        	调整股数：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.defi03" allowInput="true"/>
		          <input class="nui-hidden" name="eqbbook.thisam"/>
		        </td>
		      </tr>
		      <tr>
		        <td class="form-label">
		        	每股价格：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.stckpr" allowInput="true"/>
		        </td>
		        <td class="form-label">
		        	溢价价格：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.prumpr" allowInput="true"/>
		        </td>
		        <td class="form-label">
		        	股权备注：
		        </td>
		        <td>
		          <input class="nui-textbox " name="eqbbook.remark" allowInput="true"/>
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
	          form.setChanged(false);
        }
      });
    }    
    
    function onOk(){
      saveData();
    }
    
    function saveData(){
     if(form.isChanged()){
           //调整股数
	      var defi03=nui.getbyName("eqbbook.defi03").getValue();
	      //每股价格
	      var stckpr=nui.getbyName("eqbbook.stckpr").getValue();
	      //溢价价格
	      var prumpr=nui.getbyName("eqbbook.prumpr").getValue();
	      //本次发生额
	      nui.getbyName("eqbbook.thisam").setValue(defi03 * stckpr + defi03 * prumpr);
	   	 
	      form.validate();
	      if(form.isValid()==false) 
	      	 return;
	      
	      var entcdt=nui.getbyName("eqbbook.entcdt").getValue();//提交值    将提交值去掉时间
	      var data = form.getData(false,true);
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
				nui.alert("修改<%=obj %>失败", "系统提示");
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

   	//选择凭证号码
   	function selectdcmtno(e) {
		  var btnEdit = this;
		  var dcmtno=this.value();//临时保存
		  nui.open({
		        url: "<%=request.getContextPath() %>" + "/sunfi_eq/EqdDcmtDetlSelect.jsp",
	        	showMaxButton: false,
            	title: "凭证号码_选择列表",
            	width: 1200,
            	height: 580,
            	allowResize:false,
            	ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.getData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.dcmtno);//提交值
		                        btnEdit.setText(data.dcmtno);//显示值
		                    }
		                }if (action == "cancel" || action == "close") {
		                        btnEdit.setValue(dcmtno);
		                        btnEdit.setText(dcmtno);
		                }
		            }
		        });            
   		}
  </script>
</body>
</html>