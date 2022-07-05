package com.eeit45team2.lungspringbootversion.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.eeit45team2.lungspringbootversion.common.Result;
import com.eeit45team2.lungspringbootversion.entity.Product;
import com.eeit45team2.lungspringbootversion.mapper.ProductMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/product")
public class ProductController {

    @Resource
    private ProductMapper productMapper;

    @PostMapping
    public Result<?> save(@RequestBody Product product){
        productMapper.insert(product);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Product product){
        productMapper.updateById(product);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id){
        productMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search){
        LambdaQueryWrapper<Product> wrapper = Wrappers.<Product>lambdaQuery();
        if(StrUtil.isNotBlank(search)){
            wrapper.like(Product::getName,search);
        }
        Page<Product> productPage = productMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(productPage);
    }
}
