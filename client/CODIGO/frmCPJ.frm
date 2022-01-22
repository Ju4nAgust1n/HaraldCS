VERSION 5.00
Begin VB.Form frmCPJ 
   BackColor       =   &H80000008&
   BorderStyle     =   0  'None
   Caption         =   "Crear un personaje"
   ClientHeight    =   6000
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8985
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6000
   ScaleWidth      =   8985
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtPassword 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   2760
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   3720
      Width           =   3495
   End
   Begin VB.TextBox txtName 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   375
      Left            =   2760
      TabIndex        =   0
      Top             =   2400
      Width           =   3495
   End
   Begin VB.Image imgDone 
      Height          =   495
      Left            =   1680
      Top             =   5040
      Width           =   5655
   End
   Begin VB.Image imgCrear 
      Height          =   495
      Left            =   1680
      Top             =   4440
      Width           =   5655
   End
End
Attribute VB_Name = "frmCPJ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
Me.Picture = LoadPicture(App.path & "\graficos\panelCreacion.jpg")
End Sub

Private Sub imgCrear_Click()

Call Audio.PlayWave(SND_CLICK)

UserName = txtName.Text
UserPassword = txtPassword.Text

writeSaveCharacter 0
FlushBuffer2

UserName = ""
UserPassword = ""

Unload Me
End Sub

Private Sub imgDone_Click()

Call Audio.PlayWave(SND_CLICK)

Unload Me
End Sub

Private Sub txtName_Click()
Call Audio.PlayWave(SND_CLICK)
End Sub

Private Sub txtPassword_Click()
Call Audio.PlayWave(SND_CLICK)
End Sub
