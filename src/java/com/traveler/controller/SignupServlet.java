/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.traveler.controller;

import com.traveler.model.SignupItem;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author dayah
 */
@WebServlet(name="SignupServlet", urlPatterns={"/signup_process.do"})
public class SignupServlet extends HttpServlet{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignupServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errorMsgs = new LinkedList<>();
        try {
           //retrieve form parameters
           String name = request.getParameter("name");
           String email = request.getParameter("email");
           String username = request.getParameter("username");
           String password = request.getParameter("password");
           String nationality = request.getParameter("nationality");
           String passportNo = request.getParameter("passportNo");
           String country = request.getParameter("country");
           
           //form validation
           if((nationality==null)||(nationality.trim().length()==0)){
            nationality = request.getParameter("nationality");
           }
           if ((name==null)||(name.trim().length()==0)){
               errorMsgs.add("Please enter your name.");
           }
           if ((email==null)||(email.trim().length()==0)){
               errorMsgs.add("Please enter your email.");
           }
           if ((username==null)||(username.trim().length()==0)){
               errorMsgs.add("Please enter username.");
           }
           if ((password==null)||(password.trim().length()==0)){
               errorMsgs.add("Please enter password.");
           }
           if ((passportNo==null)||(passportNo.trim().length()==0)){
               errorMsgs.add("Please enter your passport number for security check.");
           }
           if ((country==null)||(country.trim().length()==0)){
               errorMsgs.add("Please enter your country of origin.");
           }
           
           if( !errorMsgs.isEmpty()){
            request.setAttribute("errorMsgs", errorMsgs);
            RequestDispatcher view = request.getRequestDispatcher("/signup.view");
            view.forward(request, response);
            return;
           }
           
           //business logic
           SignupItem SU = new SignupItem (name, email, username, password, nationality,passportNo, country);
            
           //store the item in requet scope
           request.setAttribute("signUp", SU);
           
           //dispatch to success view
            RequestDispatcher view = request.getRequestDispatcher("/success.view");//forward servlet to another page
            view.forward(request, response);
        }
        
        catch (RuntimeException e){
            errorMsgs.add("An unexpected error: " + e.getMessage());
            request.setAttribute("errorMsgs", errorMsgs);
            RequestDispatcher view = request.getRequestDispatcher("/signup.view");
            view.forward(request, response);
        }
    }
}
