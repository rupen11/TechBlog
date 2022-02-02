package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

public class UserDao {
    
    private Connection con;
    private Statement stat;
    
    public UserDao(Connection con){
        this.con = con;
    }
    
//    Method to insert user data
    
    public boolean saveUser(User user){
        boolean save=false;
        try{
            System.out.println(user.getProfileimage());
            stat = con.createStatement();
            String query = "insert into user values(null, '"+user.getName()+"', '"+user.getEmail()+"', '"+user.getPassword()+"', '"+user.getGender()+"', '"+user.getAbout()+"', curdate(), '"+user.getProfileimage()+"')";
            stat.executeUpdate(query);
            System.out.println("Registered");
            save=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        System.out.println(save);
        return save;
    }
    
    public User existUser(String user_email, String user_password){
        User user = null;
        try {
             stat = con.createStatement();
             String query = "select * from user where email = '"+user_email+"' and password = '"+user_password+"' ";
             ResultSet rs = stat.executeQuery(query);
             
             if(rs.next()){
                 user = new User();
                 int id = rs.getInt("id");
                 String name = rs.getString("name");
                 String password = rs.getString("password");
                 String email = rs.getString("email");
                 String gender = rs.getString("gender");
                 String about = rs.getString("about");
                 Timestamp dateTime = rs.getTimestamp("rdate");
                 String profileimage = rs.getString("profileimage");
                 
                 user.setId(id);
                 user.setName(name);
                 user.setPassword(password);
                 user.setEmail(email);
                 user.setGender(gender);
                 user.setAbout(about);
                 user.setDateTime(dateTime);
                 user.setProfileimage(profileimage);
                 
             }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(User user){
        boolean update=false;
        try{
            stat = con.createStatement();
            String query = "update user set name='"+user.getName()+"', email='"+user.getEmail()+"', password='"+user.getPassword()+"', about='"+user.getAbout()+"', profileimage='"+user.getProfileimage()+"' where id="+user.getId()+" ";
            stat.executeUpdate(query);
            System.out.println("Updated");
            update = true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return update;
    }
    
    public User getUserByUserId(int userId){
        User user = null;
        
        try {
            stat = con.createStatement();
            String query = "select * from user where id = '"+userId+"'";
            ResultSet rs = stat.executeQuery(query);
            while(rs.next()){
                user = new User();
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String gender = rs.getString("gender");
                String about = rs.getString("about");
                Timestamp dateTime = rs.getTimestamp("rdate");
                String profileimage = rs.getString("profileimage");

                user.setId(id);
                user.setName(name);
                user.setPassword(password);
                user.setEmail(email);
                user.setGender(gender);
                user.setAbout(about);
                user.setDateTime(dateTime);
                user.setProfileimage(profileimage);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
}
