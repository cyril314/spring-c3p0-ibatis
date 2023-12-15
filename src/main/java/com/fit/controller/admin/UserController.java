package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.utils.BeanUtils;
import com.common.utils.MD5Util;
import com.common.utils.ObjectUtil;
import com.fit.bean.SysUser;
import com.fit.service.SysDeptService;
import com.fit.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @Author AIM
 * @Des 用户管理
 * @DATE 2020/8/10
 */
@Controller
@RequestMapping("/admin/user")
public class UserController extends BaseController {

    @Autowired
    private SysUserService userService;
    @Autowired
    private SysDeptService deptService;

    @GetMapping("/list")
    public String userList(Model model) {
        return "admin/sys/user/list";
    }

    /**
     * 用户列表
     */
    @PostMapping("/list")
    @ResponseBody
    public void userList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        Object keywords = map.get("keywords");
        if (ObjectUtil.isNotEmpty(keywords)) {
            map.remove("keywords");
            if (keywords.toString().contains("@")) {
                map.put("email", keywords);
            } else {
                map.put("name", keywords);
            }
        }
        List<SysUser> userList = userService.findList(map);
        Long count = userService.findCount(map);
        writeToJson(response, AjaxResult.tables(count, userList));
    }

    @GetMapping("/edit")
    public String edit(Long id, Model model) {
        if (ObjectUtil.isNotEmpty(id)) {
            SysUser user = userService.get(id);
            model.addAttribute("user", user);
        }
        return "admin/sys/user/edit";
    }

    @PostMapping("/save")
    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        try {
            SysUser sysUser = BeanUtils.map2Bean(SysUser.class, map);
            if (ObjectUtil.isNotEmpty(sysUser.getId())) {
                userService.update(sysUser);
            } else {
                userService.save(sysUser);
            }
            writeToJson(response, AjaxResult.success("操作成功"));
        } catch (Exception e) {
            writeToJson(response, AjaxResult.error("操作失败"));
        }
    }

    @PostMapping("/del")
    @ResponseBody
    public void userDel(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        SysUser sysUser = BeanUtils.map2Bean(SysUser.class, map);
        Long delete = userService.delete(sysUser.getId());
        if (delete > 0) {
            writeToJson(response, AjaxResult.success("删除成功"));
        } else {
            writeToJson(response, AjaxResult.error("删除失败"));
        }
    }

    /**
     * 详情页面
     */
    @RequestMapping("/detail")
    public String detail(Long id, Model model) {
        if (ObjectUtil.isNotEmpty(id)) {
            SysUser sysUser = userService.get(id);
            model.addAttribute("user", sysUser);
        }
        return "admin/sys/user/info";
    }

    /**
     * 修改状态
     */
    @RequestMapping("/setState")
    @ResponseBody
    public Object changeState(@RequestParam Long userId) {
        SysUser sysUser = this.userService.get(userId);
        if (sysUser != null) {
            if (sysUser.getEnabled()) {
                sysUser.setEnabled(false);
            } else {
                sysUser.setEnabled(true);
            }
            this.userService.update(sysUser);
            return AjaxResult.success("修改成功");
        }
        return AjaxResult.error("修改状态失败");
    }

    /**
     * 重置用户的密码
     */
    @RequestMapping("/reset")
    @ResponseBody
    public Object reset(@RequestParam Long userId) {
        SysUser user = this.userService.get(userId);
        user.setPassword(MD5Util.MD5Encode("111111"));
        this.userService.update(user);
        return AjaxResult.success();
    }

    /**
     * 设置角色页面
     */
    @RequestMapping("/setRole")
    public String setRoleView(@RequestParam Long id, Model model) {
        SysUser sysUser = userService.get(id);
        model.addAttribute("roleId", sysUser.getRoleId());
        model.addAttribute("userId", id);
        return "admin/sys/user/setRole";
    }
}
