<%-- 
    Document   : MenuAdministrador
    Created on : Nov 27, 2014, 4:43:34 PM
    Author     : dearmartinez
--%>

<%@page import="clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="Encabezado.jsp"></jsp:include>
        <title>Sistema de Facturación</title>
    </head>
    <body>
         <%
            HttpSession sesion = request.getSession();
            Usuario miUsuarioLogueado = (Usuario) sesion.getAttribute("usuario");
            if (miUsuarioLogueado == null) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            if (miUsuarioLogueado.getIdProfile() != 2) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            String foto = miUsuarioLogueado.getFoto();
            if (foto == null) {
                foto = "";
            }
            if(foto.equals("")) {
                foto = "user.png";
            }
        %>
        <h1>Menú Principal</h1>
        <h2>Bienvenid@: <%=miUsuarioLogueado.getNames() + " " + miUsuarioLogueado.getLastNames()%></h2>
        <img src="<%="images/" + foto%>" width="150" height="150"/>
        <br><br>
        <a href="ReporteFacturas.jsp">Reporte Facturas</a><br>
        <a href="index.jsp">Salir</a> 
    </body>
</html>
