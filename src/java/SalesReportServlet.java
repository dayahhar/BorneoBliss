/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author nanab
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getSalesReport")
public class SalesReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Dummy sales data
        HashMap<String, Double> salesData = new HashMap<>();
        salesData.put("January", 1000.0);
        salesData.put("February", 1200.0);
        salesData.put("March", 1500.0);
        salesData.put("April", 1800.0);
        salesData.put("May", 1300.0);
        salesData.put("June", 1700.0);
        salesData.put("July", 1600.0);
        salesData.put("August", 1900.0);
        salesData.put("September", 1100.0);
        salesData.put("October", 1400.0);
        salesData.put("November", 2000.0);
        salesData.put("December", 2200.0);

        // Construct JSON response manually
        StringBuilder json = new StringBuilder("{");
        for (String month : salesData.keySet()) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append("\"").append(month).append("\":").append(salesData.get(month));
        }
        json.append("}");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.close();
    }
}

