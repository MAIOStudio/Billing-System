<%-- 
    Document   : Usuarios
    Created on : Nov 29, 2014, 9:59:20 AM
    Author     : dearmartinez
--%>

<%@page import="clases.Utilidades"%>
<%@page import="clases.Producto"%>
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
                    $("#consultar").click(function () {
                        return validarProducto();
                    });

                    $("#nuevo").click(function () {
                        return validarTodo();
                    });

                    $("#modificar").click(function () {
                        return validarTodo();
                    });

                    $("#borrar").click(function () {
                        if (validarProducto()) {
                            $("<div></div>").html("Está seguro de borrar el registro?").
                                    dialog({title: "Confirmación", modal: true, buttons: [
                                            {
                                                text: "Si",
                                                click: function () {
                                                    $(this).dialog("close");
                                                    $.post("EliminarProducto", {idProducto: $("#idProducto").val()}, function (data) {
                                                        $("#idProducto").val("");
                                                        $("#descripcion").val("");
                                                        $("#precio").val("");
                                                        $("#idIva").val("0");
                                                        $("#notas").val("");
                                                        $("#foto").val("");
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
                    if (validarProducto()) {
                        if (validarDescripcion()) {
                            if (validarPrecio()) {
                                return validarIva();
                            }
                        }
                    }
                    return false;
                }



                function validarProducto() {
                    if ($("#idProducto").val() == "") {
                        $("<div></div>").html("Debe ingresar un ID de producto").
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

                function validarDescripcion() {
                    if ($("#descripcion").val() == "") {
                        $("<div></div>").html("Debe ingresar una descripción de producto").
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

                function validarPrecio() {
                    if ($("#precio").val() == "") {
                        $("<div></div>").html("Debe ingresar el precio del producto").
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

                function validarIva() {
                    if ($("#idIva").val() == "0") {
                        $("<div></div>").html("Debe seleccionar una tarifa de IVA").
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
            String idProducto = "";
            String descripcion = "";
            String precio = "";
            String idIva = "";
            String notas = "";
            String foto = "";

            if (request.getParameter("idProducto") != null) {
                idProducto = request.getParameter("idProducto");
            }
            if (request.getParameter("descripcion") != null) {
                descripcion = request.getParameter("descripcion");
            }
            if (request.getParameter("precio") != null) {
                precio = request.getParameter("precio");
            }
            if (request.getParameter("idIva") != null) {
                idIva = request.getParameter("idIva");
            }
            if (request.getParameter("notas") != null) {
                notas = request.getParameter("notas");
            }
            if (request.getParameter("foto") != null) {
                foto = request.getParameter("foto");
            }

            // Presionando el botón consultar
            if (consultar) {
                Datos misDatos = new Datos();
                Producto miProducto = misDatos.getProducto(idProducto);
                if (miProducto == null) {
                    descripcion = "";
                    precio = "";
                    idIva = "";
                    notas = "";
                    foto = "";
                    mensaje = "Producto no existe";
                } else {
                    idProducto = miProducto.getIdProducto();
                    descripcion = miProducto.getDescription();
                    precio = "" + miProducto.getPrecio();
                    idIva = "" + miProducto.getIdIva();
                    notas = miProducto.getNotas();
                    foto = miProducto.getFoto();
                    mensaje = "Producto consultado";
                }
                misDatos.cerrarConexion();
            }

            // Presionando el botón limpiar
            if (limpiar) {
                idProducto = "";
                descripcion = "";
                precio = "";
                idIva = "";
                notas = "";
                foto = "";
                mensaje = "";
            }

            //Presionando el botón nuevo
            if (nuevo) {
                if (!Utilidades.isNumeric(precio)) {
                    mensaje = "Debe ingresar un valor numérico en el precio";
                } else if (Utilidades.stringToInt(precio) <= 0) {
                    mensaje = "Debe ingresar un valor mayor a cero en el precio";
                } else {
                    Datos misDatos = new Datos();
                    Producto miProducto = misDatos.getProducto(idProducto);
                    if (miProducto != null) {
                        mensaje = "Producto ya existe";
                    } else {
                        miProducto = new Producto(
                                idProducto,
                                descripcion,
                                new Integer(precio),
                                new Integer(idIva),
                                notas,
                                foto);
                        misDatos.newProducto(miProducto);
                        mensaje = "Producto ingresado con éxito";
                    }
                    misDatos.cerrarConexion();
                }
            }

            //Presionando el botón editar
            if (modificar) {
                Datos misDatos = new Datos();
                Producto miProducto = misDatos.getProducto(idProducto);
                if (miProducto == null) {
                    mensaje = "Producto no existe";
                } else {
                    miProducto = new Producto(
                            idProducto,
                            descripcion,
                            new Integer(precio),
                            new Integer(idIva),
                            notas,
                            foto);
                    misDatos.updateProducto(miProducto);
                    mensaje = "Producto modificado con éxito";
                }
                misDatos.cerrarConexion();
            }

            // Presionando el botón Listar
            if (listar) {
        %>
        <jsp:forward page="ListadoProductos.jsp"></jsp:forward>
        <%
            }
        %>
        <h1>Productos</h1>
        <form name="productos" id="productos" action="Productos.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>ID Producto *:</td>
                        <td><input type="text" name="idProducto" id="idProducto" value="<%=idProducto%>" size="12" /></td>
                    </tr>
                    <tr>
                        <td>Descripción *:</td>
                        <td><input type="text" name="descripcion" id="descripcion" value="<%=descripcion%>" size="60" /></td>
                    </tr>
                    <tr>
                        <td>Precio *:</td>
                        <td><input type="text" name="precio" id="precio" value="<%=precio%>" size="11" /></td>
                    </tr>
                    <tr>
                        <td>IVA *:</td>
                        <td><select name="idIva" id="idIva">
                                <option value="0" <%=(idIva.equals("") ? "selected" : "")%> >Seleccione un IVA...</option>
                                <option value="1" <%=(idIva.equals("1") ? "selected" : "")%>>10%</option>
                                <option value="2" <%=(idIva.equals("2") ? "selected" : "")%>>12%</option>
                                <option value="3" <%=(idIva.equals("3") ? "selected" : "")%>>15%</option>
                                <option value="4" <%=(idIva.equals("4") ? "selected" : "")%>>18%</option>
                                <option value="5" <%=(idIva.equals("5") ? "selected" : "")%>>21%</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Notas:</td>
                        <td><textarea name="notas" id="notas" rows="4" cols="60" ><%=notas%></textarea></td>
                    </tr>
                    <tr>
                        <td>Foto:</td>
                        <td>                                        
                            <%
                                if (foto == null) {
                                    foto = "";
                                }
                                if (foto.equals("")) {
                            %>                            
                            <img src="images/box.png" width="150" height="150" alt="Seleccione una foto"/>
                            <%
                            } else {
                            %>                            
                            <img src="<%="images/" + foto%>" width="150" height="150" alt="Seleccione una foto"/>
                            <%
                                }
                            %>
                            <br>
                            <input type="file" name="foto" id="foto" value="<%=foto%>" />
                        </td>
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
