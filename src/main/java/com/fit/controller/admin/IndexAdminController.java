package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.bean.MenuNode;
import com.common.bean.ZTreeNode;
import com.common.service.MenuNodeService;
import com.common.service.ZtreeNodeService;
import com.common.utils.MD5Util;
import com.common.utils.SystemUtil;
import com.fit.bean.SysUser;
import com.fit.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @AUTO 后台首页
 * @Author AIM
 * @DATE 2020/7/27
 */
@Controller
public class IndexAdminController extends BaseController {

    @Value("${server.port}")
    private String port;

    @Autowired
    private MenuNodeService menuService;
    @Autowired
    private SysUserService userService;
    @Autowired
    private ZtreeNodeService ztreeNodeService;

    /**
     * 获取部门树列表
     */
    @RequestMapping(value = "/admin/menu/tree")
    @ResponseBody
    public Object tree() {
        List<ZTreeNode> tree = this.ztreeNodeService.deptZtree();
        tree.add(ZTreeNode.createParent());
        return AjaxResult.success(200, "获取部门成功", tree);
    }

    @RequestMapping(value = {"", "/", "/index", "/index.jsp"})
    public String adminIndex(Model model, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login?error=true";
        } else {
            List<Long> userRoles = menuService.getUserRoles(user.getUsername());
            List<MenuNode> menus = menuService.getUserMenuNodes(userRoles);
            model.addAttribute("menus", menus);
            model.addAttribute("os", SystemUtil.getOsInfo());
            model.addAttribute("port", port);

            return "admin/index";
        }
    }

    @RequestMapping(value = {"/welcome", "/welcome.html"})
    public String welcome(HttpServletRequest request, Model model) {
        model.addAttribute("os", SystemUtil.getOsInfo());
        model.addAttribute("port", Integer.valueOf(request.getServerPort()));
        return "admin/welcome";
    }

    /**
     * @return 退出, 跳转到登陆页面
     */
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/admin/login";
    }

    @PostMapping("/login")
    public String login(SysUser user, HttpServletRequest request) {
        // 假设这里有一些验证逻辑来检查用户名和密码的正确性
        // 如果验证通过，则将用户信息存储在session中
        if (user.getPassword() != null) {
            user.setPassword(MD5Util.MD5Encode(user.getPassword()));
        }
        SysUser sysUser = userService.get(user);
        if (sysUser != null) {
            request.getSession().setAttribute("user", sysUser);
            return "redirect:/index"; // 重定向到用户的仪表板或其他受保护的页面
        } else {
            return "redirect:/login?error=true"; // 登录失败时重定向回登录页，并附带错误信息
        }
    }

    @GetMapping("/login")
    public String adminLogin() {
        return "admin/login";
    }
}
