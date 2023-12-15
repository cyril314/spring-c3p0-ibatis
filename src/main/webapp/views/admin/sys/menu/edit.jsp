<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="菜单编辑"/>
    <jsp:param name="tree" value="true"/>
    <jsp:param name="icon" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="menuId" value="${menu.menuId}" />
        <div class="layui-form-item">
            <label for="menuTree" class="layui-form-label"><span class="yadmin-red">*</span>上级名称</label>
            <div class="layui-input-block">
                <ul id="menuTree" class="dtree" data-id="-1" data-value="选择上级名称"></ul>
                <input type="hidden" id="pid" name="pid" value="${pid}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label"><span class="yadmin-red">*</span>名称</label>
            <div class="layui-input-block">
                <input type="text" id="name" placeholder="请输入菜单名称" name="name" value="${menu.name}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="code" class="layui-form-label"><span class="yadmin-red">*</span>编码</label>
            <div class="layui-input-block">
                <input type="text" id="code" placeholder="请输入菜单编码" name="code" value="${menu.code}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="url" class="layui-form-label"><span class="yadmin-red">*</span>访问地址</label>
            <div class="layui-input-block">
                <input type="text" id="url" placeholder="请输入访问地址" name="url" value="${menu.url}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sort" class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="number" id="sort" placeholder="请输入序号" name="sort" value="${menu.sort}" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="icon" class="layui-form-label">图标</label>
            <div class="layui-input-block">
                <input type="text" id="icon" placeholder="请选择图标" name="icon" value="${menu.icon}" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">是否目录</label>
            <div class="layui-input-block">
                 <input type="radio" id="menuFlag" name="menuFlag" value="Y" title="是" />
                <input type="radio" name="menuFlag" value="N" title="否" checked />
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
    iconPicker: 'layui/extend/icon/iconPicker',
}).use(['form', 'dtree', 'iconPicker', 'jquery'], function (form, dtree, iconPicker, $) {

    iconPicker.init("#icon");
    
    dtree.on("node('menuTree')", function (obj) {
        let typeDom = $('#pid');
        if (typeDom.val() === obj.param.nodeId) {
            typeDom.val('');
            $("input[dtree-id='pid']").val('请选择');
        } else {
            typeDom.val(obj.param.nodeId)
        }
    });
    
    dtree.renderSelect({
        elem: "#menuTree",
        url: "/menu/tree",
        dataStyle: "layuiStyle",
        selectInitVal: 0,
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
                dtree.dataInit("menuTree", $('#pid').val());
                dtree.selectVal("menuTree");
            }
            $('input:radio[name=menuFlag][value="${menu.menuFlag}"]').prop("checked", true);
            form.render('radio');
        }
    });
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '/menu/save',
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
