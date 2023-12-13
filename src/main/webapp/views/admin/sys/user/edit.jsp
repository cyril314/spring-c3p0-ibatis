<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户编辑"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="id" value="${user.id}" />
        <div class="layui-form-item">
            <label for="deptTree" class="layui-form-label"><span class="yadmin-red">*</span>部门</label>
            <div class="layui-input-block">
                <ul id="deptTree" class="dtree" data-id="0" data-value="请选择"></ul>
                <input type="hidden" id="deptId" name="deptId" value="${user.deptId}"/>
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
        <c:if test="${empty user}">
        <div class="layui-form-item">
            <label for="account" class="layui-form-label"><span class="yadmin-red">*</span>账号名称</label>
            <div class="layui-input-block">
                <input type="text" id="account" placeholder="请输入账号名" name="account" value="${user.account}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <!-- 编辑时不显示密码框 -->
        <div class="layui-form-item">
            <label for="password" class="layui-form-label"><span class="yadmin-red">*</span>用户密码</label>
            <div class="layui-input-block">
                <input type="password" id="password" name="password" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        </c:if>
        <div class="layui-form-item">
            <label for="email" class="layui-form-label"><span class="yadmin-red">*</span>邮箱</label>
            <div class="layui-input-block">
                <input type="text" id="email" placeholder="请输入邮箱" name="email" value="${user.email}" lay-verify="required|email" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select id="sex" name="sex" class="layui-input" lay-verify="required" lay-vertype="tips">
                    <option>请选择</option>
                    <option value="0" <c:if test="${user.sex eq 0}">selected</c:if> >女</option>
                    <option value="1" <c:if test="${user.sex eq 1}">selected</c:if> >男</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="birthday" class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input type="text" id="birthday" name="birthday" class="layui-input" value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="enabled" value="1" title="正常" <c:if test="${user.enabled}">checked</c:if> >
                <input type="radio" name="enabled" value="0" title="冻结" <c:if test="${not user.enabled}">checked</c:if> >
            </div>
        </div>
        <div class="layui-form-item">
            <label for="notes" class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" id="notes" placeholder="说点什么..." name="notes" value="${user.notes}" autocomplete="off" class="layui-input">
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
layui.use(['jquery', 'form', 'dtree', 'laydate'], function ($, form, dtree, laydate) {
    laydate.render({
        elem: '#birthday', type: 'date', format: 'yyyy-MM-dd'
    });

    dtree.on("node('deptTree')", function (obj) {
        let typeDom = $('#deptId');
        if (typeDom.val() === obj.param.nodeId) {
            typeDom.val('');
            $("input[dtree-id='deptTree']").val('请选择');
        } else {
            typeDom.val(obj.param.nodeId)
        }
    });

    var depTree = dtree.renderSelect({
        elem: "#deptTree",
        url: "${ctx}/admin/dept/tree",
        dataStyle: "layuiStyle",
        selectInitVal: 1,
        width: "100%",
        method: "post",
        dataFormat: "list",
        ficon: ["1", "-1"],
        done: function (data, obj, first) {
            if (first) {
                dtree.dataInit("deptTree", $('#deptId').val());
                dtree.selectVal("deptTree");
            }
        }
    });

    form.on('submit(submit-form)', function (obj) {
        if(depTree.getNowParam().nodeId== "0") {
            layer.msg("请选择一个部门！", {icon: 5});
            return false;
        }
        $.ajax({
            type: "POST",
            url: '${ctx}/admin/user/save',
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
