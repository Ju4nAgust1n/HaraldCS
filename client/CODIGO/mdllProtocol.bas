Attribute VB_Name = "mdllProtocol"
'/** author: @Oliva Juan Agustín
' ** userForos: Agushh, JAO, Thorkes
' ** date: 05/18
'\*  comments: n/a

'bytes que envía el cliente al servidor
Private Enum ClientSendMSG
    mCreate
    sndLst
    manageUsers
    saveCharacter
    loginCharacter
    sRank
    kills
End Enum

'bytes que recibe el cliente del servidor
Private Enum ClientMessages
    none
    msgPacket
    msgSendLst
    none2
    msgRanking
End Enum

Public Sub handleReadData()
On Error Resume Next
Dim Packet As Byte

Packet = incomingData2.PeekByte()
    
Select Case Packet

       Case ClientMessages.msgPacket
            Call HandleMsgPacket
            
        Case ClientMessages.msgSendLst
            Call HandleLst
            
        Case ClientMessages.msgRanking
            Call handlelstRank
                
Case Else
           
Exit Sub
End Select

If incomingData2.Length > 0 And err.number <> incomingData2.NotEnoughDataErrCode Then
   err.Clear
   Call handleReadData
End If
    
End Sub

Public Sub HandleMsgPacket()
With outgoingData2

     Call incomingData2.ReadByte
     MsgBox incomingData2.ReadASCIIString()
     
#If UsarWrench = 1 Then
    If frmMain.Socket1.Connected Then
        frmMain.Socket1.Disconnect
        frmMain.Socket1.Cleanup
        DoEvents
    End If
#Else
    If frmMain.Winsock1.State <> sckClosed Then
        frmMain.Winsock1.Close
        DoEvents
    End If
#End If
     
End With
End Sub

Public Sub HandleLst()
Dim rdata As String

With outgoingData2

Call incomingData2.ReadByte
rdata = incomingData2.ReadASCIIString()

            Dim i As Long, X As Long, cant As Byte
            
               cant = ReadField(1, rdata, Asc(","))
            
                For i = 0 To cant - 1
                   lstServers(i).name = ReadField(IIf(i <> 0, (i + 2) + X, 2), rdata, Asc(","))
                   lstServers(i).IP = ReadField(IIf(i <> 0, (i + 3) + X, 3), rdata, Asc(","))
                   lstServers(i).port = ReadField(IIf(i <> 0, (i + 4) + X, 4), rdata, Asc(","))
                   lstServers(i).mapa = ReadField(IIf(i <> 0, (i + 5) + X, 5), rdata, Asc(","))
                   lstServers(i).online = ReadField(IIf(i <> 0, (i + 6) + X, 6), rdata, Asc(","))

                   X = X + 4 'agush: el por qué de esto radica en una sumatoria, la demostración quedó en mi mente, pero dejo un muestreo =P
                   
'Muestreo para casos i > 0 (aquí i = 1), ya que para i = 0 se encuentra predeterminado con iif _
 partimos de 2, ya que es la posición inicial para leer Q (datos dependientes de cada sub-servidor) _
 _
 DATOS              Col1                Col2               Col3             Col4              Col5 s _
 i = 1 ->>        1 + 2 + 4 = 7        1 + 3 + 4 = 8     1 + 4 + 4 = 9     1 + 5 + 4 = 10   1 + 6 + 4 = 11
                    
                   If Len(lstServers(i).name) > 0 Then
                      frmConnect.List1.AddItem lstServers(i).name & " " & "(" & lstServers(i).IP & ")" & " " & "(" & lstServers(i).port & ")" & " 'map: [" & mapReference(lstServers(i).mapa) & "]" & " Jugadores: " & lstServers(i).online & ""
                   Else
                      frmConnect.List1.AddItem "(None)"
                   End If
                    
              Next i
     
End With
End Sub

Public Sub handlelstRank()
Dim rdata  As String
Dim linea  As String
Dim Pos    As Byte
Dim cant   As Byte
Dim puesto As Byte
Dim name   As String
Dim kills  As Long

Call incomingData2.ReadByte

frmConnect.List2.Clear

rdata = incomingData2.ReadASCIIString()
Pos = Pos + 1
puesto = puesto + 1
cant = 2 * Mod_Declaraciones.MAX_PUESTOS ' 2 es la cantidad de datos por char. Esto se _
                                              multiplica por la cantidad de puestos disponibles en el ranking

Do While (Pos < cant)

   name = ReadField(Pos, rdata, Asc(","))

   If Len(name) > 1 Then
      linea = "Puesto " & puesto & " : " & UCase$(ReadField(Pos, rdata, Asc(",")))
   Else
      linea = ""
   End If
   
   Pos = Pos + 1
   
   kills = Val(ReadField(Pos, rdata, Asc(",")))
   
   If kills > 0 Then
      If kills = 1 Then
         linea = linea & " con: " & ReadField(Pos, rdata, Asc(",")) & " muerte"
      Else
         linea = linea & " con: " & ReadField(Pos, rdata, Asc(",")) & " muertes"
      End If
   End If
   
   If kills > 0 Then frmConnect.List2.AddItem linea
   
   Pos = Pos + 1
   puesto = puesto + 1
   
Loop

End Sub

Public Sub writeSaveCharacter(ByVal accion As Integer)
 With outgoingData2
  
      Call .WriteByte(ClientSendMSG.saveCharacter)
      Call .WriteInteger(accion)
     
      If accion < 1 Then
         Call .WriteASCIIString(UserName)
         Call .WriteASCIIString(UserPassword)
      End If
      
 End With
End Sub

Public Sub writeLoginCharacter(ByVal UI As Integer)

 With outgoingData2
 
      Call .WriteByte(ClientSendMSG.loginCharacter)
      Call .WriteASCIIString(UserName)
      Call .WriteASCIIString(UserPassword)
      Call .WriteASCIIString(curServerIP)
      Call .WriteInteger(UI)
      Call .WriteLong(3)
 
 End With
End Sub

Public Sub writeShowList()
 With outgoingData2
 
      .WriteByte ClientSendMSG.sndLst
 
 End With
End Sub

Public Sub writeShowListRanking()
 With outgoingData2
 
      .WriteByte ClientSendMSG.sRank
      FlushBuffer2
 
 End With
End Sub

Public Sub writesendKills()
 With outgoingData2
 
      .WriteByte ClientSendMSG.kills
      FlushBuffer2
 
 End With
End Sub



Public Sub FlushBuffer2()
    Dim sndData As String
    
    With outgoingData2
        If .Length = 0 Then _
            Exit Sub
        
        sndData = .ReadASCIIStringFixed(.Length)
        
        Call sendDataParch(sndData)
    End With
End Sub

