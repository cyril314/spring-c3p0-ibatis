﻿<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户列表"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body>
<div style="padding: 20px; background-color: #F2F2F2;height:100%;">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md2">
            <div class="layui-card">
                <div class="layui-card-header">部门树</div>
                <div class="layui-card-body" id="toolbarDiv">
                    <ul id="deptTree" class="dtree" data-id="0"></ul>
                </div>
            </div>
        </div>
        <div class="layui-col-md10">
            <div class="layui-card">
                <div class="layui-card-header" id="card-header">用户列表</div>
                <div class="layui-card-body">
                    <form class="layui-form yadmin-search-area input">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label for="keywords" class="layui-form-label">关键字</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="keywords" autocomplete="off" placeholder="输入名称、邮箱" id="keywords" class="layui-input" />
                                </div>
                                <button lay-submit="" lay-filter="search" class="layui-btn layui-btn-sm layui-btn-primary table-action">
                                    <i class="layui-icon layui-icon-search"></i>
                                </button>
                                <button type="reset" lay-filter="search" class="layui-btn layui-btn-sm layui-btn-primary table-action">
                                    <i class="layui-icon layui-icon-refresh"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                    <script type="text/html" id="toolbar">
                        <button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="add">
                            <i class="layui-icon layui-icon-addition">新增</i>
                        </button>
                        <button type="button" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">
                            <i class="layui-icon layui-icon-delete" title="删除">删除</i>
                        </button>
                    </script>
                    <table class="layui-hide" id="table-list"></table>
                    <script type="text/html" id="column-toolbar">
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-xs" lay-event="info">
                            <i class="layui-icon layui-icon-edit" title="查看用户">查看</i>
                        </button>
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">
                            <i class="layui-icon layui-icon-edit" title="编辑用户">编辑</i>
                        </button>
                        <button type="button" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="setRole">
                            <i class="layui-icon layui-icon-password" title="设置角色">角色</i>
                        </button>
                        <button type="button" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="reset">
                            <i class="layui-icon layui-icon-password" title="密码重置">密码重置</i>
                        </button>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
layui.use(['table', 'dtree', 'form', 'tablePlug'], function (table, dtree, form, tablePlug) {
    var DTree = dtree.render({
        elem: "#deptTree",
        url: "${ctx}/admin/dept/tree",
        width: "60%",
        method: "post",
        dataStyle: "layuiStyle",
        toolbar: false, // 右键工具栏
        menubar: true,  // 树上方工具栏, 展开、收缩、刷新、搜索等
        ficon: ["1", "-1"],
        dataFormat: "list"
    });

    dtree.on("node('deptTree')", function (obj) {
        table.reload('table-list', {
            where: {
                deptId: obj.param.nodeId
            }
        });
    });
    tablePlug.smartReload.enable(true);
    table.render({
        elem: '#table-list',
        url: '${ctx}/admin/user/list',
        method: 'post',
        dataType: 'JSON',
        page: true,
        toolbar: '#toolbar',
        smartReloadModel: true,
        cols: [
            [
                {type: 'checkbox'},
                {field: 'id', title: 'ID', width: 50},
                {field: 'name', title: '用户名', minWidth: 20},
                {field: 'username', title: '登陆名', minWidth: 20},
                {field: 'notes', title: '备注', minWidth: 20},
                {field: 'enabled', title: '状态', align: 'center', width: 100, templet:function(d) {
                    return '<input type="checkbox" lay-skin="switch" lay-filter="status" lay-text="启用|禁用" value="' +
                        d.id + '"' + (d.enabled ? " checked" : "") + '>';
                }},
                {fixed: 'right', title: '操作', align: 'center', toolbar: '#column-toolbar', width: 320}
            ]
        ], parseData: function (res) {
            return {
                "code": res.code, //解析接口状态
                "msg": res.msg, //解析提示文本
                "data": res.data, //解析数据列表
                "count": res.count
            };
        }
    });
    // 工具条点击事件
    table.on('toolbar', function (obj) {
        if (obj.event === 'add') {
            editView("${ctx}/admin/user/edit", '添加用户');
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么?', function (index) {
                let selectData = table.checkStatus('table-list').data;
                if (selectData.length > 0) {
                    let idsArray = [];
                    for (let i = 0; i < selectData.length; i++) {
                        idsArray.push(selectData[i].userId);
                    }
                    let ids = idsArray.toString();
                    changeReq(ids, '${ctx}/admin/user/del')
                    layer.close(index);
                }
            });
        }
    });

    // 行点击事件 重置密码
    table.on('tool', function (obj) {
        let data = obj.data, event = obj.event;
        if (event === 'edit') {
            editView("${ctx}/admin/user/edit?id=" + data.id, '编辑用户');
        } else if (event === 'reset') {// 重置密码
            modifyReq('${ctx}/admin/user/reset', {userId: data.id}, false);
        } else if (event === 'info') {
            editView("${ctx}/admin/user/detail?id=" + data.id, '查看用户');
        } else if (event === 'setRole') {
            editView("${ctx}/admin/user/setRole?id=" + data.id, '用户角色');
        }
    });

    // 账号状态(正常/锁定)点击事件
    form.on('switch(status)', function (obj) {
        modifyReq('${ctx}/admin/user/setState', {userId: obj.value}, false);
    });

    form.on('submit(search)', function (form) {
        table.reload('table-list', {
            where: form.field
        });
        return false;
    });
});
</script>
</body>
</html>