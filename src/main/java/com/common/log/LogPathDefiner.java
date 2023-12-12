package com.common.log;

import ch.qos.logback.core.PropertyDefinerBase;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
public class LogPathDefiner extends PropertyDefinerBase {

    @Override
    public String getPropertyValue() {
        String LogPath = System.getProperty("user.dir");
        if (LogPath.toUpperCase().contains("tomcat".toUpperCase())) {
            LogPath = System.getProperty("catalina.home");
        } else {
            String dirPath = LogPath + File.separator + "target";
            File file = new File(dirPath);
            if (file.exists()) {
                LogPath = dirPath;
            }
        }
        LogPath += File.separator + "logs";
        System.out.println(" - log_path: " + LogPath);
        return LogPath;
    }
}
