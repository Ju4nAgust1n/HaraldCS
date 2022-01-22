package org.Util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class passwordWeb {

    private int max_characters = 12;
    private int min_character = 3;
    public byte runnable = 0;

    public void setRunnable(){
        this.runnable++;
    }

    public int minCharacter(){
        return this.min_character;
    }

    public boolean checkRunnable(){
        if (this.runnable > 0)
            return true;
        else
            return false;
    }

    public String webPw(){
        String texto = "";
        try {
            //se abre la conexiòn
            URL url = new URL("URL FTP");
            URLConnection conexion = url.openConnection();
            conexion.connect();

            InputStream is = conexion.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            char[] buffer = new char[this.max_characters];

            int leido;

            while ((leido = br.read(buffer)) > 0) {
                String datos = new String(buffer, 0, leido);
                texto += datos;
            }

        } catch (MalformedURLException ex) {
            //Logger.getLogger(Testurl.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            //Logger.getLogger(Testurl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return texto;

    }

}
