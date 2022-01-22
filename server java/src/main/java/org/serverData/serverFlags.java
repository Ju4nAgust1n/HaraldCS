package org.serverData;

import org.Usuarios.Client;

public class serverFlags {

        private final short default_port = -1;

        short lastServer;

        final static byte max_servers = 20;
        String nombre[] = new String [max_servers];
        String IP[] = new String[max_servers];
        short mapa[] = new short[max_servers];
        short puerto[] = new short[max_servers];
        short online[] = new short[max_servers];
        Client socketIndex[] = new Client[max_servers];

        public serverFlags(){
            //
    }

    public void cargarArrayServers(){
            int tempBuffer = 0;

            while (tempBuffer < this.max_servers){
                this.nombre[tempBuffer] = "";
                this.IP[tempBuffer] = "";
                this.mapa[tempBuffer] = 0;
                this.puerto[tempBuffer] = this.default_port;
                this.socketIndex[tempBuffer] = null;

                this.lastServer = 0;

                tempBuffer++;
            }
    }

    public byte getMax_servers(){return max_servers;}
    public short getServer_port(short index){return this.puerto[index];}
    public String getIP(short index) {return this.IP[index];}

    //Este procedimiento se usa para sumar o restar onlines en los servers
    public void managePlayers(short index, short quit){
            switch (quit){
                case 0: //si no salió, se suma
                    this.online[index]++;
                    System.out.println(this.online[index]);
                    break;
                case 1: //si salió del server, se resta
                    this.online[index]--;
                    if (this.online[index] < 0) this.online[index] = 0;
                    break;
            }
    }

    private void reacomodarLista(short quitIndex){
           while(quitIndex < this.max_servers - 1){

                   this.nombre[quitIndex] = this.nombre[quitIndex + 1];
                   this.IP[quitIndex] = this.IP[quitIndex + 1];
                   this.mapa[quitIndex] = this.mapa[quitIndex + 1];
                   this.puerto[quitIndex] = this.puerto[quitIndex + 1];
                   this.online[quitIndex] = this.online[quitIndex + 1];
                   this.socketIndex[quitIndex] = this.socketIndex[quitIndex + 1];

                   if (this.socketIndex[quitIndex] != null) this.socketIndex[quitIndex].setIdServer(quitIndex);
                   quitIndex++;

           }
    }


    public void registrarServer(String nombre, String IP, short puerto, short mapa, Client cliente){
            short slot = getIdServer();
            if (slot < 1) return;

            if (this.IP[slot].length() > 1) return;

            this.nombre[slot] = nombre;
            this.IP[slot] = IP;
            this.mapa[slot] = mapa;
            this.puerto[slot] = puerto;
            this.online[slot] = 0;
            this.socketIndex[slot] = cliente;

            cliente.setIdServer(slot);

            System.out.println("ServerIndex " + slot + " registrado correctamente");

    }

    public void quitarServer(short index, short slot){
            if (slot < 1) return;

            this.nombre[slot] = "";
            this.IP[slot] = "";
            this.mapa[slot] = 0;
            this.puerto[slot] = this.default_port;
            this.online[slot] = 0;
            this.socketIndex[slot] = null;

            this.lastServer--;

            reacomodarLista(slot);

            System.out.println("ServerIndex " + slot + " borrado correctamente");

    }

    public String getServers(){
            int i = 0;
            String txt = this.lastServer + ",";

            while(i < this.max_servers){
                if (this.puerto[i] > 0) {
                    txt = txt + this.nombre[i] + "," + this.IP[i] + "," + this.puerto[i] + "," + this.mapa[i] + "," + this.online[i] + ",";
                }
                i++;
            }

            return txt;

    }

    public short whoServer(String IP){
            short i = 1;

            while (i < this.max_servers){
                if (IP.equals(this.IP[i])) {
                    return i;
                }
                i++;
            }

            return -1 ;

    }

    public short getIdServer(){

        if (this.lastServer + 1> this.max_servers) {
            return 0;
        }

        short i = 1;

        while (i < this.lastServer + 1){
            if (this.puerto[i] == this.default_port){
                this.lastServer++;
                return i;
            }
            i++;
        }
        this.lastServer++;
        return this.lastServer;
    }

    public Client objectServer(short slot){
            return this.socketIndex[slot];
    }


}
