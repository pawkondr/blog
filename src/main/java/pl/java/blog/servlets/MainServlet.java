/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pl.java.blog.servlets;

import java.io.IOException;
import java.util.Date;
import java.sql.Timestamp;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pl.java.blog.ejb.BlogEjb;
import pl.java.blog.entities.Account;
import pl.java.blog.entities.Post;

/**
 *
 * @author pawko
 */
public class MainServlet extends HttpServlet {

    @Inject
    private BlogEjb blogEjb;

    Account currentUser = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getSession().getAttribute("currentUser") != null) {
            currentUser = (Account) request.getSession().getAttribute("currentUser");
        }
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "deletePostAction":
                    int postId = Integer.valueOf(request.getParameter("currentPost"));
                    blogEjb.deletePostById(postId);
                    break;
                case "newPostAction":
                    Post post = new Post();
                    post.setAuthor(currentUser);
                    post.setTitle(request.getParameter("postTitle"));
                    post.setContent(request.getParameter("postContent"));
                    post.setPostDate(new Timestamp(new Date().getTime()));
                    blogEjb.addPost(post);
                    break;
                case "logoutAction":
                    currentUser = null;
                    request.getSession().setAttribute("currentUser", currentUser);
                    request.setAttribute("message", "Succesfully logged out!");
                    break;
            }
        }

        List<Post> listOfPosts = blogEjb.getAllPosts();
        String jspFile = "/jsp/mainpage.jsp";
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jspFile);
        request.setAttribute("listOfPosts", listOfPosts);
        dispatcher.forward(request, response);
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
