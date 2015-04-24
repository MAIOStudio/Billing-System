/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dearmartinez
 */
public class Reportes {

    private static Font fuenteMagenta18 = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.NORMAL, BaseColor.MAGENTA);
    private static Font fuenteAzul11 = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.NORMAL, BaseColor.BLUE);
    private static Font fuenteVerdel11 = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.NORMAL, BaseColor.GREEN);
    private static Font fuenteGris10 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL, BaseColor.GRAY);
    private static Font fuenteNaranja10 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL, BaseColor.ORANGE);
    private static Font fuenteRojo10 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL, BaseColor.RED);

    public static void reporteFacturas(ResultSet resultSet) {
        Document documento = new Document();
        try {
            String fullPath = "Users\\dearmartinez\\NetBeansProjects\\BillingSystem\\Reporte.pdf";
            int index = fullPath.lastIndexOf("\\");
            String fileName = fullPath.substring(index + 1);
            PdfWriter.getInstance(documento, new FileOutputStream("/Users/dearmartinez/NetBeansProjects/BillingSystem/build/web/" + fileName));
            documento.open();

            // Colocamos título al reporte
            Paragraph parrafo = new Paragraph("REPORTE DE FACTURAS", fuenteMagenta18);
            agregarLineasEnBlanco(parrafo, 1);
            documento.add(parrafo);

            // Variables totales
            int cantidadTotalFactura = 0;
            int valorTotalFactura = 0;
            int totalGeneralCantidad = 0;
            int totalGeneralValor = 0;

            // Leemos el registro del ResultSet
            boolean hayRegistros = resultSet.next();
            PdfPTable tabla;

            // Contruimos los titulos del encabezado
            Paragraph idFactura = new Paragraph("ID Factura", fuenteVerdel11);
            Paragraph idCliente = new Paragraph("ID Cliente", fuenteVerdel11);
            Paragraph nombre = new Paragraph("Nombre", fuenteVerdel11);
            Paragraph fecha = new Paragraph("Fecha", fuenteVerdel11);

            // Ciclo que recorre el ResultSet
            while (hayRegistros) {
                
                // Contruimos los datos del encabezado
                Paragraph idBill = new Paragraph(resultSet.getString("idBill"), fuenteGris10);
                Paragraph idClient = new Paragraph(resultSet.getString("idClient"), fuenteGris10);
                Paragraph fullName = new Paragraph(resultSet.getString("fullName"), fuenteNaranja10);
                Paragraph date = new Paragraph(resultSet.getString("date"), fuenteGris10);

                // Colocamos encabezado y datos de la factura
                // Contruimos una tabla con 2 columnas
                tabla = new PdfPTable(2);
                tabla.setHorizontalAlignment(Element.ALIGN_CENTER);
                tabla.addCell(idFactura);
                tabla.addCell(idBill);
                tabla.addCell(idCliente);
                tabla.addCell(idClient);
                tabla.addCell(nombre);
                tabla.addCell(fullName);
                tabla.addCell(fecha);
                tabla.addCell(date);
                parrafo = new Paragraph();
                parrafo.add(tabla);
                documento.add(parrafo);

                // Contruimos los titulos del detalle
                PdfPCell idLinea = new PdfPCell(new Paragraph("ID Línea", fuenteAzul11));
                idLinea.setHorizontalAlignment(Element.ALIGN_CENTER);
                Paragraph idProducto = new Paragraph("ID Producto", fuenteAzul11);
                Paragraph descripcion = new Paragraph("Descripción", fuenteAzul11);
                Paragraph precio = new Paragraph("Precio", fuenteAzul11);
                Paragraph cantidad = new Paragraph("Cantidad", fuenteAzul11);
                Paragraph valor = new Paragraph("Valor", fuenteAzul11);

                // Contruimos una tabla con 6 columnas
                tabla = new PdfPTable(6);
                tabla.setHorizontalAlignment(Element.ALIGN_CENTER);
                tabla.addCell(idLinea);
                tabla.addCell(idProducto);
                tabla.addCell(descripcion);
                tabla.addCell(precio);
                tabla.addCell(cantidad);
                tabla.addCell(valor);

                // Inicializamos totales de factura
                cantidadTotalFactura = 0;
                valorTotalFactura = 0;

                // Contruimos los titulos del total
                Paragraph total = new Paragraph("TOTAL =", fuenteAzul11);

                int facturaActual = resultSet.getInt("idBill");

                // Adicionamos el detalle de la factura
                while (hayRegistros && facturaActual == resultSet.getInt("idBill")) {

                    // Contruimos los datos del detalle
                    Paragraph idLine = new Paragraph(resultSet.getString("idLine"), fuenteGris10);
                    Paragraph idProduct = new Paragraph(resultSet.getString("idProduct"), fuenteGris10);
                    Paragraph description = new Paragraph(resultSet.getString("description"), fuenteNaranja10);
                    Paragraph price = new Paragraph(resultSet.getString("price"), fuenteGris10);
                    Paragraph amount = new Paragraph(resultSet.getString("amount"), fuenteGris10);
                    Paragraph value = new Paragraph(resultSet.getString("value"), fuenteRojo10);

                    tabla.addCell(idLine);
                    tabla.addCell(idProduct);
                    tabla.addCell(description);
                    tabla.addCell(price);
                    tabla.addCell(amount);
                    tabla.addCell(value);

                    cantidadTotalFactura += resultSet.getInt("amount");
                    valorTotalFactura += resultSet.getInt("value");

                    hayRegistros = resultSet.next();
                }

                tabla.addCell(" ");
                tabla.addCell(" ");
                tabla.addCell(" ");
                tabla.addCell(total);
                tabla.addCell("" + cantidadTotalFactura);
                tabla.addCell("" + valorTotalFactura);

                totalGeneralCantidad += cantidadTotalFactura;
                totalGeneralValor += valorTotalFactura;

                parrafo = new Paragraph();
                parrafo.add(tabla);
                agregarLineasEnBlanco(parrafo, 1);
                documento.add(parrafo);
            }

            // Contruimos los titulos del total
            Paragraph totalGeneral = new Paragraph("TOTAL GENERAL =", fuenteAzul11);

            // Contruimos una tabla con 6 columnas
            tabla = new PdfPTable(6);
            tabla.setHorizontalAlignment(Element.ALIGN_CENTER);
            tabla.addCell(" ");
            tabla.addCell(" ");
            tabla.addCell(" ");
            tabla.addCell(totalGeneral);
            tabla.addCell("" + totalGeneralCantidad);
            tabla.addCell("" + totalGeneralValor);
            parrafo = new Paragraph();
            parrafo.add(tabla);
            documento.add(parrafo);
        } catch (Exception ex) {
            Logger.getLogger(Reportes.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            documento.close();
        }
    }

    private static void agregarLineasEnBlanco(Paragraph parrafo, int nLineas) {
        for (int i = 0; i < nLineas; i++) {
            parrafo.add(new Paragraph(" "));
        }
    }
}
