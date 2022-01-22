package org.Protocol;


public class NotEnoughDataException extends Exception {

    private static final long serialVersionUID = 1L;

    public NotEnoughDataException() {super("No hay suficientes datos en el buffer para leer");
    }
}
