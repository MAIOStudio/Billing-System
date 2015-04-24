<%-- 
    Document   : ListadoUsuarios
    Created on : Dec 1, 2014, 2:43:04 PM
    Author     : dearmartinez
--%>

<%@page import="clases.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.Datos"%>
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
            if (miUsuarioLogueado.getIdProfile() != 1) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
        %>
        <h1>Listado de Usuarios</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Usuario</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Perfil</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet resultSet = misDatos.getUsuarios();
                    while (resultSet.next()) {
                %>
                <tr>
                    <td><%=resultSet.getString("idUser")%></td>
                    <td><%=resultSet.getString("names")%></td>
                    <td><%=resultSet.getString("lastNames")%></td>
                    <td><%=(resultSet.getString("idProfile").equals("1") ? "Administrador" : "Empleado")%></td>
                    <td><img src="<%="images/" + resultSet.getString("photo")%>" width="80" height="80"/></td>
                </tr>
                <%
                    }
                    misDatos.cerrarConexion();
                %>
            </tbody>
        </table>
        <a href="javascript:history.back(1)">Página Anterior</a><br>
        <a href="MenuAdministrador.jsp">Regresar al Menú</a>
    </body>
</html>
