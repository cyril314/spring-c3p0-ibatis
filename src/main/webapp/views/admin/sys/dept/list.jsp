<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="部门列表"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body>
<div class="yadmin-body animated fadeIn">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">部门树</div>
                <div class="layui-card-body" id="toolbarDiv">
                    <ul id="deptTree" class="dtree" data-id="0"></ul>
                </div>
            </div>
        </div>
        <div class="layui-col-md9">
            <div class="layui-card">
                <div class="layui-card-header" id="card-header">部门列表</div>
                <div class="layui-card-body">
                    <form class="layui-form yadmin-search-area input">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label for="simpleName" class="layui-form-label">关键字</label>
                                <div class="layui-input-inline">
                                    <input type="hidden" name="pid" value=""/>
                                    <input type="text" name="simpleName" autocomplete="off" placeholder="输入简称" id="simpleName" class="layui-input" />
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
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">
                            <i class="layui-icon layui-icon-edit" title="编辑">编辑</i>
                        </button>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
layui.use(['table', 'dtree', 'form', 'tablePlug'], function (table, dtree, form, tablePlug) {
    table.render({
        elem: '#table-list',
        url: '${ctx}/admin/dept/list',
        method: 'post',
        dataType: 'JSON',
        page: true,
        toolbar: '#toolbar',
        smartReloadModel: true,
        cols: [
            [
                {type: 'checkbox'},
                {field: 'simpleName', title: '简称', width: 80},
                {field: 'fullName', title: '全称', minWidth: 80},
                {field: 'sort', title: '排序', minWidth: 80},
                {field: 'description', title: '备注', minWidth: 160},
                {field: 'enabled', title: '状态', align: 'center', width: 100, templet:function(d) {
                    return '<input type="checkbox" lay-skin="switch" lay-filter="status" lay-text="启用|禁用" value="' +
                        d.id + '"' + (d.enabled ? " checked" : "") + '>';
                }},
                {fixed: 'right', title: '操作', align: 'center', toolbar: '#column-toolbar'}
            ]
        ]
    });
    // 工具条点击事件
    table.on('toolbar', function (obj) {
        if (obj.event === 'add') {
            editView("${ctx}/admin/dept/edit", "新增部门");
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么?', function (index) {
                let selectData = table.checkStatus('table-list').data;
                if (selectData.length > 0) {
                    let idsArray = [];
                    for (let i = 0; i < selectData.length; i++) {
                        idsArray.push(selectData[i].id);
                    }
                    let ids = idsArray.toString();
                    changeReq(ids, '${ctx}/admin/dept/del')
                    layer.close(index);
                }
            });
        }
    });
    // 行点击事件
    table.on('tool', function (obj) {
        let data = obj.data, event = obj.event;
        if (event === 'edit') {
            editView("${ctx}/admin/dept/edit?id=" + data.id, "编辑部门");
        }
    });
    dtree.render({
        elem: "#deptTree",
        url: "${ctx}/admin/dept/tree",
        method: "post",
        dataStyle: "layuiStyle",
        toolbar: false,  // 右键工具栏
        menubar: true,  // 树上方工具栏, 展开、收缩、刷新、搜索等
        dataFormat: "list",
    });

    dtree.on("node('deptTree')", function (obj) {
        table.reload('table-list', {
            where: {
                pid: obj.param.nodeId
            }
        });
        table.render();
    });
    tablePlug.smartReload.enable(true);
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