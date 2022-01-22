Attribute VB_Name = "modHandleData"
Option Explicit

'/** author: @Oliva Juan Agustín
' ** userForos: Agushh, JAO, Thorkes
' ** date: 05/18
'\*  comments: n/a

Public IP_SV_FATHER         As String
Public Const PORT_SV_FATHER As Integer = 7668

'bytes que envía el cliente al servidor
Private Enum ClientSendMSG
    mCreate
    sndLst
    manageUsers
    saveCharacter
    loginCharacter
End Enum

'bytes que recibe el cliente del servidor
Private Enum ClientMessages
    msgPacket = 1
    lst = 2
    clientLoggued = 3
End Enum

Private Enum eServerMSG
    msg_none
    msg_serverConexion
    msg_port
    msg_lengthName
    msg_existsServer
    msg_clientConexion
    msg_AU
End Enum

Private Enum eManageUsers
    manage_Connect = 0
    manage_Quit = 1
End Enum

Private Const MSG_ERR As String = "Surgió un error inesperado al intentar abrir el servidor "
Private Const MSG_ERR2 As String = ", verifica si tienes desbloqueado el puerto "

Private Const error_serverConexion As String = "Se perdió la conexión con el servidor"
Private Const error_port           As String = "Puerto inválido"
Private Const error_lengthName     As String = "Nombre demasiado corto"
Private Const error_existsServer   As String = "Ya creaste un servidor"
Private Const error_clientConexion As String = "Ocurrió un error inesperado al momento de intentar abrir tu propio servidor. Comprueba que el puerto especificado se encuentre desbloqueado, o que tu firewall permita la conexion."
Private Const error_AU             As String = "¡Versión obsoleta!, ejecuta el AU"



Public Sub handleData()
On Error Resume Next
Dim Packet As Byte

Packet = incomingData2.PeekByte()
    
Select Case Packet

       Case ClientMessages.msgPacket
            Call HandleMsgPacket
            
       Case ClientMessages.lst
             GoTo Jump
            
       Case ClientMessages.clientLoggued
            Call handleClientLoggued
                
Case Else
           
Exit Sub
End Select

Jump:

If incomingData2.length > 0 And Err.Number <> incomingData2.NotEnoughDataErrCode Then
   Err.Clear
   Call handleData
End If
    
End Sub

Public Sub handleData2(ByVal rdata As String)
If frmMain.Winsock1.RemoteHost <> IP_SV_FATHER Or frmMain.Winsock1.RemotePort <> PORT_SV_FATHER Then Exit Sub

Select Case Left$(UCase$(rdata), 1)
       
       Case "M"
            rdata = Right$(rdata, Len(rdata) - 1)
            frmMSG.Show
            
            If val(rdata) = 1 Then
                frmMSG.Label1.Caption = "Mensaje> " & MSG_ERR & sv.Name & MSG_ERR2 & sv.Port
            End If
       Exit Sub
       
       Case "J"
            rdata = Right$(rdata, Len(rdata) - 1)
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> " & rdata, FontTypeNames.FONTTYPE_GUILD))
       Exit Sub
       
       Case "P"
            rdata = Right$(rdata, Len(rdata) - 1)
            Dim miGM As String
                miGM = ReadField(1, rdata, Asc(","))
                
                If NameIndex(miGM) > 0 Then
                   UserList(NameIndex(miGM)).flags.Privilegios = PlayerType.Admin
                End If
            
       Exit Sub

End Select

End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''LEEMOS''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Sub HandleMsgPacket()
With outgoingData2
     Call incomingData2.ReadByte
     
     Dim msg As Integer
         msg = incomingData2.ReadInteger()
     
     Select Case msg
            Case eServerMSG.msg_clientConexion
                 Call MsgBox(error_clientConexion)
            Case eServerMSG.msg_existsServer
                 Call MsgBox(error_existsServer)
            Case eServerMSG.msg_lengthName
                 Call MsgBox(error_lengthName)
            Case eServerMSG.msg_port
                 Call MsgBox(error_port)
            Case eServerMSG.msg_serverConexion
                 Call MsgBox(error_serverConexion)
            Case eServerMSG.msg_AU
                 Call MsgBox(error_AU)
            Case Else
                 Call MsgBox("Ocurrió un error inesperado", vbCritical)
     End Select
     
End With
End Sub

Public Sub handleClientLoggued()
Dim UserIndex As Integer
Dim Name      As String
Dim Matados   As Long

With outgoingData2
     Call incomingData2.ReadByte
     
     UserIndex = incomingData2.ReadInteger()
     Name = incomingData2.ReadASCIIString()
     'Matados = incomingData2.ReadLong()
     
     If Len(UserList(UserIndex).Name) > 0 Then Call CloseSocket(UserIndex)
     
If (UserIndex > 0) Then
    If UserList(UserIndex).ConnIDValida Then
       Call ConnectUser(UserIndex, Name)
      ' UserList(UserIndex).Stats.UsuariosMatados = Matados
    Else
       Call CloseSocket(UserIndex)
    End If
End If
     
End With

End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''ESCRIBIMOS''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Sub writeCreateServer()
 With outgoingData2
 
      .WriteByte ClientSendMSG.mCreate
      .WriteASCIIString sv.Name
      .WriteASCIIString sv.IP
      .WriteInteger sv.Map
      .WriteInteger sv.Port
      .WriteLong 4
 
 End With
End Sub

Public Sub writeManageOnlines(ByVal quit As Integer)

With outgoingData2
     Call .WriteByte(ClientSendMSG.manageUsers)
     'Call .WriteASCIIString(sv.IP)
     Call .WriteInteger(quit)
End With

Call FlushBuffer2

End Sub

Public Sub writeHopeLogin(ByVal UI As Integer)

With outgoingData2
     Call .WriteByte(ClientSendMSG.loginCharacter)
     Call .WriteInteger(UI) 'mandamos solo el userindex ;-)
End With

Call FlushBuffer2

End Sub

Public Sub writeManageFrags(ByVal UI As Integer)

With outgoingData2
     Call .WriteByte(ClientSendMSG.saveCharacter)
     Call .WriteInteger(1)
End With

Call FlushBuffer2

End Sub

Public Sub FlushBuffer2()
    Dim sndData As String
    
    With outgoingData2
        If .length = 0 Then _
            Exit Sub
        
        sndData = .ReadASCIIStringFixed(.length)
        
        Call sendDataParch(sndData)
    End With
End Sub

Public Sub sendDataParch(ByVal data As String)
If frmMain.Winsock1.State = sckConnected Then
   frmMain.Winsock1.SendData data
Else
   Call MsgBox("Se ha perdido la conección", vbCritical)
End If
End Sub

Public Sub writeSendUsersSV()
Dim data As String
    data = "REAINF" & LastUser & ","
End Sub

Public Sub writeSendMapSv()
Dim data As String
    data = "REBINF" & mapReference(mapLoad) & ","
End Sub
