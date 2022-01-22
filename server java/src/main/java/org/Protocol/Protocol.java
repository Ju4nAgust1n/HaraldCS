package org.Protocol;

import org.Protocol.idMessages.serverPacketID;

import java.nio.ByteBuffer;
import org.Usuarios.Client;

public abstract class Protocol {

    protected Client cliente;

    public Protocol() {
        // hola vengo a flotar
    }

    public void setCliente(Client cliente) {
        this.cliente = cliente;
        System.out.println("Identidad cliente: " + this.cliente.getId());
    }

    public abstract boolean decodeData(byte[] data, int length);

    public abstract void encodeData(ByteBuffer buf, serverPacketID.ID msg, Object... params);


}
