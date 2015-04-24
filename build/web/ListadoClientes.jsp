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
        <h1>Listado de Clientes</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID Cliente</th>
                    <th>Tipo</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Dirección</th>
                    <th>Teléfono</th>
                    <th>Ciudad</th>
                    <th>Fecha Nacimiento</th>
                    <th>Fecha Ingreso</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Datos misDatos = new Datos();
                    ResultSet resultSet = misDatos.getClientes();
                    while (resultSet.next()) {
                %>
                <tr>
                    <td><%=resultSet.getString("idClient")%></td>
                    <td><%=Utilidades.tipo(resultSet.getInt("idType"))%></td>
                    <td><%=resultSet.getString("names")%></td>
                    <td><%=resultSet.getString("lastNames")%></td>
                    <td><%=resultSet.getString("address")%></td>
                    <td><%=resultSet.getString("phone")%></td>
                    <td><%=Utilidades.ciudad(resultSet.getInt("idCity"))%></td>
                    <td><%=resultSet.getString("dateBirth")%></td>
                    <td><%=resultSet.getString("dateEntry")%></td>
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
