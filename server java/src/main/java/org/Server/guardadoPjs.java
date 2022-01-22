package org.Server;

import org.Util.*;

//Agus: Manejamos en otro thread lo referido al guardado de Pjs

public class guardadoPjs extends Thread{

    private short accion;
    private String nombre;
    private String PW;
    private int matados = 0;
    private int muertes = 0;

    Server servidor = new Server();

    public void setearVariables(String nombre, String PW, Server servidor, int matados){
      //  this.accion = accion;
        this.nombre = nombre;
        this.servidor = servidor;
        this.matados = matados;

  //      if (accion > 0){
    //        this.PW = getPW();
    //    } else {
            this.PW = PW;
      //  }

    }


    private static String getPjFile(String nick) {
        return "chars" + java.io.File.separator + nick.toLowerCase() + ".chr";
    }

    public boolean existePersonaje() {
        return Util.existeArchivo(getPjFile(this.nombre));
    }

    private String getPW(){
        String txt = "";
        try {
            IniFile ini = new IniFile(getPjFile(this.nombre));
            txt = ini.getString("INIT","PW");
        } catch (Exception e){
            System.out.println("Error en getPW de " + this.nombre);

        }
        return txt;

    }

    private int getKills(){
        int matados = 0;
        try {
            IniFile ini = new IniFile(getPjFile(this.nombre));
            matados = ini.getInt("FLAGS","MATADOS");
        } catch (Exception e){
            System.out.println("Error en getKills de " + this.nombre);
        }

        return matados;
    }

    public void saveCharacters() {
        try {
            IniFile ini = new IniFile();
            ini.setValue("INIT", "PW", this.PW);
            ini.setValue("FLAGS", "Matados", this.matados);

            // Guardar todo
            ini.store(getPjFile(this.nombre));

            this.servidor.refrescarRanking(this.nombre,this.matados);
        } catch (Exception e) {
            System.out.println("Error en saveCharacters: " + e);
        }
    }

    @Override
    public void run(){
        saveCharacters();
    }


}
