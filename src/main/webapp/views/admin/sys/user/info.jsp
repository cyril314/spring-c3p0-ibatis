<!DOCTYPE HTML>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:include="include :: head('用户详情')"></head>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label for="dept_name" class="layui-form-label">部门</label>
            <div class="layui-input-block">
                <input type="text" id="dept_name"  th:value="${user?.deptName}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="account" class="layui-form-label">账号名称</label>
            <div class="layui-input-block">
                <input type="text" id="account" name="account" th:value="${user?.account}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" id="name" name="name" th:value="${user?.name}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="email" class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" id="email" name="email" th:value="${user?.email}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select id="sex" name="sex" th:with="type=${@dict.getType('SEX')}" disabled>
                    <option th:each="dict : ${type}" th:text="${dict.name}" th:value="${dict.code}" th:selected="${user?.sex eq dict.code}"></option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="birthday" class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input type="text" id="birthday" name="birthday" class="layui-input" th:value="${#dates.format(user?.birthday,'yyyy-MM-dd')}" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input type="text" id="phone" name="phone" th:value="${user?.phone}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="desc" class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" id="desc" name="desc" th:value="${user?.desc}" class="layui-input" disabled/>
            </div>
        </div>
    </div>
</div>
<script>
layui.use(['form'], function () {
});
</script>
</body>
</html>
