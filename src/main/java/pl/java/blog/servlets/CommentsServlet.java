/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pl.java.blog.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pl.java.blog.ejb.BlogEjb;
import pl.java.blog.entities.Account;
import pl.java.blog.entities.Comment;
import pl.java.blog.entities.Post;

/**
 *
 * @author pawko
 */
public class CommentsServlet extends HttpServlet {

    @Inject
    private BlogEjb blogEjb;

    Account currentUser = null;

    public List<Comment> sortListDesc(List<Comment> list) {
        Collections.sort(list, new Comparator<Comment>() {
            @Override
            public int compare(Comment o1, Comment o2) {
                return o1.getCommnetDate().compareTo(o2.getCommnetDate());
            }
        });
        Collections.reverse(list);
        return list;
    }

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
                case "addComment":
                    Comment comment = new Comment();
                    String content = request.getParameter("postContent");
                    comment.setAuthor(currentUser);
                    comment.setCommnetDate(new Timestamp(new Date().getTime()));
                    comment.setContent(content);
                    int postId = Integer.valueOf(request.getParameter("currentPost"));
                    Post post = blogEjb.getPostById(postId);
                    post.getListOfComments().add(comment);
                    blogEjb.addPost(post);
                    break;
            }
        }

        int postId = Integer.valueOf(request.getParameter("currentPost"));
        Post post = blogEjb.getPostById(postId);
        List<Comment> listOfComments = post.getListOfComments();
        listOfComments = sortListDesc(listOfComments);

        request.setAttribute("listOfComments", listOfComments);
        request.setAttribute("post", post);

        String jspFile = "/jsp/comments.jsp";
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(jspFile);
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
