package org.Protocol.idMessages;

/**
 *
 * @author: JAO (Juan Agustín Oliva)
 * @userforos: Agushh, Thorkes
 */

public interface ClientMessage {

    final static byte createServer    = 0;
    final static byte sendLst         = 1;
    final static byte manageOnline    = 2;
    final static byte saveCharacter   = 3;
    final static byte loginCharacter  = 4;
    final static byte sendLstRanking  = 5;
    final static byte sumarKills      = 6;

}