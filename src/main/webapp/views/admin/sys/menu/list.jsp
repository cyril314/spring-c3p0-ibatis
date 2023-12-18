<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="菜单列表"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body>
<div class="yadmin-body animated fadeIn">
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
<script>
layui.use(['tableTree', 'form'], function (tableTree, form) {
    layer.load(2);  //加载层
    var table = tableTree.render({
        id: 'menu',
        elem: '#table-list',
        url: '${ctx}/admin/menu/list',
        height: 'full-150',
        method: 'post',
        tree: {
            iconIndex: 2,
            isPidData: true,
        },
        toolbar: '#toolbar',
        cols: [
            [
                {type: 'checkbox'},
                {field: 'id', title: '序号', minWidth: 40},
                {field: 'name', title: '名称', minWidth: 70},
                {field: 'url', title: '请求地址', minWidth: 100},
                {field: 'sort', title: '排序', minWidth: 40},
                {field: 'level', title: '层级', minWidth: 40},
                {
                    field: 'mold', title: '类型', minWidth: 40, templet: function (res) {
                        return res.mold == "1"?"目录":"菜单";
                    }
                },
                {field: 'enabled', title: '状态', align: 'center', width: 100, templet:function(d) {
                    return '<input type="checkbox" lay-skin="switch" lay-filter="status" lay-text="启用|禁用" value="' +
                        d.id + '"' + (d.enabled ? " checked" : "") + '>';
                }},
                {fixed: 'right', title: '操作', align: 'center', toolbar: '#column-toolbar'}
            ]
        ],
        //数据渲染完的回调
        done: function () {
            //关闭加载
            layer.closeAll('loading');
        }
    });

    tableTree.on('toolbar', function (obj) {
        if (obj.event === 'add') {
            editView("${ctx}/admin/menu/edit", "添加菜单");
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么?', function (index) {
                let selectData = table.checkStatus('menu');
                if (selectData.length > 0) {
                    let idsArray = [];
                    for (let i = 0; i < selectData.length; i++) {
                        idsArray.push(selectData[i].id);
                    }
                    let ids = idsArray.toString();
                    changeReq(ids, '${ctx}/admin/menu/del')
                    layer.close(index);
                }
            });
        }
    });

    form.on('switch(status)', function (obj) {
        modifyReq('${ctx}/admin/menu/setState', {id: obj.value}, false);
    });

    tableTree.on('tool', function (obj) {
        let data = obj.data, event = obj.event;
        if (event === 'edit') {
            editView("${ctx}/admin/menu/edit?id=" + data.id, "编辑菜单");
        }
    });
});
</script>
</body>
</html>