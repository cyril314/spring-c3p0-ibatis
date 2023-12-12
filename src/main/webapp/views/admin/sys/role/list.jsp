<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="角色列表"/>
</jsp:include>
<body>
<div class="yadmin-body animated fadeIn">
    <div class="layui-form yadmin-search-area input">
        <form class="layui-form-item">
            <div class="layui-inline">
                <label for="name" class="layui-form-label">名称</label>
                <div class="layui-input-inline">
                     <input type="text" name="name" id="name" placeholder="角色名称" class="layui-input" />
                </div>
                <button lay-submit="" lay-filter="search" class="layui-btn layui-btn-sm layui-btn-primary table-action">
                    <i class="layui-icon layui-icon-search"></i>
                </button>
                <button type="reset" lay-filter="search" class="layui-btn layui-btn-sm layui-btn-primary table-action">
                    <i class="layui-icon layui-icon-refresh"></i>
                </button>
            </div>
        </form>
    </div>
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
        <button type="button" class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">
            <i class="layui-icon layui-icon-edit" title="编辑角色">编辑</i>
        </button>
        <button type="button" class="layui-btn layui-btn-xs" lay-event="permiss">
            <i class="layui-icon layui-icon-edit" title="设置权限">权限</i>
        </button>
    </script>
</div>
<script>
layui.extend({
    tablePlug: 'layui/extend/tablePlug',
}).use(['table', 'form', 'tablePlug'], function (table,form,tablePlug) {
    tablePlug.smartReload.enable(true);
    table.render({
        elem: '#table-list',
        url: '${ctx}/admin/role/list',
        method: 'post',
        dataType: 'JSON',
        page: true,
        toolbar: '#toolbar',
        smartReloadModel: true,
        cols: [
            [
                {type: 'checkbox'},
                {field: 'name', title: '角色名称', minWidth: 80},
                {field: 'notes', title: '备注', minWidth: 80},
                {fixed: 'right', title: '操作', align: 'center', toolbar: '#column-toolbar'}
            ]
        ], parseData: function (res) {
            return {
                "code": res.code,
                "msg": res.msg,
                "data": res.data,
                "count": res.recordsTotal
            };
        }
    });
    // 工具条点击事件
    table.on('toolbar', function (obj) {
        if (obj.event === 'add') {
            editView("${ctx}/role/add", "新增角色");
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么?', function (index) {
                let selectData = table.checkStatus('table-list').data;
                if (selectData.length > 0) {
                    let idsArray = [];
                    for (let i = 0; i < selectData.length; i++) {
                        idsArray.push(selectData[i].roleId);
                    }
                    let ids = idsArray.toString();
                    changeReq(ids, '/role/del')
                    layer.close(index);
                }
            });
        }
    });

    // 行点击事件
    table.on('tool', function (obj) {
        let data = obj.data, event = obj.event;
        if (event === 'edit') {
            editView("${ctx}/role/update?id=" + data.roleId, "编辑角色");
        } else if (event === 'permiss') {
            editView("/role/setAssign?id=" + data.roleId, "角色权限");
        }
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