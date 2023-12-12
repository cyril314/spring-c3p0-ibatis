<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户编辑"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="roleId" th:value="${role?.roleId}" />
        <div class="layui-form-item" th:if="${role?.pid}==0 ? false : true">
            <label for="roleTree" class="layui-form-label"><span class="yadmin-red">*</span>上级名称</label>
            <div class="layui-input-block">
                <ul id="roleTree" class="dtree" data-id="0" data-value="选择上级名称"></ul>
                <input type="hidden" id="pid" name="pid" th:value="${role?.pid}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label"><span class="yadmin-red">*</span>角色名称</label>
            <div class="layui-input-block">
                <input type="text" id="name" placeholder="请输入名称" name="name" th:value="${role?.name}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="description" class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" id="description" placeholder="请输入备注" name="description" th:value="${role?.description}" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sort" class="layui-form-label">序号</label>
            <div class="layui-input-block">
                <input type="text" id="sort" placeholder="请输入序号" name="sort" th:value="${role?.sort}" lay-vertype="tips" autocomplete="off" class="layui-input">
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
    if ("[[${role?.pid}]]" != "0") {
        dtree.on("node('roleTree')", function (obj) {
            let typeDom = layui.$('#pid');
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
                    dtree.dataInit("roleTree", $('#pid').val());
                    dtree.selectVal("roleTree");
                }
            }
        });
    }
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '/role/save',
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
