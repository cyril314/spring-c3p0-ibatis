package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.bean.MenuNode;
import com.common.utils.BeanUtils;
import com.common.utils.ObjectUtil;
import com.fit.bean.SysMenu;
import com.fit.service.SysMenuService;
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
 * @Des 资源控制器
 * @DATE 2020/8/13
 */
@Controller
@RequestMapping("/admin/menu")
public class MenuController extends BaseController {

    @Autowired
    private SysMenuService service;

    @GetMapping("/list")
    public String menuList(Model model) {
        return "admin/sys/menu/list";
    }

    /**
     * 资源列表
     */
    @PostMapping("/list")
    @ResponseBody
    public void menuList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        List<SysMenu> list = service.findList(map);
        Long count = service.findCount(map);
//        MenuNode tree = BeanUtils.buildTree(list, SysMenu.class);
        writeToJson(response, AjaxResult.tables(count, list));
    }

    @GetMapping("/edit")
    public String menuEdit(Long id, Model model) {
        if (ObjectUtil.isNotEmpty(id)) {
            SysMenu menu = service.get(id);
            model.addAttribute("menu", menu);
        }
        return "admin/sys/menu/edit";
    }

    @PostMapping("/save")
    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        try {
            SysMenu menu = BeanUtils.map2Bean(SysMenu.class, map);
            if (ObjectUtil.isNotEmpty(menu.getId())) {
                service.update(menu);
            } else {
                service.save(menu);
            }
            writeToJson(response, AjaxResult.success());
        } catch (Exception e) {
            writeToJson(response, AjaxResult.error("操作失败"));
        }
    }

    /**
     * 修改状态
     */
    @RequestMapping("/setState")
    @ResponseBody
    public Object changeState(@RequestParam Long id) {
        SysMenu menu = this.service.get(id);
        if (menu != null) {
            if (menu.getEnabled()) {
                menu.setEnabled(false);
            } else {
                menu.setEnabled(true);
            }
            this.service.update(menu);
            return AjaxResult.success();
        }
        return AjaxResult.error("修改状态失败");
    }
}
