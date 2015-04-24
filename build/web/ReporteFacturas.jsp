<%-- 
    Document   : ReporteFacturas
    Created on : Dec 1, 2014, 4:21:10 PM
    Author     : dearmartinez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="clases.Datos"%>
<%@page import="clases.Reportes"%>
<%@page import="java.util.Date"%>
<%@page import="clases.Utilidades"%>
<%@page import="clases.Usuario"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="Encabezado.jsp"></jsp:include>
            <title>Sistema de Facturación</title>
            <script>
                $(document).ready(function () {
                    $("#fechaInicial").datepicker({dateFormat: "yy-mm-dd", changeMonth: true, changeYear: true});
                    $("#fechaFinal").datepicker({dateFormat: "yy-mm-dd", changeMonth: true, changeYear: true});
                });
            </script>
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

            // Muestra los mensajes del sistema
            String mensaje = "";

            // Identificamos el botón presionado    
            boolean generar = false;

            if (request.getParameter("generar") != null) {
                generar = true;
            }
            // Obtenemos el valor de como fue llamado el formulario
            String fechaInicial = "";
            String fechaFinal = "";

            if (request.getParameter("fechaInicial") != null) {
                fechaInicial = request.getParameter("fechaInicial");
            }
            if (request.getParameter("fechaFinal") != null) {
                fechaFinal = request.getParameter("fechaFinal");
            }

            if (fechaInicial.equals("")) {
                fechaInicial = Utilidades.formatDate(new Date());
            }
            if (fechaFinal.equals("")) {
                fechaFinal = Utilidades.formatDate(new Date());
            }

            // Si presionan el botón generar
            if (generar) {
                String sql = "SELECT bill.idBill, bill.idClient, "
                        + "CONCAT(names,' ', lastNames) AS fullName, "
                        + "date, idLine, idProduct, description, price, "
                        + "amount, (price * amount) as value "
                        + "from bill "
                        + "INNER JOIN clients ON clients.idClient = bill.idClient "
                        + "INNER JOIN detailbill ON detailbill.idBill = bill.idBill "
                        + "WHERE date >= '" + fechaInicial + "' AND date <= '" + fechaFinal + "'";
                Datos misDatos = new Datos();
                ResultSet resultSet = misDatos.getResultSet(sql);
                Reportes.reporteFacturas(resultSet);
                misDatos.cerrarConexion();
        %>
        <jsp:forward page="Reporte.pdf"></jsp:forward>
        <%
            }
        %>
        <h1>Reporte de Facturas</h1>
        <form name="ReporteFacturas" id="ReporteFacturas" action="ReporteFacturas.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Fecha Inicial:</td>
                        <td><input type="text" name="fechaInicial" id="fechaInicial" value="<%=fechaInicial%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Fecha Final:</td>
                        <td><input type="text" name="fechaFinal" id="fechaFinal" value="<%=fechaFinal%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Generar reporte" name="generar" id="generar"/></td>
                    </tr>
                </tbody>
            </table>

        </form>
        <br>
        <a href="javascript:history.back(1)">Página Anterior</a><br>
        <%
            if (miUsuarioLogueado.getIdProfile() == 1) {
        %>
        <a href="MenuAdministrador.jsp">Regresar al Menú</a>
        <%
        } else {
        %>
        <a href="MenuEmpleado.jsp">Regresar al Menú</a>
        <%
            }
        %>
    </body>
</html>
