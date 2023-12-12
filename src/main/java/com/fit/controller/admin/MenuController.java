package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.utils.BeanUtils;
import com.common.utils.ObjectUtil;
import com.fit.bean.SysMenu;
import com.fit.service.SysMenuService;
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
 * @Des 资源控制器
 * @DATE 2020/8/13
 */
@Controller
@RequestMapping("/admin/menu")
public class MenuController extends BaseController {

    @Autowired
    private SysMenuService service;

    @GetMapping("/list")
    public String resList(Model model) {
        return "admin/sys/menu/list";
    }

    /**
     * 资源列表
     */
    @PostMapping("/list")
    @ResponseBody
    public void resList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        List<SysMenu> userList = service.findList(map);
        Long count = service.findCount(map);
        writeToJson(response, AjaxResult.tables(count, userList));
    }

    @GetMapping("/edit")
    public String resEdit(Model model) {
        return "admin/sys/menu/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public void resEdit(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        try {
            SysMenu resources = BeanUtils.map2Bean(SysMenu.class, map);
            if (ObjectUtil.isNotEmpty(resources.getId())) {
                service.update(resources);
            } else {
                service.save(resources);
            }
            writeToJson(response, AjaxResult.success("操作成功"));
        } catch (Exception e) {
            writeToJson(response, AjaxResult.error("操作失败"));
        }
    }
}
