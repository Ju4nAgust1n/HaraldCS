VERSION 5.00
Begin VB.Form frmCrear 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   1350
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   1320
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   1320
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCreate 
      Caption         =   "Create"
      Height          =   315
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   1095
   End
   Begin VB.TextBox txtPort 
      Height          =   285
      Left            =   120
      TabIndex        =   1
      Text            =   "server port"
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox txtName 
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Text            =   "server name"
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "frmCrear"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

End Sub

Private Sub cmdCreate_Click()
sv.Name = txtName.Text
sv.Port = txtPort.Text

Call Main
End Sub
