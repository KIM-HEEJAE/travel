package com.travel.controller;

import java.io.File;
import java.io.FileInputStream;
import java.nio.file.Files;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ImageController {

    @Value("${upload.path}")
    private String uploadPath;

    @RequestMapping("/image/view")
    public void viewImage(@RequestParam("filename") String filename, HttpServletResponse response) {
        try {
            File file = new File(uploadPath + filename);
            if (!file.exists()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            String mimeType = Files.probeContentType(file.toPath());
            response.setContentType(mimeType != null ? mimeType : "application/octet-stream");

            try (FileInputStream fis = new FileInputStream(file)) {
                fis.transferTo(response.getOutputStream());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}