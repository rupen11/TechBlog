
package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
    public static boolean deleteFile(String path){
        boolean bool = false;
        
        try {
            
            File file = new File(path);
            
            bool = file.delete();
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return bool;
    }
    
    public static boolean saveFile(InputStream is, String path){
        boolean bool = false;
        try {

            byte b[] = new byte[is.available()];
            
            is.read(b);
            
            FileOutputStream fo = new FileOutputStream(path);
            
            fo.write(b);
            fo.flush();
            fo.close();
            bool = true;
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return bool;
    }
}
