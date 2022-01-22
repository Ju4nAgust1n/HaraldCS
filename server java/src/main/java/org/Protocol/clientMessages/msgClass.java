package org.Protocol.clientMessages;

/**
 *
 * @author: JAO (Juan Agustín Oliva)
 * @userforos: Agushh, Thorkes
 */

public interface msgClass {

    public final short none = 0;
    public final short error_serverConexion = 1;
    public final short error_port = 2;
    public final short error_lengthName = 3;
    public final short error_existsServer = 4;
    public final short error_clientConexion = 5;
    public final short error_AU = 6;

}