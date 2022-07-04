package com.eeit45team2.lungspringbootversion.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("user")
public class User{
    @TableId(type = IdType.AUTO)
    private Integer id;

    private String username;
    private String password;
    private String nickName;
    private Integer age;
    private String sex;
    private String address;
}
