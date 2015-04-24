<%-- 
    Document   : ListadoUsuarios
    Created on : Dec 1, 2014, 2:43:04 PM
    Author     : dearmartinez
--%>

<%@page import="clases.Utilidades"%>
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
        <h1>Listado de Productos</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Producto</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>IVA</th>
                    <th>Notas</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet resultSet = misDatos.getProductos();
                    while (resultSet.next()) {
                %>
                <tr>
                    <td><%=resultSet.getString("idProduct")%></td>
                    <td><%=resultSet.getString("description")%></td>
                    <td><%=resultSet.getInt("price")%></td>
                    <td><%=Utilidades.iva(resultSet.getInt("idIVA"))%></td>
                    <td><%=resultSet.getString("notes")%></td>
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
