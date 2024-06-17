<%-- 
    Document   : deleteSpecies
    Created on : 16-Jun-2024, 18:09:33
    Author     : Sarah Syazana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%
    String speciesID = request.getParameter("speciesID");
    response.sendRedirect("deleteSpecies?speciesID=" + speciesID);
%>