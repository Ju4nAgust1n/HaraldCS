VERSION 5.00
Begin VB.Form frmOldCaracter 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   3750
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   Picture         =   "frmOldCaracter.frx":0000
   ScaleHeight     =   3750
   ScaleWidth      =   7200
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtPassword 
      Appearance      =   0  'Flat
      BackColor       =   &H00C00000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   285
      Left            =   2160
      TabIndex        =   1
      Top             =   1200
      Visible         =   0   'False
      Width           =   4815
   End
   Begin VB.TextBox txtNombre 
      Appearance      =   0  'Flat
      BackColor       =   &H00C00000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   285
      Left            =   2160
      TabIndex        =   0
      Text            =   "BetaTester"
      Top             =   720
      Width           =   4815
   End
   Begin VB.Image Image2 
      Height          =   495
      Left            =   1680
      Picture         =   "frmOldCaracter.frx":58422
      Top             =   3120
      Width           =   960
   End
   Begin VB.Image Image1 
      Height          =   495
      Left            =   4595
      Picture         =   "frmOldCaracter.frx":59D24
      Top             =   3120
      Width           =   960
   End
End
Attribute VB_Name = "frmOldCaracter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Image1_Click()
    
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
    
    'update user info
    UserName = txtNombre.Text
    
 '   Dim aux As String
  '  aux = txtPassword.Text
    
'#If SeguridadAlkon Then
  '  UserPassword = md5.GetMD5String(aux)
    'Call md5.MD5Reset
'#Else
  '  UserPassword = aux
'#End If

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
    
End Sub

Private Sub Image2_Click()
Unload Me
End Sub
