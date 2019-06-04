<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): admin-yc
  - Date: 2017-08-08 17:03:33
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
      body{
        background: #fff;
      }
      .block-content{
        width: 450px;
        height: 150px;
        margin: 100px auto;
        padding: 40px 50px;
        border:3px dashed #ddd;
      }
      .block-content .block_one{
        color: #f18d01;
        font-size: 24px;
        font-weight: bold;
        line-height: 40px;
        margin-bottom: 20px;
      }
      .block-content .block_two{
        color: #666;
      }
      .block-content .block_btn{
        padding:6px 12px;
        background: #f18d01;
        color: #fff;
        border:none;
        margin-top: 15px;
        cursor: pointer;
      }
       .block-content .block_btn:focus,
       .block-content .block_btn:hover,
       .block-content .block_btn:active{
         border:none;
         outline: none;
       }
    </style>
</head>
<body>
<div class="block-content">
  <p class="block_one">抱歉，该链接属于非法请求~</p>
  <p class="block_two">您访问的页面无法展现，我们建议您返回首页重新操作</p>
  <button class="block_btn" onclick="window.top.location.reload();">返回首页</button>
</div>

</body>
</html>