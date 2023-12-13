<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户详情"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label for="account" class="layui-form-label">账号名称</label>
            <div class="layui-input-block">
                <input type="text" id="account" value="${user.account}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" id="name" value="${user.name}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="email" class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" id="email" value="${user.email}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sex" class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="text" id="sex" value="${user.sex eq 0 ?'女':(user.sex eq 1 ?'男':'')}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="birthday" class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input type="text" id="birthday" class="layui-input" value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input type="text" id="phone" name="phone" value="${user.phone}" class="layui-input" disabled/>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="notes" class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" id="notes" value="${user.notes}" class="layui-input" disabled/>
            </div>
        </div>
    </div>
</div>
</body>
</html>
