<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<jsp:include page="../head.jsp">
    <jsp:param name="title" value="首页"/>
    <jsp:param name="index" value="true"/>
</jsp:include>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <!-- logo 区域 -->
        <div class="layui-logo">
            <img src="${ctx}/images/logo.png" alt="logo" style="margin-left: -5px;background: #f0f0f0;border-radius:17px;"/>
            <cite>管理系统</cite>
        </div>
        <!-- 头部区域 -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a lay-event="flexible" title="侧边伸缩" lay-unselect>
                    <i class="layui-icon layui-icon-shrink-right"></i>
                </a>
            </li>
            <!-- 面包屑 -->
            <span class="layui-breadcrumb layui-anim layui-anim-up">
                <a><cite>首页</cite></a>
            </span>
        </ul>
        <!-- 头像区域 -->
        <ul class="layui-nav layui-layout-right">
            <!--<li class="layui-nav-item layui-hide-xs" lay-unselect>
                <a lay-event="clear" title="清理">
                    <i class="layui-icon layui-icon-delete"></i>
                </a>
            </li>-->
            <li class="layui-nav-item layui-hide-xs" lay-unselect>
                <a href="/" target="_blank" title="文档说明">
                    <i class="layui-icon layui-icon-website"></i>
                </a>
            </li>
            <li class="layui-nav-item layui-hide-xs" lay-unselect>
                <a id="layFull" lay-event="screenLayFull" lay-full="full" title="全屏">
                    <i class="layui-icon layui-icon-screen-full"></i>
                </a>
            </li>
            <li class="layui-nav-item user-selection">
                <a>
                    <img src="${ctx}/images/avatar.png" class="layui-nav-img" alt="头像">
                    <cite>${(empty username) ? '用户' : username}</cite>
                    <span class="layui-nav-more"></span>
                </a>
                <dl class="layui-nav-child">
                    <dd lay-unselect><a lay-event="userInfo">基本资料</a></dd>
                    <dd lay-unselect><a lay-event="editPwd">修改密码</a></dd>
                    <hr>
                    <dd lay-unselect><a href="@{/logout}">退出</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <!-- 左侧导航区域 -->
    <div class="layui-side">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree" lay-filter="lay-nav" lay-accordion="true">
                <li class="layui-nav-item">
                    <a lay-url="welcome.html" lay-id="home" lay-tips="主页" lay-direction="2">
                        <i class="layui-icon layui-icon-home"></i>
                        <cite>首页</cite>
                    </a>
                </li>
                <c:forEach var="menu" items="${menus}">
                    <li class="layui-nav-item">
                        <a lay-url="${ctx}${menu.url}" lay-id="${menu.id}" href="javascript:;">
                            <i class="${not empty menu.icon ? menu.icon : 'layui-icon ri-menu-add-line'}"></i>
                            <cite><c:out value="${menu.name}"/></cite>
                        </a>
                        <c:if test="${not empty menu.children}">
                            <dl class="layui-nav-child">
                                <c:forEach var="cmenu" items="${menu.children}">
                                    <dd>
                                        <a lay-url="${ctx}${cmenu.url}" lay-id="${cmenu.id}" href="javascript:;">
                                            <i class="${not empty cmenu.icon ? cmenu.icon : 'layui-icon ri-menu-add-line'}"></i>
                                            <cite><c:out value="${cmenu.name}"/></cite>
                                        </a>
                                        <c:if test="${not empty cmenu.children}">
                                            <dl class="layui-nav-child">
                                                <c:forEach var="emenu" items="${cmenu.children}">
                                                    <dd>
                                                        <a lay-url="${ctx}${emenu.url}" lay-id="${emenu.id}" href="javascript:;">
                                                            <i class="${not empty emenu.icon ? emenu.icon : 'layui-icon ri-menu-add-line'}"></i>
                                                            <cite><c:out value="${emenu.name}"/></cite>
                                                        </a>
                                                    </dd>
                                                </c:forEach>
                                            </dl>
                                        </c:if>
                                    </dd>
                                </c:forEach>
                            </dl>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-pagetabs">
            <div class="layui-icon admin-tabs-control layui-icon-refresh-3" lay-event="refresh"></div>
            <div class="layui-tab" lay-unauto lay-allowclose="true" lay-filter="lay-tab">
                <ul class="layui-tab-title">
                    <li lay-id="home" lay-url="welcome.html" class="layui-this">
                        <i class="layui-icon layui-icon-home"></i>
                    </li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <iframe src="${ctx}/welcome" class="layui-iframe" scrolling="yes"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</div>
</body>
</html>
