<%-- 
    Document   : NuevaFactura
    Created on : Dec 4, 2014, 11:00:23 PM
    Author     : dearmartinez
--%>

<%@page import="clases.Reportes"%>
<%@page import="clases.DetalleFacturaTmp"%>
<%@page import="clases.Producto"%>
<%@page import="clases.Utilidades"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.Datos"%>
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
                    $("#adicionar").click(function () {
                        return validarAdicionar();
                    });
                    
                    $("#grabar").click(function () {
                        return validarCliente();
                    });

                    $(".eliminar").click(function () {
                        $("#borrado").val($(this).attr("href"));
                        $("<div></div>").html("Está seguro de borrar el producto " + $("#borrado").val() + "?").
                                dialog({title: "Confirmación", modal: true, buttons: [
                                        {
                                            text: "Si",
                                            click: function () {
                                                $(this).dialog("close");
                                                $.post("EliminarDetalleFacturaTmp", {idProducto: $("#borrado").val()}, function (data) {
                                                    location.reload();
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
                        return false;
                    });
                });

                function validarAdicionar() {
                    if (validarProducto()) {
                        return validarCantidad();
                    }
                    return false;
                }

                function validarProducto() {
                    if ($("#producto").val() == "0") {
                        $("<div></div>").html("Debe seleccionar un producto").
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
                
                function validarCliente() {
                    if ($("#cliente").val() == "0") {
                        $("<div></div>").html("Debe seleccionar un cliente").
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

                function validarCantidad() {
                    if ($("#cantidad").val() == "") {
                        $("<div></div>").html("Debe digitar un valor en cantidad").
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

            //Abrimos conexión con la BD
            Datos misDatos = new Datos();
            ResultSet resultSetClientes = misDatos.getClientes();
            ResultSet resultSetProductos = misDatos.getProductos();

            // Identificamos el botón presionado    
            boolean adicionar = false;
            boolean grabar = false;

            if (request.getParameter("adicionar") != null) {
                adicionar = true;
            }
            if (request.getParameter("grabar") != null) {
                grabar = true;
            }

            // Obtenemos el valor de como fue llamado el formulario
            String fecha = Utilidades.formatDate(new Date());
            String cliente = "";
            String producto = "";
            String cantidad = "";

            if (request.getParameter("cliente") != null) {
                cliente = request.getParameter("cliente");
            }
            if (request.getParameter("producto") != null) {
                producto = request.getParameter("producto");
            }
            if (request.getParameter("cantidad") != null) {
                cantidad = request.getParameter("cantidad");
            }

            // Si presionan el botón adicionar
            if (adicionar) {
                if (!Utilidades.isNumeric(cantidad)) {
                    mensaje = "La cantidad debe ser un valor numérico";
                } else if (Utilidades.stringToInt(cantidad) <= 0) {
                    mensaje = "La cantidad debe ser un valor mayor a cero";
                } else {

                    // Buscamos el producto en la BD
                    Producto miProducto = misDatos.getProducto(producto);

                    // Creamos el objeto de detalle factura
                    DetalleFacturaTmp miDetalle = new DetalleFacturaTmp(
                            miProducto.getIdProducto(),
                            miProducto.getDescription(),
                            miProducto.getPrecio(),
                            new Integer(cantidad));

                    // Adicionamos el detalle
                    misDatos.newDetalleFacturaTmp(miDetalle);

                    // Inicializamos variables y colocamos mensaje
                    producto = "0";
                    cantidad = "";
                    mensaje = "Producto agregado correctamente";
                }
            }
            
            //Si precionan el botón grabar
            if(grabar) {
                if(misDatos.getTotalCantidad() == 0) {
                    mensaje = "Debe agregar el detalle de factura";
                } else {
                    // Obtenemos un número de factura
                    int numeroFactura = misDatos.siguienteFactura();
                    
                    // Grabamos el registro en la tabla factura
                    misDatos.newFactura(numeroFactura, cliente, new Date());
                    
                    // Grabamos el detalle de la factura
                    ResultSet resultSetDetalle = misDatos.getDetalleFacturaTmp();
                    int i = 1;
                    while(resultSetDetalle.next()) {
                        misDatos.newDetalleFactura(
                                numeroFactura,
                                i,
                                resultSetDetalle.getString("idProduct"),
                                resultSetDetalle.getString("description"),
                                resultSetDetalle.getInt("price"),
                                resultSetDetalle.getInt("amount"));
                        i++;
                    }
                    
                    // Borramos el detalle factura tmp
                    misDatos.deleteDetalleFacturaTmp();
                    
                    // Inicializamos las variables / ponemos mensaje
                    cliente = "";
                    mensaje = "Factura # " + numeroFactura + " creada con éxito";
                    
                    // Mostramos el reporte de la factura creada
                    String sql = "SELECT bill.idBill, bill.idClient, "
                        + "CONCAT(names,' ', lastNames) AS fullName, "
                        + "date, idLine, idProduct, description, price, "
                        + "amount, (price * amount) as value "
                        + "from bill "
                        + "INNER JOIN clients ON clients.idClient = bill.idClient "
                        + "INNER JOIN detailbill ON detailbill.idBill = bill.idBill "
                        + "WHERE bill.idBill = " + numeroFactura;
                ResultSet resultSet = misDatos.getResultSet(sql);
                Reportes.reporteFacturas(resultSet);
        %>
        <jsp:forward page="Reporte.pdf"></jsp:forward>
        <%
                }
            }
        %>
        <h1>Nueva Factura</h1>
        <form name="nuevaFactura" id="nuevaFactura" action="NuevaFactura.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Fecha:</td>
                        <td colspan="3"><input type="text" name="fecha" id="fecha" value="<%=fecha%>" size="10" disabled="disabled" /></td>
                    </tr>
                    <tr>
                        <td>Cliente:</td>
                        <td colspan="3">
                            <select name="cliente" id="cliente">
                                <option value="0">Seleccione un cliente...</option>
                                <%
                                    while (resultSetClientes.next()) {
                                %>
                                <option value="<%=resultSetClientes.getString("idClient")%>" <%=(resultSetClientes.getString("idClient").equals(cliente) ? "selected" : "")%> > <%=resultSetClientes.getString("names") + " " + resultSetClientes.getString("lastNames")%>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Producto:</td>
                        <td colspan="3">
                            <select name="producto" id="producto">
                                <option value="0">Seleccione un producto...</option>
                                <%
                                    while (resultSetProductos.next()) {
                                %>
                                <option value="<%=resultSetProductos.getString("idProduct")%>" <%=(resultSetProductos.getString("idProduct").equals(producto) ? "selected" : "")%>><%=resultSetProductos.getString("description")%></option>
                                <%
                                    }
                                %>
                            </select>    
                        </td>
                    </tr>
                    <tr>
                        <td>Cantidad</td>
                        <td><input type="text" name="cantidad" id="cantidad" value="" size="10" /></td>
                        <td><input type="submit" value="Adicionar" name="adicionar" id="adicionar" /></td>
                        <td><input type="submit" value="Grabar Factura" name="grabar" id="grabar" /></td>
                    </tr>
                    <tr>
                        <td colspan="4"><h2><%=mensaje%></h2></td>
                    </tr>
                </tbody>
            </table>
            <br>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID Producto</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Valor</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultSet resultSetDetalle = misDatos.getDetalleFacturaTmp();
                        while (resultSetDetalle.next()) {
                    %>
                    <tr>
                        <td align="center" ><a href="<%=resultSetDetalle.getString("idProduct")%>" class="eliminar"><%="Eliminar: " + resultSetDetalle.getString("idProduct")%></a></td>
                        <td align="center"><%=resultSetDetalle.getString("description")%></td>
                        <td align="right"><%=resultSetDetalle.getInt("price")%></td>
                        <td align="right"><%=resultSetDetalle.getInt("amount")%></td>
                        <td align="right"><%=resultSetDetalle.getInt("price") * resultSetDetalle.getInt("amount")%></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td colspan="3" align="right">TOTAL :</td>
                        <td align="right"><%=misDatos.getTotalCantidad()%></td>
                        <td align="right"><%=misDatos.getTotalValor()%></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            // Cerramos conexión con la BD
            misDatos.cerrarConexion();
        %>
        <a href="javascript:history.back(1)">Página Anterior</a><br>
        <a href="MenuAdministrador.jsp">Regresar al Menú</a>
        <input type="hidden" id="borrado"></input>
    </body>
</html>
