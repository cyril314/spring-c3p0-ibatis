<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <input type="hidden" name="id" value="${menu.id}" />
        <input type="hidden" id="level" name="level" value="${menu.level}" />
        <div class="layui-form-item">
            <label for="menuTree" class="layui-form-label"><span class="yadmin-red">*</span>上级名称</label>
            <div class="layui-input-block">
                <ul id="menuTree" class="dtree" data-id="0" data-value="选择上级名称"></ul>
                <input type="hidden" id="pid" name="pid" value="${pid}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label"><span class="yadmin-red">*</span>名称</label>
            <div class="layui-input-block">
                <input type="text" id="name" placeholder="请输入名称" name="name" value="${menu.name}" lay-verify="required" lay-vertype="tips" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="mold" class="layui-form-label"><span class="yadmin-red">*</span>类型</label>
            <div class="layui-input-block">
                <select id="mold" name="mold" class="layui-input" lay-verify="required" lay-vertype="tips">
                    <option>请选择</option>
                    <option value="1" <c:if test="${menu.mold eq 1}">selected</c:if> >目录</option>
                    <option value="2" <c:if test="${menu.mold eq 2}">selected</c:if> >按钮</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="url" class="layui-form-label">访问地址</label>
            <div class="layui-input-block">
                <input type="text" id="url" placeholder="请输入访问地址" name="url" value="${menu.url}" lay-vertype="tips" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="icon" class="layui-form-label">图标</label>
            <div class="layui-input-block">
                <input type="text" id="icon" placeholder="请选择图标" name="icon" value="${menu.icon}" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sort" class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="number" id="sort" placeholder="请输入序号" name="sort" value="${menu.sort}" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="enabled" value="1" title="正常" <c:if test="${menu.enabled}">checked</c:if> >
                <input type="radio" name="enabled" value="0" title="冻结" <c:if test="${not menu.enabled}">checked</c:if> >
            </div>
        </div>
        <div class="layui-form-item">
            <label for="notes" class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" id="notes" placeholder="说点什么..." name="notes" value="${menu.notes}" autocomplete="off" class="layui-input">
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
}).use(['jquery', 'form', 'dtree', 'iconPicker'], function ($, form, dtree, iconPicker) {

    iconPicker.init("#icon");
    
    dtree.on("node('menuTree')", function (obj) {
        let typeDom = $('#pid');
        if (typeDom.val() === obj.param.nodeId) {
            typeDom.val('');
            $("input[dtree-id='pid']").val('请选择');
        } else {
            typeDom.val(obj.param.nodeId)
            $("#level").val(parseInt(obj.param.level) + 1);
        }
    });
    
    dtree.renderSelect({
        elem: "#menuTree",
        url: "${ctx}/admin/menu/tree",
        dataStyle: "layuiStyle",
        selectInitVal: 1,
        width: "100%",
        method: "post",
        menubar: true,
        dataFormat: "list",
        ficon: ["1", "-1"],
        done: function (data, obj, first) {
            if (first) {
                dtree.dataInit("menuTree", $('#pid').val());
                dtree.selectVal("menuTree");
            }
            $('input:radio[name=menuFlag][value="${menu.enabled}"]').prop("checked", true);
            form.render('radio');
        }
    });

    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '${ctx}/admin/menu/save',
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
