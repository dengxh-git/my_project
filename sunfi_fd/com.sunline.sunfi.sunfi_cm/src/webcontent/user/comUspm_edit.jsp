<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): kaifasishi147
  - Date: 2018-12-20 11:51:06
  - Description:
-->
<head>
<title>用户数据权限设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />   
</head>
<body>
        <div id="dataform1" style="padding-top:5px;">
            <table class="nui-form-table">
                <tr>
                    <td class="nui-form-table-text">
                        用户代码:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="comuspms.usercd"  allowInput="false" />
                    </td>
                    <td class="nui-form-table-text">
                        用户名称:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="comuspms.userna" allowinput="false" />
                    </td>
                </tr>  
            	<tr>
            		 <td class="nui-form-table-text">
                        所属机构权限:
                    </td>
            		<td colspan="4">
                       <input class="nui-textbox" style="width: 440px;" id="comuspms.permvl" name="comuspms.permvl" allowinput="false" required="true"/>
                    </td>
            	</tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                             <a class="nui-button"  onclick="selectBrchcd()">
                                选择机构
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button"  onclick="setAllUspm()">
                                设置全部权限
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button"  onclick="setNull()">
                                清空重置
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
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
            var form = new nui.Form("dataform1");
            function loadData(data){
            	data = nui.clone(data);
                form.setData({comuspms:data});
                var json = nui.encode({comuser:data});
                $.ajax({
                	url:"com.sunline.sunfi.sunfi_cm.comuserbiz.getComUspm.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        nui.get("comuspms.permvl").setValue(returnJson.comuspms.permvl);
                        //form.setChanged(false);
                        	}
                                });
            }

            function saveData(){
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //var permvl = nui.get("comuspms.permvl").getValue();
                //保存
                var urlStr = "com.sunline.sunfi.sunfi_cm.comuserbiz.saveComUspm.biz.ext";
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功","系统提示");
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    CloseWindow("saveFailed");
                                }
                                });
                            }
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
                    var bootPath = "<%=request.getContextPath() %>";
			         //查询机构信息
			       function selectBrchcd() {
			        var permvl = nui.get("comuspms.permvl");
			        var permvlValue = permvl.getValue();
			        nui.open({
			            url: bootPath + "/sunfi_cm/brch/combrch_select.jsp",
			            showMaxButton: false,
			            title: "选择机构",
			            width: 870,
			            height: 480,
			            ondestroy: function(action){
			                if (action == "ok") {
			                    var iframe = this.getIFrameEl();
			                    var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                    if (data) {
			                        var getPermvl = data.brchsq;
			                        if(permvlValue == "" ){
			                           permvl.setValue(getPermvl);
			                        }else {
			                           permvlValue = permvlValue+","+getPermvl;
			                           permvl.setValue(permvlValue);
			                        }
			                    }
			                }
			            }
			        });            
			       }
			       function setAllUspm(){
			          var permvl = nui.get("comuspms.permvl");
			          permvl.setValue("-1");
			       }
			       function setNull(){
			         var permvl = nui.get("comuspms.permvl");
			          permvl.setValue(null);
			       }
			        
        </script>
    </body>
</html>