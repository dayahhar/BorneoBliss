/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.traveler.view;
import com.traveler.model.SignupItem;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author dayah
 */
public class SuccessServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SignupItem signupItem = (SignupItem) request.getAttribute("signupItem");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Sign Up Application: Success</title>");
        out.println("<body bgcolor='white'>");
        
        out.println("<h1>Sign Up Success</h1>");
        out.println("You have successfuly signed up: <br/>");
        out.println("Name: "+signupItem.getName()+"<br/>");
        out.println("Username: "+signupItem.getUsername() +"<br/>");
        out.println("Email: "+signupItem.getUsername()+"<br/>");
        out.println("Nationality: "+signupItem.getNationality()+"<br/>");
        out.println("Passport No: "+signupItem.getPassportNo()+"<br/>");
        out.println("Country: "+signupItem.getCountry()+"<br/>");
        
        out.println("<br/><a href='index.html'>Home</a>");
        
        out.println("</body>");
        out.println("</html>");
        out.close();
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
