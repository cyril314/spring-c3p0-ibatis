package com.fit.controller.admin;

import com.common.base.BaseController;
import com.common.bean.AjaxResult;
import com.common.utils.BeanUtils;
import com.common.utils.ObjectUtil;
import com.fit.bean.SysDept;
import com.fit.bean.SysMenu;
import com.fit.service.SysDeptService;
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
@RequestMapping("/admin/dept")
public class DeptController extends BaseController {

    @Autowired
    private SysDeptService service;

    @GetMapping("/list")
    public String resList(Model model) {
        return "admin/sys/dept/list";
    }

    /**
     * 资源列表
     */
    @PostMapping("/list")
    @ResponseBody
    public void resList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        List<SysDept> userList = service.findList(map);
        Long count = service.findCount(map);
        writeToJson(response, AjaxResult.tables(count, userList));
    }

    @GetMapping("/edit")
    public String edit(Long id, Model model) {
        if (ObjectUtil.isNotEmpty(id)) {
            SysDept bean = service.get(id);
            model.addAttribute("dept", bean);
        }
        return "admin/sys/dept/edit";
    }

    @PostMapping("/save")
    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = getRequestParamsMap(request);
        try {
            SysDept bean = BeanUtils.map2Bean(SysDept.class, map);
            if (ObjectUtil.isNotEmpty(bean.getId())) {
                service.update(bean);
            } else {
                service.save(bean);
            }
            writeToJson(response, AjaxResult.success("操作成功"));
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
        SysDept bean = this.service.get(id);
        if (bean != null) {
            if (bean.getEnabled()) {
                bean.setEnabled(false);
            } else {
                bean.setEnabled(true);
            }
            this.service.update(bean);
            return AjaxResult.success("修改成功");
        }
        return AjaxResult.error("修改状态失败");
    }
}
