VERSION 5.00
Object = "{33101C00-75C3-11CF-A8A0-444553540000}#1.0#0"; "CSWSK32.OCX"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmConnect 
   BackColor       =   &H00E0E0E0&
   BorderStyle     =   0  'None
   ClientHeight    =   9000
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12000
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   FillColor       =   &H00000040&
   Icon            =   "frmConnect.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   Picture         =   "frmConnect.frx":000C
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin SocketWrenchCtrl.Socket Socket1 
      Left            =   2640
      Top             =   2280
      _Version        =   65536
      _ExtentX        =   741
      _ExtentY        =   741
      _StockProps     =   0
      AutoResolve     =   -1  'True
      Backlog         =   5
      Binary          =   -1  'True
      Blocking        =   -1  'True
      Broadcast       =   0   'False
      BufferSize      =   0
      HostAddress     =   ""
      HostFile        =   ""
      HostName        =   ""
      InLine          =   0   'False
      Interval        =   0
      KeepAlive       =   0   'False
      Library         =   ""
      Linger          =   0
      LocalPort       =   0
      LocalService    =   ""
      Protocol        =   0
      RemotePort      =   0
      RemoteService   =   ""
      ReuseAddress    =   0   'False
      Route           =   -1  'True
      Timeout         =   0
      Type            =   1
      Urgent          =   0   'False
   End
   Begin VB.ListBox List2 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   1395
      ItemData        =   "frmConnect.frx":0052
      Left            =   2760
      List            =   "frmConnect.frx":0054
      TabIndex        =   10
      Top             =   7080
      Visible         =   0   'False
      Width           =   6495
   End
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   1395
      ItemData        =   "frmConnect.frx":0056
      Left            =   2760
      List            =   "frmConnect.frx":0058
      TabIndex        =   9
      Top             =   7080
      Width           =   6495
   End
   Begin VB.TextBox txtPassword 
      Alignment       =   2  'Center
      BackColor       =   &H80000001&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000004&
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   4920
      PasswordChar    =   "*"
      TabIndex        =   8
      Top             =   3840
      Width           =   2130
   End
   Begin VB.TextBox txtName 
      Alignment       =   2  'Center
      BackColor       =   &H80000001&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000004&
      Height          =   375
      Left            =   4920
      TabIndex        =   7
      Top             =   2880
      Width           =   2130
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   600
      Left            =   1440
      Top             =   6960
   End
   Begin VB.TextBox txtIp 
      Alignment       =   2  'Center
      BackColor       =   &H80000007&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   285
      Left            =   360
      TabIndex        =   6
      Text            =   "0"
      Top             =   3600
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.TextBox txtPort 
      Alignment       =   2  'Center
      BackColor       =   &H80000007&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   285
      Left            =   240
      TabIndex        =   5
      Text            =   "0"
      Top             =   3240
      Visible         =   0   'False
      Width           =   2055
   End
   Begin MSWinsockLib.Winsock Winsock1 
      Left            =   11520
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.TextBox txtPasswd 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   225
      IMEMode         =   3  'DISABLE
      Left            =   5520
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   1680
      Visible         =   0   'False
      Width           =   2460
   End
   Begin VB.TextBox txtNombre 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   225
      Left            =   5520
      TabIndex        =   0
      Top             =   1440
      Visible         =   0   'False
      Width           =   2460
   End
   Begin VB.TextBox PortTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   195
      Left            =   12000
      TabIndex        =   2
      Text            =   "7666"
      Top             =   3000
      Visible         =   0   'False
      Width           =   825
   End
   Begin VB.TextBox IPTxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   195
      Left            =   12000
      TabIndex        =   4
      Text            =   "localhost"
      Top             =   4320
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Image Image5 
      Height          =   495
      Left            =   9480
      Top             =   7560
      Width           =   2055
   End
   Begin VB.Image Image4 
      Height          =   495
      Left            =   9480
      Top             =   6960
      Width           =   2055
   End
   Begin VB.Image Image3 
      Height          =   615
      Left            =   2040
      Top             =   6960
      Width           =   735
   End
   Begin VB.Image Image1 
      Height          =   495
      Left            =   5040
      Top             =   5160
      Width           =   1935
   End
   Begin VB.Image Image2 
      Height          =   495
      Left            =   5040
      Top             =   4560
      Width           =   1935
   End
   Begin VB.Label version 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   195
      Left            =   240
      TabIndex        =   3
      Top             =   240
      Visible         =   0   'False
      Width           =   555
   End
End
Attribute VB_Name = "frmConnect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Argentum Online 0.11.6
'
'Copyright (C) 2002 Márquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'Copyright (C) 2002 Matías Fernando Pequeño
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 número 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Código Postal 1900
'Pablo Ignacio Márquez
'
'Matías Fernando Pequeño
'matux@fibertel.com.ar
'www.noland-studios.com.ar
'Acoyte 678 Piso 17 Dto B
'Capital Federal, Buenos Aires - Republica Argentina
'Código Postal 1405

Option Explicit

Private aqui As Byte

Private cBotonCrearPj As clsGraphicalButton
Private cBotonRecuperarPass As clsGraphicalButton
Private cBotonManual As clsGraphicalButton
Private cBotonReglamento As clsGraphicalButton
Private cBotonCodigoFuente As clsGraphicalButton
Private cBotonBorrarPj As clsGraphicalButton
Private cBotonSalir As clsGraphicalButton
Private cBotonLeerMas As clsGraphicalButton
Private cBotonForo As clsGraphicalButton
Private cBotonConectarse As clsGraphicalButton
Private cBotonTeclas As clsGraphicalButton

Public LastButtonPressed As clsGraphicalButton

Private Sub Command1_Click()


End Sub

Private Sub Command2_Click()
Winsock1.Connect "127.0.0.1", 7666
End Sub

Private Sub Command3_Click()
List1.Clear
mdllProtocol.writeShowList
mdllProtocol.FlushBuffer2
End Sub

Private Sub Command4_Click()

End Sub

Private Sub Command5_Click()

End Sub

Private Sub Form_Activate()
'On Error Resume Next

If ServersRecibidos Then
    If CurServer <> 0 Then
        IPTxt = ServersLst(1).IP
        PortTxt = ServersLst(1).Puerto
    Else
        IPTxt = IPdelServidor
        PortTxt = PuertoDelServidor
    End If
End If

aqui = 1

frmCargando.Inet1.Cancel

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        prgRun = False
    End If
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

'Make Server IP and Port box visible
If KeyCode = vbKeyI And Shift = vbCtrlMask Then
    
    'Port
    PortTxt.Visible = True
    'Label4.Visible = True
    
    'Server IP
    PortTxt.Text = "7666"
    IPTxt.Text = "192.168.0.2"
    IPTxt.Visible = True
    'Label5.Visible = True
    
    KeyCode = 0
    Exit Sub
End If

End Sub

Private Sub Form_Load()

    Me.Picture = LoadPicture(DirGraficos & "Connect.jpg")

    '[CODE 002]:MatuX
    EngineRun = False
    '[END]

    PortTxt.Text = Config_Inicio.Puerto

    Socket1.RemotePort = 7667
    Socket1.Listen
        
End Sub

Private Sub LoadButtons()


End Sub

Private Sub CheckServers()
    If ServersRecibidos Then
        If Not IsIp(IPTxt) And CurServer <> 0 Then
            If MsgBox("Atencion, está intentando conectarse a un servidor no oficial, NoLand Studios no se hace responsable de los posibles problemas que estos servidores presenten. ¿Desea continuar?", vbYesNo) = vbNo Then
                If CurServer <> 0 Then
                    IPTxt = ServersLst(CurServer).IP
                    PortTxt = ServersLst(CurServer).Puerto
                Else
                    IPTxt = IPdelServidor
                    PortTxt = PuertoDelServidor
                End If
                Exit Sub
            End If
        End If
    End If
    CurServer = 0
    IPdelServidor = IPTxt
    PuertoDelServidor = PortTxt
End Sub

Private Sub imgBorrarPj_Click()

On Error GoTo errH
    Call Shell(App.path & "\RECUPERAR.EXE", vbNormalFocus)

    Exit Sub

errH:
    Call MsgBox("No se encuentra el programa recuperar.exe", vbCritical, "Argentum Online")
End Sub

Private Sub Image1_Click()

Call Audio.PlayWave(SND_CLICK)

frmCPJ.Show , frmConnect
End Sub

Private Sub Image2_Click()

Call Audio.PlayWave(SND_CLICK)

If Len(curServerIP) < 1 Then
   Call MsgBox("¡Selecciona un servidor online para poder jugar!", vbInformation)
Else

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

    UserName = txtName.Text
    UserPassword = txtPassword.Text

    If CheckUserData(False) = True Then
        EstadoLogin = Normal
        
#If UsarWrench = 1 Then
    frmMain.Socket1.HostName = curServerIP
    frmMain.Socket1.RemotePort = curServerPort
    frmMain.Socket1.Connect
#Else
    frmMain.Winsock1.Connect curServerIP, curServerPort
#End If

    End If
End If
End Sub

Private Sub imgCrearPj_Click()


End Sub

Private Sub imgLeerMas_Click()

End Sub

Private Sub imgManual_Click()

End Sub

Private Sub imgRecuperar_Click()
On Error GoTo errH

    Call Audio.PlayWave(SND_CLICK)
    Call Shell(App.path & "\RECUPERAR.EXE", vbNormalFocus)
    Exit Sub
errH:
    Call MsgBox("No se encuentra el programa recuperar.exe", vbCritical, "Argentum Online")
End Sub

Private Sub imgReglamento_Click()
    Call ShellExecute(0, "Open", "http://ao.alkon.com.ar/reglamento.html", "", App.path, SW_SHOWNORMAL)
End Sub

Private Sub imgSalir_Click()
    prgRun = False
End Sub

Private Sub imgServArgentina_Click()
    Call Audio.PlayWave(SND_CLICK)
    IPTxt.Text = IPdelServidor
    PortTxt.Text = PuertoDelServidor
End Sub

Private Sub imgTeclas_Click()
    Load frmKeypad
    frmKeypad.Show vbModal
    Unload frmKeypad
    txtPasswd.SetFocus
End Sub

Private Sub imgVerForo_Click()
   ' Call ShellExecute(0, "Open", "http://www.alkon.com.ar/foro/argentum-online.53/", "", App.path, SW_SHOWNORMAL)
End Sub

Private Sub Image3_Click()
'agush
If List1.Visible Then
  Call Audio.PlayWave(SND_CLICK)
  Timer1.Enabled = True
  List1.Clear
  mdllProtocol.writeShowList
  mdllProtocol.FlushBuffer2
  Image3.Enabled = False
End If

End Sub

Private Sub Image4_Click()
'agush
If Not List1.Visible Then
   Call Audio.PlayWave(SND_CLICK)
   List1.Visible = True
   List2.Visible = False
End If

End Sub

Private Sub Image5_Click()
'agush
If Not List2.Visible Then
   Call Audio.PlayWave(SND_CLICK)
   List1.Visible = False
   List2.Visible = True
   writeShowListRanking
End If

End Sub

Private Sub list1_Click()
On Error GoTo err

   curServerIP = lstServers(List1.ListIndex).IP
   curServerPort = lstServers(List1.ListIndex).port

   txtIP.Text = curServerIP
   txtPort = curServerPort
   
Exit Sub

err:

End Sub

Private Sub WebAuxiliar_BeforeNavigate2(ByVal pDisp As Object, url As Variant, flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
    
    If InStr(1, url, "alkon") <> 0 Then
        Call ShellExecute(hwnd, "open", url, vbNullString, vbNullString, SW_SHOWNORMAL)
        Cancel = True
    End If
    
End Sub

Private Sub timer_Check_Timer()

End Sub

Private Sub Timer1_Timer()
Static segs As Byte

If aqui > 0 Then
   List1.Clear
   mdllProtocol.writeShowList
   mdllProtocol.FlushBuffer2
   aqui = 0
   segs = 0
   Image3.Enabled = True
   Timer1.Enabled = False
Exit Sub
End If
       segs = segs + 1
       
       If segs >= 5 Then
          segs = 0
          Image3.Enabled = True
          Timer1.Enabled = False
       End If
       
End Sub

Private Sub Winsock1_Connect()
'desplegamos un mensaje en la ventana
'MsgBox "Conectado"

Call incomingData2.ReadASCIIStringFixed(incomingData2.Length)
Call outgoingData2.ReadASCIIStringFixed(outgoingData2.Length)

   List1.Clear
   mdllProtocol.writeShowList
   mdllProtocol.FlushBuffer2
   aqui = 0

End Sub

Private Sub Winsock1_Close()
'cierra la conexion
Winsock1.Close
Call MsgBox("Se perdió la conexion con el servidor", vbInformation, "ThorkesAdminServer")
End Sub

Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)
    Dim RD As String
    Dim data() As Byte
    
    'Socket1.Read RD, DataLength
    Winsock1.GetData RD
    
    data = StrConv(RD, vbFromUnicode)
    
    'Set data in the buffer
    Call incomingData2.WriteBlock(data)
    
    'Send buffer to Handle data
    Call mdllProtocol.handleReadData

End Sub

Private Sub Winsock1_Error(ByVal number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
Winsock1.Close
MsgBox "Error numero " & number & ": " & Description, vbCritical
End
End Sub

