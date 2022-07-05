package com.eeit45team2.lungspringbootversion.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.eeit45team2.lungspringbootversion.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;


@RestController
@RequestMapping("/files")
public class FileController {
    @Value("${server.port}")
    private String port;

    private static final String ip = "http://localhost";
    /**
     * 上傳
     * @param file
     * @return
     * @throws IOException
     */
    @PostMapping("/upload")
    public Result<?> upload(MultipartFile file) throws IOException {
        //獲取文件名稱
        String originalFilename = file.getOriginalFilename();
        //定義文件的唯一標誌 (前綴)
        String flag = IdUtil.fastSimpleUUID();
        //獲取上傳路徑
        String rootFilePath = System.getProperty("user.dir") + "/springboot/src/main/resources/files/" + flag + "_" + originalFilename;
        //使用hutool第三方Api寫進rootFilePath裡面
        FileUtil.writeBytes(file.getBytes(), rootFilePath);
        //返回結果 url
        return Result.success(ip + ":" + port + "/files/" + flag);
    }

    /**
     * 編譯器上傳
     * @param file
     * @return
     * @throws IOException
     */
    @PostMapping("/editor/upload")
    public JSON editorupload(MultipartFile file) throws IOException {
        //獲取文件名稱
        String originalFilename = file.getOriginalFilename();
        //定義文件的唯一標誌 (前綴)
        String flag = IdUtil.fastSimpleUUID();
        //獲取上傳路徑
        String rootFilePath = System.getProperty("user.dir") + "/springboot/src/main/resources/files/" + flag + "_" + originalFilename;
        //使用hutool第三方Api寫進rootFilePath裡面
        FileUtil.writeBytes(file.getBytes(), rootFilePath);
        String url = ip + ":" + port + "/files/" + flag;
        JSONObject json = new JSONObject();
        json.set("errno",0);
        JSONArray arr = new JSONArray();
        JSONObject data = new JSONObject();
        arr.add(data);
        data.set("url",url);
        json.set("data",arr);

        //返回結果 url
        return json;
    }

    /**
     * 下載
     * @param flag
     * @param response
     */
    @GetMapping("/{flag}")
    public void getFiles(@PathVariable String flag, HttpServletResponse response){
        //新建一個輸出流對象
        OutputStream os;
        //定義文件上船的根路徑
        String basePath = System.getProperty("user.dir") + "/springboot/src/main/resources/files/";
        //獲取文件名稱
        List<String> fileNames = FileUtil.listFileNames(basePath);
        //找到根參數一致的文件
        String fileName = fileNames.stream().filter(name -> name.contains(flag)).findAny().orElse("");
        try{
            if(StrUtil.isNotEmpty(fileName)) {
                response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
                response.setContentType("application/octet-stream");
                // 通過文件的路徑讀取文件字節流
                byte[] bytes = FileUtil.readBytes(basePath + fileName);
                // 通過輸出流返回文件
                os = response.getOutputStream();
                os.write(bytes);
                os.flush();
                os.close();
            }
        }catch (Exception e) {
            System.out.println("文件下載失敗");
        }
    }
}
