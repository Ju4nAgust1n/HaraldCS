package org.Usuarios;
//Agus: Clase para cada cliente

import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;
import org.Protocol.Protocol;
import org.Protocol.ProtocolManager;
import org.Protocol.idMessages.serverPacketID;
import org.Server.Server;
import org.Util.IniFile;
import org.serverData.serverFlags;
import org.Protocol.clientMessages.msgClass;
import java.util.LinkedList;

public class Client {

    int version = 0;
    boolean canSend;

    public LinkedList <Integer> lengthClient = new LinkedList();

    public ByteBuffer colaClient = ByteBuffer.allocate(1048);

    serverFlags servidores = new serverFlags();

    String name = "";
    String PW = "";

    short m_id = 0;
    String m_ip = "";

    int matados = 0;
    int muertes = 0;

    short id_server = 0;

    short port = 0;

    boolean saved = false;

    public SocketChannel socketChannel = null;
    private final static int BUFFER_SIZE = 1024;

    private ByteBuffer clientBuffer = ByteBuffer.allocate(BUFFER_SIZE);

    Server server;
    private Protocol protocol;

    /** Creates a new instance of Client */
    public Client(SocketChannel socketChannel, Server aoserver, serverFlags servidores) {
        this.server = aoserver;
        this.m_id = server.miId();
        this.socketChannel = socketChannel;
        this.servidores = servidores;

        java.net.InetSocketAddress addr = (java.net.InetSocketAddress) socketChannel
                .socket().getRemoteSocketAddress();

        this.protocol = ProtocolManager.getDefaultProtocol(this.server, this);

        if (addr != null) {
            this.m_ip = addr.getAddress().getHostAddress();

            //System.out.println("IP del cliente" + this.m_id + ": " + this.m_ip);
        }
    }

    public void setIdServer(short ID){
        this.id_server = ID;
    }

    //agus: esto es solo para usuarios
    public void setName(String name) {this.name = name;}

    public void setPW(String PW){
        this.PW = PW;
    }

    public void setMatados(int kills) {this.matados = kills;}

    public void setSaved(Boolean op) { this.saved = op;}

    public void setPort(short port) {this.port = port;}

    public String getName() {return this.name;}

    public String getPW() {return this.PW;}

    public int getMatados() {return this.matados;}

    public boolean getSaved() {return this.saved;}

    public short getId() {return this.m_id;}
    public String getIP(){return this.m_ip;}
    public short getPort() {return this.port;}
    public short getIdServer(){return this.id_server;}


    public Protocol getProtocol() {
        return protocol;
    }

    public void doSalir(){
        try {
            this.m_ip = "";
            server.closeConnection(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void enviar(serverPacketID.ID msg, Object... params) {
        try {

            clientBuffer.clear();

            protocol.encodeData(clientBuffer, msg, params);

            clientBuffer.flip();

            if (socketChannel.write(clientBuffer) == 0) {
                System.out.println("zero bytes writen!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            doSalir();
        }
    }

    public void prepareLstServers() {
        try {

            clientBuffer.clear();
            protocol.encodeData(clientBuffer, serverPacketID.ID.msgSendLst, this.servidores.getServers());
            clientBuffer.flip();

            if (socketChannel.write(clientBuffer) == 0) {
                System.out.println("zero bytes writen!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            doSalir();
        }
    }

    public void prepareLstRanking() {
        try {
            clientBuffer.clear();
            protocol.encodeData(clientBuffer, serverPacketID.ID.msgRanking, this.server.getRank());
            clientBuffer.flip();

            if (socketChannel.write(clientBuffer) == 0) {
                System.out.println("zero bytes writen!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            doSalir();
        }
    }

    public short indiceServidor(String IP){
        return servidores.whoServer(IP);
    }


    private short parametersOk(short index, String name, short port) {

        if (index < 0) {
            return msgClass.error_serverConexion;
        }

        if (port < 0){
            return msgClass.error_port;
        }

        if (name.length() < 5) {
            return msgClass.error_lengthName;
        }

        if (this.version != 4){
            return msgClass.error_AU;
        }

        short i = 0 ;
        while (i < servidores.getMax_servers()){
            if (this.m_ip.equals(servidores.getIP(i))){
                return msgClass.error_existsServer;
            }
            i++;
        }

        if (!canHost()){
            return msgClass.error_clientConexion;
        }

        return msgClass.none;

    }

    public void createServer(short index, String name, short map, short port, String IP){
        this.port = port;
        this.m_ip = IP;

        short str = parametersOk(index,name ,port);

        if (index > -1) {
            if (str == msgClass.none){
                servidores.registrarServer(name,IP,this.port,map, this);
            }else {
                enviar(serverPacketID.ID.msgPacket, str);
                doSalir();
            }
        }
    }

    public void manageOnline(short quit){
        short index = this.servidores.whoServer(this.m_ip);

        if (index > 0)
            servidores.managePlayers(index,quit);
    }

    public boolean canHost(){
        Socket sc = new Socket();

        try{
            sc = new Socket(this.m_ip, this.port);
            return sc.isConnected();
        } catch (Exception e ) {
            System.out.println("canHost: Imposible establecer conexion. Err:" + e);
        }
        return false;
    }

    private static String getPjFile(String nick) {
        return "chars" + java.io.File.separator + nick.toLowerCase() + ".chr";
    }

    public void sumarMuerte(){this.matados++;}

    public int getKills(String name){
        try {
            IniFile ini = new IniFile(getPjFile(name));
            int death = ini.getInt("FLAGS","MATADOS");
            this.setMatados(death);
        } catch (Exception e){
            System.out.println("Error en getKills de " + this.name);
        }

        return 0;
    }

    public void resetVariables()
    {
        this.name = "";
        this.PW = "";
        this.matados = 0;
        this.id_server = 0;

    }

    public void setVersion(int value){this.version = value;}
    public int getVersion() {return this.version;}

    public void saveCharacters() {
        try {
            IniFile ini = new IniFile();
            ini.setValue("INIT", "PW", this.PW);
            ini.setValue("FLAGS", "Matados", this.matados);

            // Guardar todo
            ini.store(getPjFile(this.name));

            this.server.refrescarRanking(this.name,this.matados);
        } catch (Exception e) {
            System.out.println("Error en saveCharacters: " + e);
        }
    }

}
