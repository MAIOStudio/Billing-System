/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dearmartinez
 */
public class Datos {

    private Connection conexion;

    public Datos() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String db = "jdbc:mysql://localhost:8889/billing2";
            conexion = DriverManager.getConnection(db, "root", "root");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String validarUsuario(String usuario, String clave) {
        try {
            String sql = "select idProfile from users where idUser = '" + usuario + "' and pass = '" + clave + "'";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                return resultSet.getString("idProfile");
            } else {
                return "Usuario no encontrado!";
            }
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return "Usuario no encontrado";
        }
    }

    public Usuario getUsuario(String idUsuario) {
        try {
            Usuario miUsuario = null;
            String sql = "select * from users where idUser = '" + idUsuario + "'";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                miUsuario = new Usuario(
                        resultSet.getString("idUser"),
                        resultSet.getString("names"),
                        resultSet.getString("lastNames"),
                        resultSet.getString("pass"),
                        resultSet.getInt("idProfile"),
                        resultSet.getString("photo"));
            }
            return miUsuario;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
            
            //log4j
            //Archivos properties
        }
    }

    public Cliente getCliente(String idCliente) {
        try {
            Cliente miCliente = null;
            String sql = "select * from clients where idClient = '" + idCliente + "'";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                miCliente = new Cliente(
                        resultSet.getString("idClient"),
                        resultSet.getInt("idType"),
                        resultSet.getString("names"),
                        resultSet.getString("lastNames"),
                        resultSet.getString("address"),
                        resultSet.getString("phone"),
                        resultSet.getInt("idCity"),
                        resultSet.getDate("dateBirth"),
                        resultSet.getDate("dateEntry"));
            }
            return miCliente;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public Producto getProducto(String idProducto) {
        try {
            Producto miProducto = null;
            String sql = "select * from products where idProduct = '" + idProducto + "'";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                miProducto = new Producto(
                        resultSet.getString("idProduct"),
                        resultSet.getString("description"),
                        resultSet.getInt("price"),
                        resultSet.getInt("idIva"),
                        resultSet.getString("notes"),
                        resultSet.getString("photo"));
            }
            return miProducto;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ResultSet getUsuarios() {
        try {
            String sql = "select * from users";
            Statement statement = conexion.createStatement();
            return statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ResultSet getClientes() {
        try {
            String sql = "select * from clients";
            Statement statement = conexion.createStatement();
            return statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ResultSet getProductos() {
        try {
            String sql = "select * from products";
            Statement statement = conexion.createStatement();
            return statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void newUsuario(Usuario miUsuario) {
        try {
            String sql = "insert into users values ('"
                    + miUsuario.getIdUser() + "', '"
                    + miUsuario.getNames() + "', '"
                    + miUsuario.getLastNames() + "', '"
                    + miUsuario.getPass() + "', "
                    + miUsuario.getIdProfile() + ", '"
                    + miUsuario.getFoto() + "')";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void newCliente(Cliente miCliente) {
        try {
            String sql = "insert into clients values ('"
                    + miCliente.getIdClient() + "', "
                    + miCliente.getIdType() + ", '"
                    + miCliente.getNames() + "', '"
                    + miCliente.getLastNames() + "', '"
                    + miCliente.getAddress() + "', '"
                    + miCliente.getPhone() + "', "
                    + miCliente.getIdCity() + ", '"
                    + Utilidades.formatDate(miCliente.getDateBirth()) + "', '"
                    + Utilidades.formatDate(miCliente.getDateEntry()) + "')";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void newProducto(Producto miProducto) {
        try {
            String sql = "insert into products values ('"
                    + miProducto.getIdProducto() + "', '"
                    + miProducto.getDescription() + "', "
                    + miProducto.getPrecio() + ", "
                    + miProducto.getIdIva() + ", '"
                    + miProducto.getNotas() + "', '"
                    + miProducto.getFoto() + "')";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateUsuario(Usuario miUsuario) {
        try {
            String sql = "update users set "
                    + "names = '" + miUsuario.getNames() + "', "
                    + "lastNames = '" + miUsuario.getLastNames() + "', "
                    + "pass = '" + miUsuario.getPass() + "', "
                    + "idProfile = " + miUsuario.getIdProfile() + ", "
                    + "photo = '" + miUsuario.getFoto() + "' "
                    + "where idUser ='" + miUsuario.getIdUser() + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateCliente(Cliente miCliente) {
        try {
            String sql = "update clients set "
                    + "idType = " + miCliente.getIdType() + ", "
                    + "names = '" + miCliente.getNames() + "', "
                    + "lastNames = '" + miCliente.getLastNames() + "', "
                    + "address = '" + miCliente.getAddress() + "', "
                    + "phone = '" + miCliente.getPhone() + "', "
                    + "idCity = " + miCliente.getIdCity() + ", "
                    + "dateBirth = '" + Utilidades.formatDate(miCliente.getDateBirth()) + "', "
                    + "dateEntry = '" + Utilidades.formatDate(miCliente.getDateEntry()) + "' "
                    + "where idClient ='" + miCliente.getIdClient() + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateProducto(Producto miProducto) {
        try {
            String sql = "update products set "
                    + "description = '" + miProducto.getDescription() + "', "
                    + "price = " + miProducto.getPrecio() + ", "
                    + "idIVA = " + miProducto.getIdIva() + ", "
                    + "notes = '" + miProducto.getNotas() + "', "
                    + "photo = '" + miProducto.getFoto() + "' "
                    + "where idProduct ='" + miProducto.getIdProducto() + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteUsuario(String idUsuario) {
        try {
            String sql = "delete from users where idUser = '" + idUsuario + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteCliente(String idCliente) {
        try {
            String sql = "delete from clients where idClient = '" + idCliente + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteProducto(String idProducto) {
        try {
            String sql = "delete from products where idProduct = '" + idProducto + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteDetalleFacturaTmp(String idProducto) {
        try {
            String sql = "delete from detailbilltmp where idProduct = '" + idProducto + "'";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getDetalleFacturaTmp() {
        try {
            String sql = "select * from detailbilltmp";
            Statement statement = conexion.createStatement();
            return statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public int getTotalCantidad() {
        try {
            int totalCantidad = 0;
            String sql = "select sum(amount) as totalCantidad from detailbilltmp";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                totalCantidad = resultSet.getInt("totalCantidad");

            }
            return totalCantidad;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public int getTotalValor() {
        try {
            int totalValor = 0;
            String sql = "select sum(amount * price) as totalValor from detailbilltmp";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                totalValor = resultSet.getInt("totalValor");

            }
            return totalValor;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public void newDetalleFacturaTmp(DetalleFacturaTmp miDetalle) {
        try {
            // Identificamos si el producto está en el detalle
            String sql = "select (1) from detailbilltmp where idProduct = '" + miDetalle.getIdProducto() + "'";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                // Si hay detalle, se actualiza la cantidad.
                sql = "update detailbilltmp set amount = amount + " + miDetalle.getCantidad() + " " + "where idProduct = '" + miDetalle.getIdProducto() + "'";
            } else {
                // No existía en el detalle, se agrega nuevo.
                sql = "insert into detailbilltmp values('" + miDetalle.getIdProducto() + "', '" + miDetalle.getDescripcion() + "', " + miDetalle.getPrecio() + ", " + miDetalle.getCantidad() + ")";
            }
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int siguienteFactura() {
        try {
            int aux = 1;
            String sql = "select max(idBill) as num from bill";
            Statement statement = conexion.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                aux = resultSet.getInt("num") + 1;
            }
            return aux;
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }

    public void newFactura(int idBill, String idClient, Date date) {
        try {
            String sql = "insert into bill values("
                    + idBill + ", '"
                    + idClient + "', '"
                    + Utilidades.formatDate(date) + "')";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void newDetalleFactura(int idBill, int idLine, String idProduct, String description, int price, int amount) {
        try {
            String sql = "insert into detailbill values("
                    +idBill+","
                    +idLine+", '"
                    +idProduct+"', '"
                    +description+"', "
                    +price+", "
                    +amount+")";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteDetalleFacturaTmp() {
        try {
            String sql = "delete from detailbilltmp";
            Statement statement = conexion.createStatement();
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ResultSet getResultSet(String sql) {
        try {
            Statement statement = conexion.createStatement();
            return statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(Datos.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
