package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PostDao {
    private Connection con;
    private Statement stat;
    
    public PostDao(Connection con){
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list = new ArrayList<>();
        try {
            String query = "select * from categories";
            stat = con.createStatement();
            ResultSet rs = stat.executeQuery(query);
            while(rs.next()){
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                Category cat = new Category(cid, name, description);
                list.add(cat);
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f = false;
        try {
            stat = con.createStatement();
                String query = "insert into posts values(null, '"+p.getpTitle()+"', '"+p.getpContent()+"', '"+p.getpCode()+"', '"+p.getpPic()+"',curdate(), '"+p.getCatId()+"', '"+p.getUserId()+"')";
            stat.executeUpdate(query);
            f = true;
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
