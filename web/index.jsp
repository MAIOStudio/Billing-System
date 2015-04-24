<%-- 
    Document   : index
    Created on : Nov 27, 2014, 10:59:40 AM
    Author     : dearmartinez
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="Encabezado.jsp"></jsp:include>
        <title>Aplicación Web</title>
        <script>
            $(document).ready(function () {
                $("#ValidarUsuario").submit(function () {
                    $.post("ValidarUsuario", $("#ValidarUsuario").serialize(), function (data) {
                        perfil = jQuery.trim(data);
                        if (perfil === "1")
                            document.location.href = "MenuAdministrador.jsp";
                        else if (perfil === "2")
                            document.location.href = "MenuEmpleado.jsp";
                        else
                            $("#Mensaje-ingreso").html("<h1> Usuario o clave no válido!</h1>");
                    });
                    return false;
                });
            });
        </script>
    </head>
    <body>
        <%
        session.invalidate();
        %>
        <h1>Ingreso al Sistema</h1>
        <form name="ValidarUsuario" id="ValidarUsuario" action="ValidarUsuario" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Usuario:</td>
                        <td><input type="text" name="usuario" id="usuario" value="" placeholder="Usuario" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Clave:</td>
                        <td><input type="password" name="clave" id="clave" value="" placeholder="Clave" size="10" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Ingresar" name="btnIngresar" id="btnIngresar"/></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <div id="Mensaje-ingreso"></div>
    </body>
</html>
