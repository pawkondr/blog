/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pl.java.blog.servlets;

import java.io.IOException;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pl.java.blog.ejb.BlogEjb;
import pl.java.blog.entities.Account;

/**
 *
 * @author pawko
 */
public class LoginServlet extends HttpServlet {

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

        String forwardTarget = "/jsp/login.jsp";

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "loginAction":
                    String login = request.getParameter("inputLogin");
                    String password = request.getParameter("inputPassword");
                    currentUser = blogEjb.getAcoount(login, password);
                    if (currentUser == null) {
                        request.setAttribute("message", "Incorrect user or password!");
                    } else {
                        request.setAttribute("message", "User succesfully logged in!");
                        request.getSession().setAttribute("currentUser", currentUser);
                        forwardTarget = "/MainServlet";
                    }
                    break;
            }
        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(forwardTarget);
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
