<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="用户编辑"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="id" value="${role.id}" />
        <c:if test="${role.pid==0}">
        <div class="layui-form-item">
            <label for="roleTree" class="layui-form-label"><span class="yadmin-red">*</span>上级名称</label>
            <div class="layui-input-block">
                <ul id="roleTree" class="dtree" data-id="0" data-value="选择上级名称"></ul>
                <input type="hidden" id="pid" name="pid" value="${role.pid}">
            </div>
        </div>
        </c:if>
        <div class="layui-form-item">
            <label for="name" class="layui-form-label"><span class="yadmin-red">*</span>角色名称</label>
            <div class="layui-input-block">
                <input type="text" id="name" placeholder="请输入名称" name="name" value="${role.name}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="notes" class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" id="notes" placeholder="请输入备注" name="description" value="${role.notes}" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" id="ENABLED" name="1" value="ENABLE" title="正常" />
                <input type="radio" name="ENABLED" value="0" title="冻结" checked />
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
}).use(['form', 'dtree'], function (form, dtree) {
    if ("${role.pid}" != "0") {
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
            url: "${ctx}/admin/role/tree",
            dataStyle: "layuiStyle",
            selectInitVal: 1,
            width: "100%",
            method: "post",
            menubar: true,
            dataFormat: "list",
            ficon: ["1", "-1"],
            done: function (data, obj, first) {
                if (first) {
                    dtree.dataInit("roleTree", layui.$('#pid').val());
                    dtree.selectVal("roleTree");
                }
                layui.$('input:radio[name=status][value="${role.enabled}"]').prop("checked", true);
            }
        });
    }
    
    form.on('submit(submit-form)', function (obj) {
        $.ajax({
            type: "POST",
            url: '${ctx}/admin/role/save',
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
