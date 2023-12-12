<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request"/>
<head>
    <title>${param.title}</title>
    <meta charset="utf-8"/>
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="Bookmark" href="${ctx}/images/favicon.ico"/>
    <link rel="Shortcut Icon" href="${ctx}/images/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/common.css"/>
    <c:if test="${param.index eq 'true'}"><link rel="stylesheet" type="text/css" href="${ctx}/css/yadmin.css"/></c:if>
    <c:if test="${param.login eq 'true'}"><link rel="stylesheet" type="text/css" href="${ctx}/css/login.css" /></c:if>
    <c:if test="${param.tree eq 'true'}"><link rel="stylesheet" type="text/css" href="${ctx}/layui/extend/dtree/dtree.css"></c:if>
    <c:if test="${param.icon eq 'true'}"><link rel="stylesheet" href="${ctx}/layui/extend/icon/icon.css"></c:if>
    <script type="text/javascript" charset="utf-8" src="${ctx}/layui/layui.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/lay-config.js"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/js/html5shiv.js"></script>
    <script type="text/javascript" src="${ctx}/js/respond.min.js"></script><![endif]--><!--[if IE 6]>
    <script type="text/javascript" src="${ctx}/js/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script><![endif]-->
</head>
