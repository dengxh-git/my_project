<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %> 
<html>
<%--
- Author(s): kaifasishi82
- Date: 2018-11-27 15:35:03
- Description:
    --%>
    <head>
        <title>
            会计科目管理
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />                
    </head>
    <body>
            <div id="form1" class="nui-form" style="height: 10%">
               <input class="nui-hidden" name="criteria/_expr[5]/usedtp" value="1"/>
               <input id="detltg" class="nui-hidden" name="criteria/_expr[6]/detltg"/>
                <table id="table1" class="table" style="height:100%;width:100%;">
                    <tr>
                        <td style="font-size: 12px;text-align: right;">
                            科目代码:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[1]/itemcd"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            科目名称:
                        </td>
                        <td>
                            <input class="nui-textbox" name="criteria/_expr[2]/itemna"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            是否允许通用记账:
                        </td>
                        <td>
                            <input class="nui-dictcombobox" style="font-size: 12px;"  dictTypeId="FI_YESORNO" name="criteria/_expr[3]/itempr"  emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                        <td style="font-size: 12px;text-align: right;">
                            科目类型:
                        </td>
                        <td>
                            <input class="nui-dictcombobox" style="font-size: 12px;"  dictTypeId="FI_ITEMTP" name="criteria/_expr[4]/itemtp"  emptyText="全部"  showNullItem="true" nullItemText="全部"/>
                            <input class="nui-hidden" name="criteria/_expr[4]/_op" value="=">
                        </td>
                    </tr>
                </table>
            </div>          
        <div property="footer" align="center">
            <a class="nui-button" onclick="search()">
                查询
            </a>
            <a class="nui-button" onclick="reset()">
                重置
            </a>
        </div>            
            <div class="nui-fit">
                <div id="itemgrid" dataField="comitems" class="nui-datagrid" style="width:100%;height:100%;" 
                url="com.sunline.sunfi.sunfi_cm.comitembiz.queryComItems.biz.ext" pageSize="10" showPageInfo="true" 
                  onrowdblclick="onOk">
                    <div property="columns">
                        <div type="checkcolumn"></div>                       
                        <div field="itemcd" headerAlign="center" allowSort="true">科目代码 </div>
                        <div field="itemna" headerAlign="center" allowSort="true">科目名称</div>
                        <div field="sprrcd" headerAlign="center" allowSort="true">上级代码</div>
                        <div field="itemtp" headerAlign="center" allowSort="true" renderer="renderitemtype">科目类型 </div>
                        <div field="detltg" headerAlign="center" allowSort="true" renderer="renderitemdetl">是否末级 </div>
                        <div field="usedtp" headerAlign="center" allowSort="true" renderer="renderitemused">是否使用</div>                       
                    </div>
                </div>
            </div>
        <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;"  onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;"  onclick="onCancel()">取消</a>
    </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("itemgrid");
            var detltg = "<%= StringUtil.htmlFilter(request.getParameter("detltg")) %>";
            //是否末级
            if(detltg !="null") {
            var detltg1 = nui.get("detltg");
            detltg1.setValue(detltg);
            }  
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);
							    function getData() {
							        var row = grid.getSelected();
							        return row;
							    }
							
							    function CloseWindow(action) {
							        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
							        else window.close();
							    }
							
							    function onOk() {
							        CloseWindow("ok");
							    }
							    function onCancel() {
							        CloseWindow("cancel");
							    }

                                //查询
                                function search() {
                                    var form = new nui.Form("#form1");
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                }
                                //重置查询条件
                                function reset(){
                                    var form = new nui.Form("#form1");//将普通form转为nui的form
                                    form.reset();
                                    var detltg = "<%= StringUtil.htmlFilter(request.getParameter("detltg")) %>";
						            //是否末级
						            if(detltg !="null") {
						            var detltg1 = nui.get("detltg");
						            detltg1.setValue(detltg);
						            }  
                                }

                                 function renderitemtype(e) {
									return nui.getDictText("FI_ITEMTP",e.row.itemtp);
	                              }
	                             function renderitemused(e) {
									return nui.getDictText("FI_YESORNO",e.row.usedtp);
	                              }
	                             function renderitemdetl(e) {
									return nui.getDictText("FI_YESORNO",e.row.detltg);
	                              }                              
                            </script>
                        </body>
                    </html>
