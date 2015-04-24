<%-- 
    Document   : Clientes
    Created on : Dic 03, 2014, 16:04:20 AM
    Author     : dearmartinez
--%>

<%@page import="java.util.Date"%>
<%@page import="clases.Utilidades"%>
<%@page import="clases.Cliente"%>
<%@page import="clases.Usuario"%>
<%@page import="clases.Datos"%>
<%@page buffer="16kb" autoFlush="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="Encabezado.jsp"></jsp:include>
            <title>Sistema de Facturación</title>
            <script>
                $(document).ready(function () {
                    $("#fechaNacimiento").datepicker({dateFormat: "yy-mm-dd", changeMonth: true, changeYear: true});
                    
                    $("#consultar").click(function () {
                        return validarCliente();
                    });

                    $("#nuevo").click(function () {
                        return validarTodo();
                    });

                    $("#modificar").click(function () {
                        return validarTodo();
                    });

                    $("#borrar").click(function () {
                        if (validarCliente()) {
                            $("<div></div>").html("Está seguro de borrar el registro?").
                                    dialog({title: "Confirmación", modal: true, buttons: [
                                            {
                                                text: "Si",
                                                click: function () {
                                                    $(this).dialog("close");
                                                    $.post("EliminarCliente", {idCliente: $("#idCliente").val()}, function (data) {
                                                        $("#idCliente").val("");
                                                        $("#idTipo").val("");
                                                        $("#nombres").val("");
                                                        $("#apellidos").val("");
                                                        $("#direccion").val("");
                                                        $("#telefono").val("");
                                                        $("#idCiudad").val("");
                                                        $("#fechaNacimiento").val("");
                                                        $("#fechaIngreso").val("");
                                                    });
                                                }
                                            },
                                            {
                                                text: "No",
                                                click: function () {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        ]
                                    });
                        }
                        return false;
                    });
                });

                function validarTodo() {
                    if (validarCliente()) {
                        if (validarTipo()) {
                            if (validarNombres()) {
                                return validarApellidos();
                            }
                        }
                    }
                    return false;
                }



                function validarCliente() {
                    if ($("#idCliente").val() == "") {
                        $("<div></div>").html("Debe ingresar un ID de cliente").
                                dialog({title: "Error de validación", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarTipo() {
                    if ($("#idTipo").val() == "0") {
                        $("<div></div>").html("Debe seleccionar un tipo de identificación").
                                dialog({title: "Error de validación", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarNombres() {
                    if ($("#nombres").val() == "") {
                        $("<div></div>").html("Debe ingresar un nombre(s) de cliente").
                                dialog({title: "Error de validación", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }

                function validarApellidos() {
                    if ($("#apellidos").val() == "") {
                        $("<div></div>").html("Debe ingresar un apellido(s) de cliente").
                                dialog({title: "Error de validación", modal: true, buttons: [
                                        {
                                            text: "Ok",
                                            click: function () {
                                                $(this).dialog("close");
                                            }
                                        }
                                    ]
                                });
                        return false;
                    }
                    return true;
                }
            </script>
        </head>
        <body>
        <%
            // Validaciones de seguridad
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

            // Muestra los mensajes del sistema
            String mensaje = "";

            // Identificamos el botón presionado    
            boolean consultar = false;
            boolean nuevo = false;
            boolean modificar = false;
            boolean borrar = false;
            boolean limpiar = false;
            boolean listar = false;

            if (request.getParameter("consultar") != null) {
                consultar = true;
            }
            if (request.getParameter("nuevo") != null) {
                nuevo = true;
            }
            if (request.getParameter("modificar") != null) {
                modificar = true;
            }
            if (request.getParameter("borrar") != null) {
                borrar = true;
            }
            if (request.getParameter("limpiar") != null) {
                limpiar = true;
            }
            if (request.getParameter("listar") != null) {
                listar = true;
            }

            // Obtenemos el valor de como fue llamado el formulario
            String idCliente = "";
            String idTipo = "";
            String nombres = "";
            String apellidos = "";
            String direccion = "";
            String telefono = "";
            String idCiudad = "";
            String fechaNacimiento = "";
            String fechaIngreso = "";

            if (request.getParameter("idCliente") != null) {
                idCliente = request.getParameter("idCliente");
            }
            if (request.getParameter("idTipo") != null) {
                idTipo = request.getParameter("idTipo");
            }
            if (request.getParameter("nombres") != null) {
                nombres = request.getParameter("nombres");
            }
            if (request.getParameter("apellidos") != null) {
                apellidos = request.getParameter("apellidos");
            }
            if (request.getParameter("direccion") != null) {
                direccion = request.getParameter("direccion");
            }
            if (request.getParameter("telefono") != null) {
                telefono = request.getParameter("telefono");
            }
            if (request.getParameter("idCiudad") != null) {
                idCiudad = request.getParameter("idCiudad");
            }
            if (request.getParameter("fechaNacimiento") != null) {
                fechaNacimiento = request.getParameter("fechaNacimiento");
            }
            if (request.getParameter("fechaIngreso") != null) {
                fechaIngreso = request.getParameter("fechaIngreso");
            }

            // Presionando el botón consultar
            if (consultar) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if (miCliente == null) {
                    idTipo = "";
                    nombres = "";
                    apellidos = "";
                    direccion = "";
                    telefono = "";
                    idCiudad = "";
                    fechaNacimiento = "";
                    fechaIngreso = "";
                    mensaje = "Cliente no existe";
                } else {
                    idCliente = miCliente.getIdClient();
                    idTipo = "" + miCliente.getIdType();
                    nombres = miCliente.getNames();
                    apellidos = miCliente.getLastNames();
                    direccion = miCliente.getAddress();
                    telefono = miCliente.getPhone();
                    idCiudad = "" + miCliente.getIdCity();
                    fechaNacimiento = Utilidades.formatDate(miCliente.getDateBirth());
                    fechaIngreso = Utilidades.formatDate(miCliente.getDateEntry());
                    mensaje = "Cliente consultado";
                }
                misDatos.cerrarConexion();
            }

            // Presionando el botón limpiar
            if (limpiar) {
                idCliente = "";
                idTipo = "";
                nombres = "";
                apellidos = "";
                direccion = "";
                telefono = "";
                idCiudad = "";
                fechaNacimiento = "";
                fechaIngreso = "";
                mensaje = "";
            }

            //Presionando el botón nuevo
            if (nuevo) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if (miCliente != null) {
                    mensaje = "CLiente ya existe";
                } else {
                    miCliente = new Cliente(
                            idCliente,
                            new Integer(idTipo),
                            nombres,
                            apellidos,
                            direccion,
                            telefono,
                            new Integer(idCiudad),
                            Utilidades.stringToDate(fechaNacimiento),
                            new Date());
                    misDatos.newCliente(miCliente);
                    mensaje = "Cliente ingresado con éxito";
                }
                misDatos.cerrarConexion();
            }

            //Presionando el botón editar
            if (modificar) {
                Datos misDatos = new Datos();
                Cliente miCliente = misDatos.getCliente(idCliente);
                if (miCliente == null) {
                    mensaje = "Cliente no existe";
                } else {
                    miCliente = new Cliente(
                            idCliente,
                            new Integer(idTipo),
                            nombres,
                            apellidos,
                            direccion,
                            telefono,
                            new Integer(idCiudad),
                            Utilidades.stringToDate(fechaNacimiento),
                            Utilidades.stringToDate(fechaIngreso));
                    misDatos.updateCliente(miCliente);
                    mensaje = "Cliente modificado con éxito";
                }
                misDatos.cerrarConexion();
            }

            // Presionando el botón Listar
            if (listar) {
        %>
        <jsp:forward page="ListadoClientes.jsp"></jsp:forward>
        <%
            }
        %>
        <h1>Clientes</h1>
        <form name="clientes" id="clientes" action="Clientes.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>ID Cliente *:</td>
                        <td><input type="text" name="idCliente" id="idCliente" value="<%=idCliente%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Tipo *:</td>
                        <td><select name="idTipo" id="idTipo">
                                <option value="0" <%=(idTipo.equals("") ? "selected" : "")%> >Seleccione un tipo...</option>
                                <option value="1" <%=(idTipo.equals("1") ? "selected" : "")%>>Cédula</option>
                                <option value="2" <%=(idTipo.equals("2") ? "selected" : "")%>>Licencia</option>
                                <option value="3" <%=(idTipo.equals("3") ? "selected" : "")%>>Pasaporte</option>
                                <option value="4" <%=(idTipo.equals("4") ? "selected" : "")%>>Visa</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Nombres *:</td>
                        <td><input type="text" name="nombres" id="nombres" value="<%=nombres%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Apellidos *:</td>
                        <td><input type="text" name="apellidos" id="apellidos" value="<%=apellidos%>" size="30" /></td>
                    </tr>
                    <tr>
                        <td>Dirección:</td>
                        <td><input type="text" name="direccion" id="direccion" value="<%=direccion%>" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Teléfono:</td>
                        <td><input type="text" name="telefono" id="telefono" value="<%=telefono%>" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Ciudad:</td>
                        <td><select name="idCiudad" id="idCiudad">
                                <option value="0" <%=(idCiudad.equals("") ? "selected" : "")%> >Seleccione una ciudad...</option>
                                <option value="1" <%=(idCiudad.equals("1") ? "selected" : "")%>>Paris</option>
                                <option value="2" <%=(idCiudad.equals("2") ? "selected" : "")%>>Praga</option>
                                <option value="3" <%=(idCiudad.equals("3") ? "selected" : "")%>>Tokio</option>
                                <option value="4" <%=(idCiudad.equals("4") ? "selected" : "")%>>Lisboa</option>
                                <option value="5" <%=(idCiudad.equals("5") ? "selected" : "")%>>Bangkok</option>
                                <option value="6" <%=(idCiudad.equals("6") ? "selected" : "")%>>Singapur</option>
                                <option value="7" <%=(idCiudad.equals("7") ? "selected" : "")%>>New York</option>
                                <option value="8" <%=(idCiudad.equals("8") ? "selected" : "")%>>Cairo</option>
                                <option value="9" <%=(idCiudad.equals("9") ? "selected" : "")%>>Santo Domingo</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Fecha Nacimiento</td>
                        <td><input type="text" name="fechaNacimiento" id="fechaNacimiento" value="<%=fechaNacimiento%>" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Fecha Ingreso</td>
                        <td><input type="text" name="fechaIngreso" id="fechaIngreso" value="<%=fechaIngreso%>" size="10" disabled="disabled"/></td>
                    </tr>
                <td colspan="2">* Campos obligatorios</td>
                </tr>
                </tbody>
            </table>
            <br>
            <jsp:include page="Botones.jsp"></jsp:include>
            </form>
            <h1><%=mensaje%></h1>
        <a href="javascript:history.back(1)">Página Anterior</a><br>
        <a href="MenuAdministrador.jsp">Regresar al Menú</a>
    </body>
</html>
