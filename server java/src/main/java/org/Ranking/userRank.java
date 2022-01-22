package org.Ranking;

import org.Util.IniFile;

/**
 *
 * @author: JAO (Juan Agustín Oliva)
 * @userforos: Agushh, Thorkes
 */

public class userRank {

    int max_length = 20;
    private final static String file_name = "ranking";

    String name[] = new String[this.max_length];
    int kills[]  = new int[this.max_length];

    public userRank(){
        //
    }

    private static String getRankFile() {
        return "rank" + java.io.File.separator + file_name + ".dat";
    }

    public void initializeRank(){
    try {
        IniFile get = new IniFile(getRankFile());
        int i = 0;
        while (i < this.max_length) {
            this.name[i] = get.getString("INIT", "Name" + i).toUpperCase();
            this.kills[i] = get.getInt("INIT", "Muertes" + i);
            i++;
        }
    } catch (Exception e){
        System.out.println("Error en initializeRank. Error: " + e);
    }
    }

    private int isRank(String name){
        int i = 0;
        while (i < this.max_length){
            String name1  = this.name[i].toUpperCase();
            String name2 = name.toUpperCase();
            if (name1.equals(name2)) return i;
            i++;
        }
        return (-1);
    }

    public void refreshRank(String name, int kills){
        int y = isRank(name);
        int t = 0;
        boolean can = false;
        boolean refresh = false;

        String[] tempName = new String[max_length];
        int[] tempKill = new int[max_length];

        for(int i = 0; i < max_length; i++){

            tempName[i] = this.name[i];
            tempKill[i] = this.kills[i];

            if (y == i) {
                refresh = true;
                break;
            }else{
                if (kills > this.kills[i]) {
                    can = true;
                    t = i;
                    break;
                }
            }

        }

        if (can){

            if (y > -1) reorganizeList(y);

            tempName[t] = name;
            tempKill[t] = kills;

            for(int x = t;x < max_length - 1; x++){
                    tempName[x + 1] = this.name[x];
                    tempKill[x + 1] = this.kills[x];
            }

            this.name = tempName;
            this.kills = tempKill;

        } else if (refresh){
            if (y >= 0) this.kills[y] = kills;
        }
    }

    private void reorganizeList(int slot){
        for(int i = slot; i < max_length - 1; i++){
            this.name[i] = this.name[i + 1];
            this.kills[i] = this.kills[i + 1];
        }
    }

    private void saveRank(){
        try {
            IniFile put = new IniFile();
            int i = 0;

            while (i < this.max_length){
                put.setValue("INIT", "Name" + i, this.name[i].toUpperCase());
                put.setValue("INIT", "Muertes" + i, this.kills[i]);
                i++;
            }

            put.store(getRankFile());
        } catch (Exception e) {
            System.out.println("Error en saveRank: " + e);
        }

    }

    public String preparelstRanking(){
        int i = 0;
        String txt = "";
        while (i < this.max_length){
            txt = txt + this.name[i] + "," + this.kills[i] + ",";
            i++;
        }

        return txt;

    }


}
