<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<jsp:include page="../head.jsp">
    <jsp:param name="title" value="500 - 错误页面"/>
    <jsp:param name="index" value="true"/>
</jsp:include>
<body>
<div class="layui-fluid">
    <div class="lay-error-tips" style="margin: 50vh auto 0;transform: translateY(-50%);">
        <i class="layui-icon" face>&#xe664;</i>
        <div class="layui-text" style="font-size: 20px;">
            <h3 style="font-weight: 500;line-height: 100px;color: #009688;"> 好像出错了呢 </h3>
        </div>
    </div>
</div>
<input type="hidden" id="tips" value="${tips}"/>
</body>
<script>
    layui.use(['jquery', 'layer'], function () {
        var layer = layui.layer, $ = layui.jquery, errorMsg = $("#tips").val();
        if (errorMsg) {
            layer.msg(errorMsg, {icon: 5});
        }
    });
</script>
</html>
