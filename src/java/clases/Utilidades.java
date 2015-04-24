package clases;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Utilidades {

    public static String formatDate(Date date) {
        if (date == null) {
            date = new Date();
        }
        SimpleDateFormat textFormat = new SimpleDateFormat("yyyy-MM-dd");
        return textFormat.format(date);
    }

    public static Date stringToDate(String date) {
        SimpleDateFormat textFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date aux = null;
        try {
            aux = textFormat.parse(date);
        } catch (Exception ignored) {
        }
        return aux;
    }

    public static boolean isNumeric(String chain) {
        try {
            Integer.parseInt(chain);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }
    
    public static int stringToInt(String chain) {
        int aux = 0;
        try {
            aux = Integer.parseInt(chain);
            return aux;
        } catch (NumberFormatException nfe) {
            return aux;
        }
    }
    
    public static double stringToDouble(String chain) {
        double aux = 0;
        try {
            aux = Double.parseDouble(chain);
            return aux;
        } catch (NumberFormatException nfe) {
            return aux;
        }
    }

    public static int objectToInt(Object object) {
        int numberInt = Integer.parseInt(objectToString(object));
        return numberInt;
    }

    public static double objectToDouble(Object object) {
        String string = object.toString();
        double numberDouble = Double.valueOf(string).doubleValue();
        return numberDouble;
    }

    public static boolean objectToBoolean(Object object) {
        String cadBooleana = objectToString(object);
        Boolean booleano = new Boolean(cadBooleana);
        return booleano;
    }

    public static String objectToString(Object object) {
        String string = "";
        if (object != null) {
            string = object.toString();
        }
        return string;
    }

    public static Date objectToDate(Object object) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date aux = null;
        try {
            aux = simpleDateFormat.parse(objectToString(object));
        } catch (Exception e) {
        }
        return aux;
    }
    
    public static String ciudad(int idCiudad) {
        switch (idCiudad) {
            case 1:
                return "Paris";
            case 2:
                return "Praga";
            case 3:
                return "Tokio";
            case 4:
                return "Lisboa";
            case 5:
                return "Bangkok";
            case 6:
                return "Singapur";
            case 7:
                return "New York";
            case 8:
                return "Cairo";
            case 9:
                return "Santo Domingo";
            default:
                return "Sin definir";
        }
    }
    
    public static String tipo(int idTipo) {
        switch (idTipo) {
            case 1:
                return "Cédula";
            case 2:
                return "Licencia";
            case 3:
                return "Pasaporte";
            case 4:
                return "Visa";
            default:
                return "Sin definir";
        }
    }
    
    public static String iva(int idIVA) {
        switch (idIVA) {
            case 0:
                return "0%";
            case 1:
                return "10%";
            case 2:
                return "12%";
            case 3:
                return "15%";
            case 4:
                return "18%";
            case 5:
                return "21%";
            default:
                return "Sin definir";
        }
    }

}
