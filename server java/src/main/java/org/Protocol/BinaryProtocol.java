// Agus: hacemos encoding

package org.Protocol;

import org.Protocol.idMessages.clientPacketID;

import java.nio.ByteOrder;

import static java.nio.ByteOrder.BIG_ENDIAN;
import static java.nio.ByteOrder.LITTLE_ENDIAN;

import java.nio.ByteBuffer;

public class BinaryProtocol {

    public void encodeData(ByteBuffer buf, clientPacketID.ID msg, Object... params){

        buf.put((byte) msg.ordinal());

        if (params != null) {
            for (Object element : params) {
                if (element.getClass().getName().equals("java.lang.Short")) {
                    buf.order(LITTLE_ENDIAN);
                    buf.putShort((Short) element);
                    buf.order(BIG_ENDIAN);

                } else if (element.getClass().getName().equals("java.lang.Integer")) {
                    buf.order(LITTLE_ENDIAN);
                    buf.putInt((Integer) element);
                    buf.order(BIG_ENDIAN);

                } else if (element.getClass().getName().equals("java.lang.Long")) {
                    buf.order(LITTLE_ENDIAN);
                    buf.putLong((Long) element);
                    buf.order(BIG_ENDIAN);

                } else if (element.getClass().getName().equals("java.lang.Char")) {
                    buf.order(LITTLE_ENDIAN);
                    buf.putChar((Character) element);
                    buf.order(BIG_ENDIAN);

                } else if (element.getClass().getName().equals("java.lang.String")) {
                    String str = element.toString();
                    // incluímos el largo
                    buf.order(ByteOrder.LITTLE_ENDIAN).putShort((short)str.length());
                    // bytes de la cadena
                    buf.order(ByteOrder.BIG_ENDIAN).put(str.getBytes());
                } else {
                    System.out.println("encodeData(): tipo de dato desconocido - " + element.getClass().getName());
                }
            }
        }
    }

}
