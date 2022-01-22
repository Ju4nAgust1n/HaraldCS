package org.Util;

import org.serverData.serverFlags;

public class privilegeUser {

    public privilegeUser(){
        //
    }

    public void setPrivilegiosUser(String text, serverFlags servidores){
        try {
            String elements[] = text.split(",");

            System.out.println((servidores.objectServer(Short.parseShort(elements[0]))));

        } catch (Exception e){
            System.out.println("Parámetros inválidos. Debe ingresar: SlotServer, nameGM. Error: " + e);
        }

    }

}
