package com.code.shop.config;


import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String os = System.getProperty("os.name");
        String pathPatterns="/pictures/**";
//        String pathAbsolute="file:C:/objectImg/";
        String pathAbsolute="file:"+System.getProperty("user.dir")+"\\src\\main\\webapp\\image\\pictures\\";
        if (os.toLowerCase().startsWith("linux")){
            pathAbsolute="file:/usr/upload/";
        }
        registry.addResourceHandler(pathPatterns).addResourceLocations(pathAbsolute);

    }

}
