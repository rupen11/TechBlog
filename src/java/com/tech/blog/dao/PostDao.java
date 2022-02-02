package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    private Connection con;
    private Statement stat;
    
    public PostDao(Connection con){
        this.con = con;
    }
    
    
//Get all category
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
    
    
//Save post
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
    

//Get all post    
    public List<Post> getAllPost(){
        
        List<Post> l = new ArrayList<>();
        try {
            String query = "select * from posts";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                l.add(post);
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return l;
    }
    
    
//Get post with category id    
    public List<Post> getAllPost(int catId){
        
        List<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where catId=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, catId);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int userId = rs.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, userId);
                list.add(post);
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    

//Get post with post id    
    public Post getPostByPostId(int postId){
        Post post = null;
        try {
            String query = "select * from posts where pid=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int cid = rs.getInt("catId");
                int userId = rs.getInt("userId");
                
                post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, cid, userId);
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return post;
    }
}
