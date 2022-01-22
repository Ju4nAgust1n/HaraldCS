package org.Util;

import java.util.Properties;

public class Util {

    /** Creates a new instance of Util */
    private Util() {
        //
    }

    public static boolean asciiValidos(String str) {
        // Function AsciiValidos(ByVal cad As String) As Boolean
        byte[] bytes = str.toLowerCase().getBytes();
        for (byte element : bytes) {
            if ((element < 97 || element > 122) && element != 255
                    && element != 32) {
                return false;
            }
        }
        return true;
    }

    public static short leShort(short n) {
        return (short) (((n & 0xff) << 8) | (((n & 0xff00) >> 8) & 0xff));
    }

    public static int leInt(int n) {
        int a = n & 0xff;
        int b = n & 0xff00;
        int c = n & 0xff0000;
        int d = n & 0xff000000;
        return ((a << 32) | (b << 16) | (c << 8) | d);
    }

    public static double distance(int x1, int y1, int x2, int y2) {
        // Encuentra la distancia entre dos puntos
        return Math.sqrt(((y1 - y2) * (y1 - y2)) + ((x1 - x2) * (x1 - x2)));
    }

    public static int porcentaje(long total, long porc) {
        return (int) Math.round((total * porc) / 100.0);
    }

    public static int Azar(int min, int max) {
        int valor = (int) ((Math.random() * (max - min + 1)) + min);
        return (valor < min) ? min : valor;
    }

    public static short Min(short a, short b) {
        return a < b ? a : b;
    }

    public static int Min(int a, int b) {
        return a < b ? a : b;
    }

    public static long Min(long a, long b) {
        return a < b ? a : b;
    }

    public static double Min(double a, double b) {
        return a < b ? a : b;
    }

    public static short Max(short a, short b) {
        return a > b ? a : b;
    }

    public static int Max(int a, int b) {
        return a > b ? a : b;
    }

    public static long Max(long a, long b) {
        return a > b ? a : b;
    }

    public static double Max(double a, double b) {
        return a > b ? a : b;
    }

    public static boolean existeArchivo(String nombre) {
        java.io.File f = new java.io.File(nombre);
        return f.canRead();
    }

    public static Properties getProperties(Object obj, String fileName) {
        java.util.Properties props = new java.util.Properties();
        try {
            // First try to load properties from the current path.
            java.io.FileInputStream pin = new java.io.FileInputStream(new java.io.File(fileName));
            props.load(pin);
        } catch (Exception ex) {
            try {
                // Fallback: try load properties from jar-file.
                java.net.URL url = obj.getClass().getResource(fileName);
                java.io.FileInputStream pin = new java.io.FileInputStream(url.getFile());
                props.load(pin);
            } catch (Exception exx) {
                System.out.println("Error: properties file not loaded:" + fileName);
            }
        }
        return props;
    }
}
