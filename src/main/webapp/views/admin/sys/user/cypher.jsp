<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="修改密码"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label for="oldPassword" class="layui-form-label">旧密码</label>
            <div class="layui-input-block">
                <input type="password" id="oldPassword" placeholder="请输入旧密码" name="oldPassword" lay-verify="required" lay-vertype="tips" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="newPassword" class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="password" id="newPassword" placeholder="请输入新密码" name="newPassword" lay-verify="required" lay-vertype="tips" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="confirmPass" class="layui-form-label">确认密码</label>
            <div class="layui-input-block">
                <input type="password" id="confirmPass" placeholder="请输入确认密码" name="confirmPass" lay-verify="required|repass" lay-vertype="tips" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block layui-align">
                <button class="layui-btn layui-btn-normal btn-w100" lay-submit="" lay-filter="submit-form">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
layui.use(['form', 'layer'], function (form, $) {
    form.verify({
        repass: function (value) {
            if ($('#confirmPass').val() != $('#newPassword').val()) {
                return '两次密码不一致';
            }
        }
    });
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '${ctx}/admin/user/changePwd',
            data: obj.field,
            dataType: 'json',
            cache: false,
            success: function (data) {
                advices(data, parent);
            },
            error: function (event) {
                errors(event);
            }
        });
    });
});
</script>
</body>
</html>