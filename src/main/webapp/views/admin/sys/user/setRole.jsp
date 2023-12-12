<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="设置角色"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="userId" th:value="${userId}" />
        <div class="layui-form-item" th:if="${role?.pid}==0 ? false : true">
            <label for="roleTree" class="layui-form-label"><span class="yadmin-red">*</span>上级名称</label>
            <div class="layui-input-block">
                <ul id="roleTree" class="dtree" data-id="0" data-value="选择上级名称"></ul>
                <input type="hidden" name="roleId" th:value="${roleId}" id="roleId" />
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
layui.extend({
    dtree: 'layui/extend/dtree/dtree'
}).use(['form', 'layer', 'dtree'], function () {
    var form = layui.form, layer = layui.layer, $ = layui.$, dtree = layui.dtree;
    dtree.on("node('roleTree')", function (obj) {
        let typeDom = layui.$('#roleId');
        if (typeDom.val() === obj.param.nodeId) {
            typeDom.val('');
            layui.$("input[dtree-id='roleTree']").val('请选择');
        } else {
            typeDom.val(obj.param.nodeId)
        }
    });
    
    dtree.renderSelect({
        elem: "#roleTree",
        url: "/role/tree",
        dataStyle: "layuiStyle",
        selectInitVal: 1,
        width: "100%",
        method: "post",
        menubar: true,
        dataFormat: "list",
        ficon: ["1", "-1"],
        response: {
            statusCode: 0,
            message: "msg",
            title: "name"
        }, done: function (data, obj, first) {
            if (first) {
                dtree.dataInit("roleTree", $('#roleId').val());
                dtree.selectVal("roleTree");
            }
        }
    });
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '/mgr/authRole',
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