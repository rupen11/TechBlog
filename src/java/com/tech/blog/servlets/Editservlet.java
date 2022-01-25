package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class Editservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String about = request.getParameter("about");
            Part part = request.getPart("profileimage");
            String imagename = part.getSubmittedFileName();
            
            //Get the user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldImage = user.getProfileimage();
            user.setProfileimage(imagename);
            
            //Update data on database
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            if(dao.updateUser(user)){
                System.out.println("Data Updated");
                
                //get path
                String path = request.getRealPath("/") + "pics"+ File.separator + user.getProfileimage();
                
                String oldImagePath = request.getRealPath("/") + "pics" + File.separator + oldImage;
                
                Helper.deleteFile(oldImagePath);
                
                if(Helper.saveFile(part.getInputStream(), path)){
                    System.out.println("Profile image updated");
                    Message updateMsg = new Message("Profile updated", "success", "alert-success");
                    session.setAttribute("msg", updateMsg);
                }
                else{
                    System.out.println("Profile image not updated");
                    Message updateMsg = new Message("Some error to update profile photo", "error", "alert-danger");
                    session.setAttribute("msg", updateMsg);
                }
            }
            else{
                System.out.println("Some error");
                Message updateMsg = new Message("Some error to update profile", "error", "alert-danger");
                session.setAttribute("msg", updateMsg);
            }
            response.sendRedirect("profile.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
