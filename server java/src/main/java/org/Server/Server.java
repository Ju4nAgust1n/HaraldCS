//Agus: Clase principal del servidor

package org.Server;

import java.util.*;
import java.net.UnknownHostException;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;

import org.Usuarios.Client;
import org.Protocol.threadProtocol.thProtocol;
import org.Protocol.BinaryProtocol;
import org.serverData.serverFlags;
import org.Ranking.userRank;
import org.Util.*;

public class Server {

    //agush: manage process client in another thread /

    LinkedList colaProcesos = new LinkedList();

    public LinkedList getColaProcesos() {
        return this.colaProcesos;
    }

    public void clearColaProcesos() {
        this.colaProcesos.clear();
    }

    public void addIntegerQueue(int value){
        this.colaProcesos.add(value);
    }

    public Object getIntegerQueue() {return this.colaProcesos.get(0);}

    public void deleteIntegerQueue(int value){
        this.colaProcesos.remove(value);
    }

    public void addByteQueue(byte[] value){
        this.colaProcesos.add(value);
    }

    public Object getByteQueue(int value) {return this.colaProcesos.get(value);}

    public void deleteByteQueue(int value){
        this.colaProcesos.remove(value);
    }

    public void addClientQueue(Client value){
        this.colaProcesos.add(value);
    }

    public Object getClientQueue(int value) {return this.colaProcesos.get(value);}

    public void deleteClientQueue(int value){
        this.colaProcesos.remove(value);
    }

    public int getProcessQueue() {return this.colaProcesos.size();}

    thProtocol processThread = new thProtocol();

    public static serverFlags servidores= new serverFlags();
    public static passwordWeb checkServer = new passwordWeb();
    public static userRank rank = new userRank();

    int tempBuffer = 0;

    short lastUser = 0;
    short lastQuit = 0;

    private ServerSocketChannel server;
    private Selector selector;
    private final static int BUFFER_SIZE = 1024;
    private ByteBuffer serverBuffer = ByteBuffer.allocate(BUFFER_SIZE);
    int SERVER_PORT = 7668;

    private HashMap<SocketChannel, Client> m_clientSockets = new HashMap<SocketChannel, Client>();
    private HashMap<Short, Client> m_clientes = new HashMap<Short, Client>();
    private List<Client> m_clientes_eliminar = new LinkedList<Client>();

    short id = 0;
    private BinaryProtocol protocol;
    private Properties prop = null;
    private static Server m_instance = null;
    boolean m_corriendo;

    public static Server getInstance() {
        if (m_instance == null) {
            m_instance = new Server();
        }
        return m_instance;
    }

    public static void main(String[] args) {

            rank.initializeRank();

            servidores.cargarArrayServers();

            System.out.println(""); //separador =P
            System.out.println("Creado por: Oliva, Juan Agustin.");
            System.out.println("Servidor Principal de Harald Argentum Online ;-)");
            Server.getInstance().run();
    }

    public void run() {
            this.prop = Util.getProperties(this, "config.properties");

            processThread.setearVariables(this);
            processThread.start();

        try {
            initServerSocket();

            this.m_corriendo = true;

            //loadObjDat();

            while (this.m_corriendo){
                // Wainting for events...
                this.selector.select(40); // milisegundos

                Set<SelectionKey> keys = this.selector.selectedKeys();
                for (SelectionKey key: keys) {
                    // if isAcceptable, then a client required a connection.
                    if (key.isAcceptable()) {
                        //System.out.println("Nueva conexion");
                        acceptConnection();
                        continue;
                    }
                    // if isReadable, then the server is ready to read
                    if (key.isReadable()) {
                        //System.out.println("Leemos datos de la conexion");
                        readConnection((SocketChannel) key.channel());
                        continue;
                    }
                }

                keys.clear();
                eliminarClientes(); // ?

            }

        } catch (UnknownHostException ex) {
            System.out.println("AOServer run loop");
        } catch (java.net.BindException ex) {
            System.out.println("El puerto ya está en uso. ¿El servidor ya está corriendo?");
        } catch (IOException ex) {
            System.out.println("AOServer run loop");
        } finally {

        }

        }

    public Properties getConfig() {
        return this.prop;
    }

    public short leerOnlines(){
        return this.lastUser;
    }
    public short miId(){
        short i = 1;

                while (i < this.lastUser + 1){
                    if (getCliente(i) == null){
                        return i;
                    }
                    i++;
                }
                    i++;
                    return i;
    }

    /** Inicializa el socket del servidor. */
    private void initServerSocket()
            throws java.io.IOException {
        this.server = ServerSocketChannel.open();
        this.server.configureBlocking(false);
        this.server.socket().bind(new InetSocketAddress(SERVER_PORT));
        System.out.println("El puerto del servidor es: " + SERVER_PORT);
        this.selector = Selector.open();
        this.server.register(this.selector, SelectionKey.OP_ACCEPT);
    }

    /** Acepta una conexión nueva. */
    private void acceptConnection()
            throws java.io.IOException {
        // get client socket channel.

        this.lastUser++;

        SocketChannel clientSocket = this.server.accept();
        // Non blocking I/O
        clientSocket.configureBlocking(false);
        // recording to the selector (reading)
        clientSocket.register(this.selector, SelectionKey.OP_READ);
        Client cliente = new Client(clientSocket, this, this.servidores);
        this.m_clientSockets.put(clientSocket, cliente);
        this.m_clientes.put(cliente.getId(), cliente);
        System.out.println("Nueva Conexion");

    }

    /** Cerrar una conexión. */
    public void closeConnection(Client cliente){

        try {
            System.out.println("Cerrando conexion");


            if (cliente.getPort() > 0) { //Si se trata de un servidor...
                this.servidores.quitarServer(cliente.getId(), cliente.getIdServer());
                cliente.setPort((short) 0);
            } else {
                if (!cliente.getSaved()) {
                    System.out.println("Guardamos a causa de desconeccion forzosa");
                    savePJDisconnect(cliente); //en caso de desconección forzosa
                }
            }

            this.m_clientSockets.remove(cliente);
            this.m_clientes_eliminar.add(cliente);
            cliente.socketChannel.close();

        } catch (Exception e){
            System.out.println("Error en el closeConecction");
        } finally{

            this.lastUser--;
            this.lastQuit = cliente.getId();

        }


    }

    private void eliminarClientes() {
        for (Client cliente: this.m_clientes_eliminar) {
            this.m_clientes.remove(cliente.getId());
        }
        this.m_clientes_eliminar.clear();
    }

    /** Lee datos de una conexión existente. */
    private void readConnection(SocketChannel clientSocket)
            throws java.io.IOException {
        Client cliente = this.m_clientSockets.get(clientSocket);

        // Read bytes coming from the client.
        this.serverBuffer.clear();
        try {
            clientSocket.read(this.serverBuffer);

            // process the message.
            this.serverBuffer.flip();

            if (this.serverBuffer.limit() > 0) {
                cliente.lengthClient.add(this.serverBuffer.limit());
                cliente.colaClient.put(this.serverBuffer.array());
                this.processThread.addClientQueue(cliente);
            }else {
                cliente.doSalir();
            }


        } catch (Exception e) {
            this.closeConnection(cliente);
        }

    }

    public Client getCliente(short id) {
        try {
            return this.m_clientes.get(id);
        } catch (Exception e){
            return null;
        }
    }

    public String getLstServers() {
        return this.servidores.getServers();
    }

    public Client objectServer(short slot){
        return servidores.objectServer(slot);
    }

    public void refrescarRanking(String name, int kills){
        this.rank.refreshRank(name,kills);
    }

    public String getRank(){
        return this.rank.preparelstRanking();
    }

    private void savePJDisconnect (Client Client){

        if (Client.getName().length() > 0) Client.saveCharacters();

    }

    public short getLastQuit(){ return this.lastQuit;}
    public void setLastQuit(int value) { this.lastQuit = (short) value;}

    public boolean containsClient(Client client){
        return this.m_clientes_eliminar.contains(client);
    }

}
