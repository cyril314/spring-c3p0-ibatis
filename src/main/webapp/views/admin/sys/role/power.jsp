<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="设置角色"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body>
<div class="yadmin-body animated fadeIn">
    <div class="layui-card layui-form">
        <input type="hidden" name="roleId" value="${roleId}" />
        <input type="hidden" id="menus" name="menus" value="${menuIds}" />
        <div class="layui-form-item">
            <input class="layui-input" id="searchInput" value="" placeholder="输入查询节点内容...">
        </div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-normal table-action">查询</button>
            <button class="layui-btn layui-btn-normal" dtree-id="menuTree" dtree-menu="moveDown">展开全部</button>
            <button class="layui-btn layui-btn-normal" dtree-id="menuTree" dtree-menu="moveUp">收缩全部</button>
        </div>
        <div class="layui-form-item">
            <ul id="menuTree" class="dtree" data-id="-1" data-value="选择权限"></ul>
        </div>
        <div class="layui-form-item layui-layout-admin">
            <div class="layui-input-block">
                <div class="layui-footer">
                    <button class="layui-btn" lay-submit="" lay-filter="submit-form">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
layui.extend({
    dtree: 'layui/extend/dtree/dtree'
}).use(['form', 'dtree'], function (form, dtree, $) {
    dtree.render({
        elem: "#menuTree",
        url: "${ctx}/admin/menu/tree",
        method: "post",
        checkbar: "true",
        checkbarFun: {
            chooseDone: function (nodes) { //复选框点击事件完毕后，返回该树关于复选框操作的全部信息。
                $('#menus').val(dtree.getCheckedIds("menuTree"));
                return;
            }
        },
        initLevel: 2,
        dataStyle: "layuiStyle",
        dataFormat: "list",
        ficon: ["1", "1"],
        response: {
            statusCode: 0,
            message: "msg",
            title: "name",
            CheckArr: "data"
        },
        menubar: true,
        menubarTips: {
            toolbar: ["moveDown", "moveUp"],
            group: []
        },
        done: function (data, obj, first) {
            if (first) {
                dtree.chooseDataInit("menuTree", $('#menus').val());
                dtree.selectVal("menuTree");
            }
        }
    });
    
    form.on('submit(submit-form)', function (obj) {
        console.log(obj.field)
        $.ajax({
            type: "POST",
            url: '${ctx}/admin/role/savePower',
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
