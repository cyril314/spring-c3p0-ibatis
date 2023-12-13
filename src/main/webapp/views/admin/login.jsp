﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="../head.jsp">
    <jsp:param name="title" value="登录"/>
    <jsp:param name="login" value="true"/>
</jsp:include>
<body>
<div class="lay-user-login-top lay-user-display-show" id="lay-user-login" style="display: none;">
    <div class="lay-user-login-main">
        <div class="lay-user-login-box lay-user-login-header">
            <h2 style="color: #fff;">管理系统</h2>
            <p lay-skin="primary">登录</p>
        </div>
        <form class="lay-user-login-box lay-user-login-body layui-form" action="${ctx}/login" method="post">
            <div class="layui-form-item">
                <label class="lay-user-login-icon layui-icon layui-icon-username" for="lay-login-username"></label>
                <input type="text" name="account" id="lay-login-username" lay-verify="required" placeholder="用户名" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="lay-user-login-icon layui-icon layui-icon-password" for="lay-login-password"></label>
                <input type="password" name="password" id="lay-login-password" lay-verify="pass" placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <input type="checkbox" name="remember" value="on" lay-skin="primary" class="lay-fff" title="记住密码"/>
                    </div>
                    <div class="layui-col-xs5">
                        <a href="logon.html" lay-skin="primary">用户注册</a>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button id="LAY-submit" class="layui-btn layui-btn-fluid" lay-submit lay-filter="lay-login-submit">登 入</button>
                <input type="hidden" id="tips" value="${tips}"/>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form', 'jquery', 'layer'], function () {
        var form = layui.form, layer = layui.layer, $ = layui.jquery;
        if (top.location != self.location) top.location = self.location;
        document.onkeydown = function (e) { // 回车提交表单
            var theEvent = window.event || e;
            var code = theEvent.keyCode || theEvent.which;
            if (code == 13) {
                $("#LAY-submit").trigger("click");
            }
        }
        form.verify({
            pass: [/^[\S]{5,12}$/, '密码必须5到12位，且不能出现空格']
        });
        //提交
        form.on('submit(lay-login-submit)');
        var errorMsg = $("#tips").val();
        if (errorMsg) {
            layer.msg(errorMsg, {icon: 5});
        }
    });
</script>
</body>
</html>