package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.utils.BeanUtils;
import com.common.utils.DateUtils;
import com.common.utils.ObjectUtil;
import com.fit.bean.SysRole;
import com.fit.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @Author AIM
 * @Des 角色管理
 * @DATE 2020/8/10
 */
@Controller
@RequestMapping("/admin/role")
public class RoleController extends BaseController {

    @Autowired
    private SysRoleService roleService;

    @GetMapping("/list")
    public String roleList(Model model) {
        return "admin/sys/role/list";
    }

    /**
     * 用户列表
     */
    @PostMapping("/list")
    @ResponseBody
    public void roleList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        List<SysRole> userList = roleService.findList(map);
        Long count = roleService.findCount(map);
        writeToJson(response, AjaxResult.tables(count, userList));
    }

    @GetMapping("/edit")
    public String roleEdit(Model model) {
        return "admin/sys/role/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public void roleEdit(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        try {
            SysRole role = BeanUtils.map2Bean(SysRole.class, map);
            if (ObjectUtil.isNotEmpty(role.getId())) {
                role.setUpdateTime(DateUtils.nowDate());
                roleService.update(role);
            } else {
                roleService.save(role);
            }
            writeToJson(response, AjaxResult.success("操作成功"));
        } catch (Exception e) {
            writeToJson(response, AjaxResult.error("操作失败"));
        }
    }
}
