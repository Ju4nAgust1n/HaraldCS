VERSION 5.00
Begin VB.Form frmCrear 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   6210
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4725
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   4725
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Data General"
      Height          =   6135
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   4455
      Begin VB.CommandButton cmdCreate 
         Caption         =   "¡¡Crear!!"
         Height          =   315
         Left            =   2040
         TabIndex        =   20
         Top             =   3120
         Width           =   2175
      End
      Begin VB.Frame Frame5 
         Caption         =   "Mapa y modalidades"
         Height          =   2535
         Left            =   120
         TabIndex        =   15
         Top             =   3480
         Width           =   1815
         Begin VB.ListBox lstMapas 
            Height          =   645
            Left            =   120
            TabIndex        =   17
            Top             =   720
            Width           =   1335
         End
         Begin VB.ComboBox lstMod 
            Height          =   315
            Left            =   120
            TabIndex        =   16
            Top             =   1920
            Width           =   1455
         End
         Begin VB.Label Label2 
            Alignment       =   2  'Center
            Caption         =   "¿Mapa?:"
            Height          =   255
            Left            =   240
            TabIndex        =   19
            Top             =   360
            Width           =   1215
         End
         Begin VB.Label Label5 
            Alignment       =   2  'Center
            Caption         =   "¿Modalidad?"
            Height          =   255
            Left            =   120
            TabIndex        =   18
            Top             =   1560
            Width           =   1335
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Límite de usuarios"
         Height          =   855
         Left            =   120
         TabIndex        =   12
         Top             =   2400
         Width           =   1815
         Begin VB.TextBox txtMaxOn 
            Alignment       =   2  'Center
            BorderStyle     =   0  'None
            Height          =   285
            Left            =   240
            TabIndex        =   13
            Text            =   "10"
            Top             =   480
            Width           =   1335
         End
         Begin VB.Label Label1 
            Alignment       =   2  'Center
            Caption         =   "Máx users:"
            Height          =   255
            Left            =   240
            TabIndex        =   14
            Top             =   240
            Width           =   1335
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Opciónes de jugabilidad"
         Height          =   2415
         Left            =   2040
         TabIndex        =   6
         Top             =   480
         Width           =   2175
         Begin VB.CheckBox Check5 
            Caption         =   "Con trampas"
            Height          =   255
            Left            =   120
            TabIndex        =   11
            Top             =   1920
            Width           =   1815
         End
         Begin VB.CheckBox Check1 
            Caption         =   "Con invisibilidad"
            Enabled         =   0   'False
            Height          =   255
            Left            =   120
            TabIndex        =   10
            Top             =   360
            Width           =   1815
         End
         Begin VB.CheckBox Check2 
            Caption         =   "Con estupidez"
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Top             =   720
            Width           =   1695
         End
         Begin VB.CheckBox Check3 
            Caption         =   "Con mascotas (eles)"
            Height          =   255
            Left            =   120
            TabIndex        =   8
            Top             =   1080
            Width           =   1935
         End
         Begin VB.CheckBox Check4 
            Caption         =   "Mago vs Mago sin inmo"
            Height          =   375
            Left            =   120
            TabIndex        =   7
            Top             =   1440
            Width           =   1695
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Info Host"
         Height          =   2055
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   1815
         Begin VB.TextBox txtIP 
            Alignment       =   2  'Center
            BorderStyle     =   0  'None
            Height          =   285
            Left            =   120
            TabIndex        =   22
            Text            =   "IP aquí"
            Top             =   720
            Visible         =   0   'False
            Width           =   1575
         End
         Begin VB.TextBox txtName 
            Alignment       =   2  'Center
            BorderStyle     =   0  'None
            Height          =   285
            Left            =   120
            TabIndex        =   3
            Text            =   "Default name"
            Top             =   480
            Width           =   1575
         End
         Begin VB.TextBox txtPort 
            Alignment       =   2  'Center
            BorderStyle     =   0  'None
            Height          =   285
            Left            =   120
            TabIndex        =   2
            Text            =   "7666"
            Top             =   1320
            Width           =   1575
         End
         Begin VB.Label Label3 
            Alignment       =   2  'Center
            Caption         =   "Nombre del server"
            Height          =   255
            Left            =   120
            TabIndex        =   5
            Top             =   240
            Width           =   1575
         End
         Begin VB.Label Label4 
            Alignment       =   2  'Center
            Caption         =   "Puerto"
            Height          =   255
            Left            =   120
            TabIndex        =   4
            Top             =   1080
            Width           =   1575
         End
      End
      Begin VB.Label Label6 
         BackStyle       =   0  'Transparent
         Caption         =   $"frmCrear.frx":0000
         Height          =   1575
         Left            =   2040
         TabIndex        =   21
         Top             =   3600
         Width           =   2295
      End
   End
End
Attribute VB_Name = "frmCrear"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

End Sub

Private Sub Check4_Click()
Call MsgBox("Con esto, los magos no podran inmovilizar a otros magos, pero sí a otras clases")
End Sub

Private Sub cmdCreate_Click()
   If Len(txtName.Text) < 5 Then
      MsgBox ("El nombre del servidor al menos debe tener 5 caracteres"), , "Harald"
ElseIf Len(txtPort.Text) < 1 Then
       MsgBox ("Introduzca un puerto"), , "Harald"
ElseIf val(txtMaxOn.Text) < 5 Then
       MsgBox "Esos son muy pocos usuarios", , "Harald"
ElseIf Len(lstMapas.Text) < 1 Then
       MsgBox "Selecciona un mapa", , "Harald"
ElseIf Len(lstMod.Text) < 1 Then
       MsgBox "Selecciona una modalidad", , "Harald"
ElseIf UCase$(lstMod.Text) = "EQUIPOS" And CInt(val(txtMaxOn.Text) / 2) <> (val(txtMaxOn.Text) / 2) Then
       MsgBox "Si seleccionaste la modalidad Equipos, debes poner un número de usuarios máximos que sea PAR, ejemplos posibles: 6, 8, 10, 12, 14, 16, 18, o 20", , "Harald"
Else

       Me.Enabled = False

       mapLoad = lstMapas.ListIndex + 1
       sv.Map = mapLoad
       
       sv.Name = txtName.Text
       
       sv.Port = txtPort.Text
       sv.maxOn = txtMaxOn.Text
       
       sv.carac.invi = CByte(Check1.value)
       sv.carac.estu = CByte(Check2.value)
       sv.carac.mascot = CByte(Check3.value)
       sv.carac.magoinmo = CByte(Check4.value)
       sv.carac.trampa = CByte(Check5.value)

       Me.Enabled = False
       
       crearEvento lstMod.ListIndex + 1
       
       Call Main
End If
End Sub

Private Sub Form_Load()
       Call modloadMaps.cargarLista
       lstMod.AddItem "Deathmatch"
       lstMod.AddItem "Equipos"
       txtIP.Enabled = False
End Sub

Private Sub Text1_Change()

End Sub

Private Sub txtIP_Click()
Call MsgBox("Para saber tu IP pública ingresa en wwww.cualesmiip.com y pega tu IP en este texto", vbInformation)
End Sub

Private Sub txtMaxOn_Change()
If Not IsNumeric(txtMaxOn.Text) Then txtMaxOn.Text = ""
If val(txtMaxOn.Text) > 20 Then txtMaxOn.Text = "20"
End Sub

