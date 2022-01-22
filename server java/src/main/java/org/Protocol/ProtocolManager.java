package org.Protocol;

import java.util.Properties;
import org.Server.Server;
import org.Usuarios.Client;

public class ProtocolManager {

    private ProtocolManager() {
        //
    }

    public static Protocol getDefaultProtocol(Server server, Client cliente) {
        try {
            Properties props = server.getConfig();
            //Esto es modificable porque antes se manejaba protocolo de textos
            String protocolClassName = props.getProperty("org.Server.Server", "org.Protocol.BinaryProtocol");
            Protocol protocol = (Protocol) Class.forName(protocolClassName).newInstance();
            protocol.setCliente(cliente);
            return protocol;
        } catch (Exception e) {
            System.out.println("Error en ProtocolManager, msg: " + e.getMessage());
            return null;
        }
    }
}

