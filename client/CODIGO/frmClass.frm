VERSION 5.00
Begin VB.Form frmClass 
   BackColor       =   &H80000007&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "¡Bienvenido a Harald AO!"
   ClientHeight    =   6510
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5775
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmClass.frx":0000
   ScaleHeight     =   6510
   ScaleWidth      =   5775
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox lstGenero 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   450
      Left            =   2760
      TabIndex        =   3
      Top             =   3600
      Width           =   2535
   End
   Begin VB.ListBox lstRazas 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   1710
      Left            =   360
      TabIndex        =   2
      Top             =   3600
      Width           =   2295
   End
   Begin VB.ListBox lstClase 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   2970
      Left            =   360
      TabIndex        =   1
      Top             =   360
      Width           =   2295
   End
   Begin VB.PictureBox picClase 
      Appearance      =   0  'Flat
      BackColor       =   &H80000001&
      ForeColor       =   &H80000008&
      Height          =   3215
      Left            =   2760
      ScaleHeight     =   212
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   169
      TabIndex        =   0
      Top             =   360
      Width           =   2570
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Un mod de Argentum Online"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   615
      Left            =   2640
      TabIndex        =   5
      Top             =   4680
      Width           =   3015
   End
   Begin VB.Image cmdOk 
      Height          =   495
      Left            =   1920
      Top             =   5880
      Width           =   1935
   End
   Begin VB.Label lblwelcome 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "HaraldAO Alpha Test "
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   2640
      TabIndex        =   4
      Top             =   4320
      Width           =   3015
   End
End
Attribute VB_Name = "frmClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Public Enum eClass
   ' Mage = 1       'Mago
   ' Cleric      'Clérigo
   ' Warrior     'Guerrero
  '  Assasin     'Asesino
  '  Thief       'Ladrón
  '  Bard        'Bardo
   ' Druid       'Druida
  '  Bandit      'Bandido
  '  Paladin     'Paladín
  '  Hunter      'Cazador
  '  Worker      'Trabajador
   ' Pirat       'Pirata
'End Enum


Private Sub cmdOk_Click()

Call Audio.PlayWave(SND_CLICK)

If (lstClase.ListIndex + 1) < 1 Then
   Call MsgBox("Selecciona una clase para poder continuar", vbInformation, "Falta elegir la clase del personaje")
ElseIf UCase$(lstClase.Text) = "LADRON" Or UCase$(lstClase.Text) = "BANDIDO" Then
   Call MsgBox("Clase no permitida", vbCritical)
ElseIf (lstGenero.ListIndex + 1) < 1 Or (lstRazas.ListIndex + 1) < 1 Then
   Call MsgBox("Te ha faltado definir el sexo o raza del personaje")
Else
   canRun = canRun + 1
   Call writeselectClass(lstClase.ListIndex + 1, lstRazas.ListIndex + 1, lstGenero.ListIndex + 1)
   Unload Me
End If
End Sub

Private Sub Form_Load()
lstClase.Clear

lstClase.AddItem "Mago"
lstClase.AddItem "Clerigo"
lstClase.AddItem "Guerrero"
lstClase.AddItem "Asesino"
lstClase.AddItem "Ladron"
lstClase.AddItem "Bardo"
lstClase.AddItem "Druida"
lstClase.AddItem "Bandido"
lstClase.AddItem "Paladin"
lstClase.AddItem "Cazador"

lstRazas.Clear

lstRazas.AddItem "Humano"
lstRazas.AddItem "Elfo"
lstRazas.AddItem "Elfo Drow"
lstRazas.AddItem "Gnomo"
lstRazas.AddItem "Enano"

lstGenero.Clear

lstGenero.AddItem "Hombre"
lstGenero.AddItem "Mujer"

End Sub

Private Sub lstClase_Click()
On Error GoTo Err

Call Audio.PlayWave(SND_CLICK)

picClase.Picture = LoadPicture(App.path & "\graficos\" & UCase$(lstClase.Text) & ".jpg")
Err:
End Sub

Private Sub lstGenero_Click()
Call Audio.PlayWave(SND_CLICK)
End Sub

Private Sub lstRazas_Click()
Call Audio.PlayWave(SND_CLICK)
End Sub

Private Sub picClase_Click()
Call Audio.PlayWave(SND_CLICK)
End Sub
