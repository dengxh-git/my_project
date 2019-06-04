<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include  file="/common.jsp"%>
<html>
<%--
- Author(s): kaifasishi82
- Date: 2019-01-14 15:32:21
- Description:
    --%>
    <head>
        <title>
            WfFlowList录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/moneytypechange.js"></script>
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="wfflowlist.wfstid"/>
            <input class="nui-hidden" name="wfflowlist.minsumold"/> 
            <input class="nui-hidden" name="wfflowlist.maxsumold"/>
            <table class="nui-form-table">
                <tr>                                                           
                    <td class="nui-form-table-text">
                        	所属法人:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit" style="width: 180px;" required="true" name="wfflowlist.brchcd" onbuttonclick="selectBrch" allowInput="false" textName="wfflowlist.brchna"/>
                    </td>
                    <td class="nui-form-table-text">
                      	        机构类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" name="wfflowlist.flowtp" dictTypeId="FI_FLOWTP" value="0" valueField="dictID" textField="dictName"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                       		 业务项目:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit" style="width: 180px;" required="true" name="wfflowlist.typecd" onbuttonclick="selectType" allowInput="false" textName="wfflowlist.typena"/>
                    </td>              
                    <td class="nui-form-table-text">
                        	流程名称:
                    </td>
                    <td colspan="1">
                        <input class="nui-buttonedit" style="width: 180px;" required="true" name="wfflowlist.flowid" onbuttonclick="selectFlow" allowInput="false" textName="wfflowlist.wfname"/>
                    </td>
                </tr>
                <tr>
                    <td class="nui-form-table-text">
                        金额自(大于):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="wfflowlist.minsum" vtype="float" required="true"/>
                    </td>               
                    <td class="nui-form-table-text">
                          金额止(小于):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="wfflowlist.maxsum" vtype="float"/>
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

            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.sunline.sunfi.sunfi_wf.wfflowlistbiz.addWfFlowList.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.sunline.sunfi.sunfi_wf.wfflowlistbiz.updateWfFlowList.biz.ext";
                }
                if(nui.getbyName("wfflowlist.maxsum").getValue() !=""){
                nui.getbyName("wfflowlist.maxsum").setValue(moneyToNumValue(nui.getbyName("wfflowlist.maxsum").getValue()));
                }
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                //校验
                 $.ajax({
                    url:"com.sunline.sunfi.sunfi_wf.wfflowlistbiz.wfflowlistisexist.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){                         
                           if(returnJson.retCode.result=="1"){
							    var queryminsum = returnJson.retCode.queryminsum;
							    var querymaxsum = returnJson.retCode.querymaxsum;
							    if(querymaxsum=="999999999999.00"){
							    querymaxsum ="无穷大";
							    }
							    if(pageType=="edit"){
								    var oldminsum = nui.getbyName("wfflowlist.minsumold").getValue();
								    var oldmaxsum = nui.getbyName("wfflowlist.maxsumold").getValue();
								    var newminsum = nui.getbyName("wfflowlist.minsum").getValue();
								    var newmaxsum = nui.getbyName("wfflowlist.maxsum").getValue();
									     if(parseFloat(oldminsum)==parseFloat(newminsum) && parseFloat(oldmaxsum)==parseFloat(newmaxsum)){
									    	 $.ajax({
								                    url:urlStr,
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
									    	 return true;
									     }
							    } 
							    nui.alert("存在该配置下的最小金额:"+queryminsum+" 及最大金额:"+querymaxsum+" 请重新配置");
							    return false;
							    }else{
							     $.ajax({
					                    url:urlStr,
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
                           
                        }else{
                            nui.alert("系统错误", "系统提示", function(action){
                                
                                });
                            }
                        }
                        });                
               /*  //保存数据  
                */
                    } 

                    //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);                      

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                            var json = infos.record;

                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
                            form.setData(json);
                            nui.getbyName("wfflowlist.minsumold").setValue(moneyToNumValue(nui.getbyName("wfflowlist.minsum").getValue())); 
                            if(nui.getbyName("wfflowlist.maxsum").getValue()==""){
                            nui.getbyName("wfflowlist.maxsumold").setValue("999999999999.00"); 
                            }else{
                            nui.getbyName("wfflowlist.maxsumold").setValue(moneyToNumValue(nui.getbyName("wfflowlist.maxsum").getValue())); 
                            }
                            form.setChanged(false);
                        }
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
                     //选择法人
                    function selectBrch(){
                    var btnEdit = this;
                    nui.open({
				            url: "<%=request.getContextPath() %>/sunfi_cm/brch/combrch_select_by_not_power.jsp?brchtp=0000",
				            showMaxButton: false,
				            title: "选择法人",
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
				                }else{
			                            btnEdit.setValue("");
				                        btnEdit.setText("");
			                       }
				            }
				        });
                    }
                     //选择业务项目
                    function selectType(){
                    var btnEdit = this;
                    nui.open({
				            url: "<%=request.getContextPath() %>/sunfi_cm/type/afpItem_select.jsp",
				            showMaxButton: false,
				            title: "选择业务项目",
				            width: 950,
				            height: 600,
				            allowResize:false,
				            ondestroy: function(action){
				                if (action == "ok") {
				                    var iframe = this.getIFrameEl();
			                        var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                        if (data) {
				                        btnEdit.setValue(data.typecd);
				                        btnEdit.setText(data.typena);				                       
			                       }
				                }else{
			                            btnEdit.setValue("");
				                        btnEdit.setText("");
			                       }
				            }
				        });
                    }
                    //选择流程
                    function selectFlow(){
                    var btnEdit = this;
                    nui.open({
				            url: "<%=request.getContextPath() %>/sunfi_wf/configure/wf_configure_select.jsp",
				            showMaxButton: false,
				            title: "选择流程",
				            width: 950,
				            height: 600,
				            allowResize:false,
				            ondestroy: function(action){
				                if (action == "ok") {
				                    var iframe = this.getIFrameEl();
			                        var data = iframe.contentWindow.getData();
			                        data = nui.clone(data);
			                        if (data) {
				                        btnEdit.setValue(data.flowid);
				                        btnEdit.setText(data.wfname);				                       
			                       }
				                }else{
			                            btnEdit.setValue("");
				                        btnEdit.setText("");
			                       }
				            }
				        });
                    }
                </script>
            </body>
        </html>
