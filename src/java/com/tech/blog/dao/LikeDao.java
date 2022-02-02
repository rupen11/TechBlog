package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class LikeDao {
    private Connection con;
    private Statement stat;
    
    public LikeDao(Connection con){
        this.con = con;
    }
    
    
//    Like post
    public boolean insertLike(int pid, int uid){
        boolean f = false;
        try{
            stat = con.createStatement();
            stat.executeUpdate("insert into liked values (null, '"+pid+"', '"+uid+"')");
            f=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    
//    Count Like
    public int countLikeOnPost(int pid){
        int count = 0;
        try{
            stat = con.createStatement();
            ResultSet rs = stat.executeQuery("select count(*) from liked where pid='"+pid+"'");
            while(rs.next()){
                count = rs.getInt("count(*)");
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return count;
    }
    
    
//    Like by which user
    public boolean isLikedByUser(int pid, int uid){
        boolean f = false;
        try{
            stat = con.createStatement();
            ResultSet rs = stat.executeQuery("select * from liked where pid='"+pid+"' and uid='"+uid+"'");
            if(rs.next()){
                f = true;
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    
//    Unlike
    public boolean deleteLike(int pid, int uid){
        boolean f = false;
        try{
            stat = con.createStatement();
            stat.executeQuery("delete from liked where pid='"+pid+"' and uid='"+uid+"'");
            f = true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
    } 
}
