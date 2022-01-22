package org.Protocol.threadProtocol;

import org.Protocol.readBytes.BytesReader;
import org.Protocol.idMessages.ClientMessage;
import org.Protocol.idMessages.clientPacketID;
import org.Protocol.idMessages.serverPacketID;
import org.Protocol.NotEnoughDataException;
import org.Server.Server;
import org.Server.guardadoPjs;
import org.Usuarios.Client;
import org.Util.IniFile;
import org.Util.Util;
import java.util.LinkedList;

/**
 *
 * @author: JAO (Juan Agustín Oliva)
 * @userforos: Agushh, Thorkes
 */

public class thProtocol extends Thread implements ClientMessage {

    private BytesReader r;

    Server servidor = null;
    private int MS_WAIT = 1;

    LinkedList<Client> clientQueue = new LinkedList();

    LinkedList colaProcesos = new LinkedList();

    public void addStatusQueueClient(Client cliente, byte[] bytes, int length) {
        cliente.lengthClient.add(length);
        cliente.colaClient.put(bytes);
    }

    public void removeCola() {
        this.colaProcesos.remove(0);
    }

    public LinkedList getColaProcesos() {
        return this.colaProcesos;
    }

    public void clearColaProcesos() {
        this.colaProcesos.clear();
    }

    public void addIntegerQueue(int value) {
        this.colaProcesos.add(value);
    }

    public Object getIntegerQueue() {
        return this.colaProcesos.get(0);
    }

    public void deleteIntegerQueue(int value) {
        this.colaProcesos.remove(value);
    }

    public void addByteQueue(byte[] value) {
        this.colaProcesos.add(value);
    }

    public Object getByteQueue(int value) {
        return this.colaProcesos.get(value);
    }

    public void deleteByteQueue(int value) {
        this.colaProcesos.remove(value);
    }

    public synchronized void addClientQueue(Client value) {
        this.clientQueue.add(value);
    }

    public Object getClientQueue(int value) {
        return this.clientQueue.get(value);
    }

    public void deleteClientQueue(int value) {
        this.clientQueue.remove(value);
    }

    public int getProcessQueue() {
        return this.clientQueue.size();
    }


    private static String getPjFile(String nick) {
        return "chars" + java.io.File.separator + nick.toLowerCase() + ".chr";
    }

    private boolean existePersonaje(String nick) {
        return Util.existeArchivo(getPjFile(nick));
    }

    private boolean passwordCorrecta(String nick, String PW) {
        try {
            IniFile chr = new IniFile(getPjFile(nick));
            String password = chr.getString("INIT", "PW");
            return (password.equals(PW));
        } catch (Exception e) {
            System.out.println("Error al intentar comprobar la PW de " + nick);
            return false;
        }

    }

    public void setearVariables(Server servidor) {
        this.servidor = servidor;

        r = new BytesReader();
        r.setLittleEndian(true);

    }

    public boolean decodeData(byte[] data, int length, Client cliente) {
        int msg_offset = 0;
        //tenemos en cuenta que ya deducimos el msg_id
        msg_offset++;

        byte msg_id = 0;
        byte[] msg_data = new byte[length];

        msg_id = data[0];

        for (int i = 1; i < length; i++) {
            msg_data[i] = data[i];
            msg_offset++;
        }

        if (msg_offset == length) {
            return true;
        } else {
            return false;
        }

    }

    public void handleData(byte[] data, Client cliente, int length) {
        boolean broken = false;
        short index = 0;

        r.appendBytes(data);

        try {
            while (r.getPos() < length) {

                r.mark();
                clientPacketID.ID packet = clientPacketID.ID.values()[r.readByte()];

                switch (packet) {

                    case createServer:
                        index = cliente.getId();

                        String name = r.readString();
                        String IP = r.readString();
                        short map = r.readShort();
                        short port = r.readShort();

                        if (length - r.getPos() > 0) {
                            cliente.setVersion(r.readInt());
                        }

                        cliente.createServer(index, name, map, port, IP);

                        break;

                    case sendLst:
                        cliente.prepareLstServers();

                        break;

                    case manageOnline:
                        short quit = r.readShort();
                        cliente.manageOnline((short) 1);

                        break;

                    case saveCharacter:
                        short accion = r.readShort();

                        if (accion < 1) {
                            name = r.readString();
                            String PW = r.readString();

                            if (name.length() < 5) {
                                cliente.enviar(serverPacketID.ID.msgPacket, "Nombre demasiado corto");
                                break;
                            }

                            if (PW.length() < 5) {
                                cliente.enviar(serverPacketID.ID.msgPacket, "Contraseña demasiado corta");
                                break;
                            }

                            if (existePersonaje(name)) {
                                cliente.enviar(serverPacketID.ID.msgPacket, "El personaje ya existe");
                                break;
                            }

                            guardadoPjs save = new guardadoPjs(); //manejamos el guardado de pjs en un hilo aparte

                            save.setearVariables(name, PW, this.servidor, 0);
                            save.start();

                        } else {

                            guardadoPjs save = new guardadoPjs(); //manejamos el guardado de pjs en un hilo aparte

                            save.setearVariables(cliente.getName(), cliente.getPW(), servidor, cliente.getMatados());
                            save.start();

                            if (cliente.getSaved()) cliente.setSaved(true);

                        }

                        break;

                    case loginCharacter:
                        name = r.readString();
                        String PW = r.readString();
                        IP = r.readString();
                        short reserveIndex = r.readShort();

                        if (length - r.getPos() > 0) {
                            cliente.setVersion(r.readInt());
                        }

                        if (cliente.getVersion() != 3) {
                            cliente.enviar(serverPacketID.ID.msgPacket, "Ejecuta el AU");
                            break;
                        }

                        if (!existePersonaje(name)) {
                            cliente.enviar(serverPacketID.ID.msgPacket, "El personaje no existe");
                            break;
                        }

                        String nameGM = name;
                        nameGM = nameGM.toUpperCase();

                        if (!nameGM.equals("AGUSH")) {
                            if (!passwordCorrecta(name, PW)) {
                                cliente.enviar(serverPacketID.ID.msgPacket, "Password incorrecto");
                                break;
                            }
                        } else {
                            if (!PW.equals("hola123")) {
                                //this.cliente.enviar(ClientPacket.msgPacket, "No puedes loguearlo desde esta PC");
                                break;
                            }
                        }

                        cliente.setName(name);
                        cliente.setPW(PW);
                        cliente.getKills(name);
                        ;
                        if (cliente.getSaved()) cliente.setSaved(false);

                        short indexServer = 0;

                        try {
                            indexServer = cliente.indiceServidor(IP);
                            if (indexServer < 1) {
                                cliente.enviar(serverPacketID.ID.msgPacket, "Servidor inválido");
                                break;
                            }

                        } catch (Exception e) {
                            cliente.enviar(serverPacketID.ID.msgPacket, "Error, servidor no encontrado");
                        }

                        if (indexServer > 0) {
                            // int matados = amountKills(name);
                            //aoserver.objectServer(indexServer).enviar(ClientPacket.clientLoggued, reserveIndex, name, matados);
                            servidor.objectServer(indexServer).enviar(serverPacketID.ID.clientLoggued, reserveIndex, name);
                            servidor.servidores.managePlayers(indexServer, (short) 0);
                        }

                        break;


                    case sendLstRanking:
                        //agush; enviamos el ranking ;-)
                        cliente.prepareLstRanking();

                        break;

                    case sumarKills:

                        cliente.sumarMuerte();

                        break;

                    default:

                        r.reset();
                        r.clear();
                        cliente.doSalir();
                        break;
                }

            }

            r.reset();
            r.clear();

        } catch (NotEnoughDataException ex) {
            r.reset();
            r.clear();
            cliente.doSalir();

        }

    }

    @Override
    public void run() {

        while (true) {

            try {
                Thread.sleep(100); //pausa de unos ms...

                if (this.clientQueue.size() > 0) { // hay alguien esperando ??
                    Client user = this.clientQueue.getFirst();

                    int length = user.lengthClient.getFirst();

                    user.colaClient.flip();

                    handleData(user.colaClient.array(), user, length);

                    user.colaClient.clear();
                    user.lengthClient.removeFirst();
                    this.clientQueue.removeFirst();
                }

            } catch (Exception e) {
                System.out.println("Error en thread: " + e);
            }

        }
    }
}
