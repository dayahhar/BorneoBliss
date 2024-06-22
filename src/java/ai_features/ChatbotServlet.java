package ai_features;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/ChatbotServlet"})
public class ChatbotServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChatbotServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChatbotServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Retrieve user input from the form
        String userInput = request.getParameter("userInput");
        
        // Create an instance of the ChatbotBean
        ChatbotBean chatbot = new ChatbotBean();
        
        // Get response from the chatbot bean
        String botResponse = chatbot.getResponse(userInput);
        
        // Display the response
        out.println("<html>");
        out.println("<head><title>Chatbot Response</title></head>");
        out.println("<body>");
        out.println("<h1>Chatbot Response:</h1>");
        out.println("<p>" + botResponse + "</p>");
        out.println("</body></html>");
    }
  
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
