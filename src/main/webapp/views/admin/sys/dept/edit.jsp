<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<jsp:include page="../../../head.jsp">
    <jsp:param name="title" value="部门编辑"/>
    <jsp:param name="tree" value="true"/>
</jsp:include>
<body style="background-color:#fff">
<div class="yadmin-body animated fadeIn">
    <div class="layui-form layui-form-pane">
        <input type="hidden" name="id" value="${dept.id}" />
        <div class="layui-form-item">
            <label for="deptTree" class="layui-form-label">上级名称</label>
            <div class="layui-input-block">
                <ul id="deptTree" class="dtree" data-id="0" data-value="选择上级名称"></ul>
                <input type="hidden" id="pid" name="pid" value="${dept.pid}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="simpleName" class="layui-form-label"><span class="yadmin-red">*</span>部门简称</label>
            <div class="layui-input-block">
                <input type="text" id="simpleName" placeholder="请输入名称" name="simpleName" value="${dept.simpleName}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="fullName" class="layui-form-label"><span class="yadmin-red">*</span>部门全称</label>
            <div class="layui-input-block">
                <input type="text" id="fullName" placeholder="请输入名称" name="fullName" value="${dept.fullName}" lay-verify="required" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="sort" class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="number" id="sort" placeholder="请输入序号" name="sort" value="${dept.sort}" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="version" class="layui-form-label">版本</label>
            <div class="layui-input-block">
                <input type="number" id="version" placeholder="请输入序号" name="sort" value="${dept.version}" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="notes" class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" id="notes" placeholder="请输入备注" name="description" value="${dept.notes}" lay-vertype="tips" autocomplete="off" class="layui-input" />
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="enabled" value="1" title="正常" <c:if test="${dept.enabled}">checked</c:if> >
                <input type="radio" name="enabled" value="0" title="冻结" <c:if test="${not dept.enabled}">checked</c:if> >
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
    layui.use(['form', 'dtree'], function (form, dtree) {
        dtree.on("node('deptTree')", function (obj) {
            let typeDom = layui.$('#pid');
            if (typeDom.val() === obj.param.nodeId) {
                typeDom.val('');
                layui.$("input[dtree-id='deptTree']").val('请选择');
            } else {
                typeDom.val(obj.param.nodeId)
            }
        });

        dtree.renderSelect({
            elem: "#deptTree",
            url: "${ctx}/admin/dept/tree",
            dataStyle: "layuiStyle",
            selectInitVal: 1,
            width: "100%",
            method: "post",
            menubar: true,
            dataFormat: "list",
            ficon: ["1", "-1"],
            done: function (data, obj, first) {
                if (first) {
                    dtree.dataInit("deptTree", layui.$('#pid').val());
                    dtree.selectVal("deptTree");
                }
                layui.$('input:radio[name=status][value="${dept.enabled}"]').prop("checked", true);
            }
        });

        form.on('submit(submit-form)', function (obj) {
            $.ajax({
                type: "POST",
                url: '${ctx}/admin/dept/save',
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
