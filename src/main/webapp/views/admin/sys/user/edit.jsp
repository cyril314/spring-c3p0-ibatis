<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户编辑"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="userId" value="${user.userId}" />
        <div class="layui-form-item">
            <label for="deptTree" class="layui-form-label"><span class="yadmin-red">*</span>部门</label>
            <div class="layui-input-block">
                <ul id="deptTree" class="dtree" data-id="0" data-value="请选择"></ul>
                <input type="hidden" id="deptId" name="deptId" value="${user.deptId}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="account" class="layui-form-label"><span class="yadmin-red">*</span>账号名称</label>
            <div class="layui-input-block">
                <input type="text" id="account" placeholder="请输入账号名" name="account" value="${user.account}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label"><span class="yadmin-red">*</span>用户名</label>
            <div class="layui-input-block">
                <input type="text" id="name" placeholder="请输入用户名" name="name" value="${user.name}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label"><span class="yadmin-red">*</span>电话号码</label>
            <div class="layui-input-block">
                <input type="text" id="phone" placeholder="请输入电话号码" name="phone" value="${user.phone}" maxlength="11" lay-verify="required|phone" lay-vertype="tips" autocomplete="off" class="layui-input">
            </div>
        </div>
        <!-- 编辑时不显示密码框 -->
        <div class="layui-form-item" if="${user} ? false : true">
            <label for="password" class="layui-form-label"><span class="yadmin-red">*</span>用户密码</label>
            <div class="layui-input-block">
                <input type="password" id="password" name="password" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="email" class="layui-form-label"><span class="yadmin-red">*</span>邮箱</label>
            <div class="layui-input-block">
                <input type="text" id="email" placeholder="请输入用户名" name="email" value="${user.email}" lay-verify="required|email" lay-vertype="tips" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select id="sex" name="sex" class="layui-input" lay-verify="required" lay-vertype="tips" with="type=${@dict.getType('SEX')}">
                    <option each="dict : ${type}" text="${dict.name}" value="${dict.code}" selected="${user.sex eq dict.code}"></option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="birthday" class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input type="text" id="birthday" name="birthday" class="layui-input" value="${#dates.format(user.birthday,'yyyy-MM-dd')}">
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" id="status" name="status" value="ENABLE" title="正常" />
                <input type="radio" name="status" value="LOCKED" title="冻结" checked />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="desc" class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" id="desc" placeholder="说点什么..." name="desc" value="${user.desc}" autocomplete="off" class="layui-input">
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
layui.extend({
    dtree: 'layui/extend/dtree/dtree'
}).use(['form', 'layer', 'dtree', 'laydate'], function () {
    var form = layui.form, dtree = layui.dtree, laydate = layui.laydate, $ = layui.$;
    
    laydate.render({
        elem: '#birthday', type: 'date', format: 'yyyy-MM-dd'
    });
    
    dtree.on("node('deptTree')", function (obj) {
        let typeDom = layui.$('#deptId');
        if (typeDom.val() === obj.param.nodeId) {
            typeDom.val('');
            layui.$("input[dtree-id='deptTree']").val('请选择');
        } else {
            typeDom.val(obj.param.nodeId)
        }
    });
    
    dtree.renderSelect({
        elem: "#deptTree",
        url: "/dept/tree",
        dataStyle: "layuiStyle",
        selectInitVal: 1,
        width: "100%",
        method: "post",
        menubar: true,
        dataFormat: "list",
        ficon: ["1", "-1"],
        response: {
            statusCode: 0,
            message: "msg",
            title: "name"
        }, done: function (data, obj, first) {
            if (first) {
                dtree.dataInit("deptTree", $('#deptId').val());
                dtree.selectVal("deptTree");
            }
            $('input:radio[name=status][value="[[${user.status}]]"]').prop("checked", true);
            form.render('radio');
        }
    });
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '/mgr/save',
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
