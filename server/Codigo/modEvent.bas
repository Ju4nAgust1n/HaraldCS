Attribute VB_Name = "modEvent"
'agus: tener en cuenta que en todos los mapas puse trigger 6, eso me evita tener que programar el sist de deathmatch =P

Option Explicit

Public Modalidad As Byte
Const max_pjs    As Byte = 20

Enum eModalidad
     Deathmatch = 1
     Team = 2
End Enum

Enum eBandos
     ciuda = 1
     Pk = 2
End Enum

Public equipos()  As tTeam
Public gralTeam() As tgeneralTeam
Public lastBando  As Byte
Public nroCri     As Byte
Public nroCiu     As Byte

Private dCri      As Byte
Private dCiu      As Byte

Type tTeam
    index As Integer
End Type

Type tgeneralTeam
     points As Long
End Type

Public Sub crearEvento(ByVal index As Byte)
   Modalidad = index
   
   If Modalidad = eModalidad.Team Then
      ReDim gralTeam(eBandos.ciuda To eBandos.Pk) As tgeneralTeam
      ReDim equipos(eBandos.ciuda To eBandos.Pk, 1 To max_pjs) As tTeam
   End If
   
End Sub

Public Sub loguearTeam(ByVal UserIndex As Integer)
Dim i As Long, mibando As Byte

If lastBando < 1 Then lastBando = RandomNumber(eBandos.ciuda, eBandos.Pk)

Again:

mibando = IIf(lastBando <> eBandos.ciuda, eBandos.Pk, eBandos.ciuda)

With UserList(UserIndex)

For i = 1 To max_pjs
    If equipos(mibando, i).index < 1 Then
       equipos(mibando, i).index = UserIndex
       .bando = mibando
        Exit For
    End If
Next i

If .bando < 1 Then GoTo Again

If .bando = eBandos.ciuda Then
   nroCiu = nroCiu + 1
   lastBando = eBandos.Pk
Else
   nroCri = nroCri + 1
   lastBando = eBandos.ciuda
End If

End With
End Sub

Public Sub checkearMuerte(ByVal UI As Integer)
With UserList(UI)

     If .bando = eBandos.ciuda Then
         dCiu = dCiu + 1
         
         If dCiu >= nroCiu Then

            gralTeam(eBandos.Pk).points = gralTeam(eBandos.Pk).points + 1
            Call revivirUserMuertos
         
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("　Ronda para el equipo criminal!!, suman " & gralTeam(eBandos.Pk).points & " puntos.", FontTypeNames.FONTTYPE_CONSEJOCAOS))
         End If
         
     Else
         dCri = dCri + 1
         
         If dCri >= nroCri Then
         
            gralTeam(eBandos.ciuda).points = gralTeam(eBandos.ciuda).points + 1
            Call revivirUserMuertos
         
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("　Ronda para el equipo ciudadano!!, suman " & gralTeam(eBandos.ciuda).points & " puntos.", FontTypeNames.FONTTYPE_CONSEJO))
         End If
         
     End If

End With
End Sub

Public Sub checkearMuerte2(ByVal UI As Integer)
With UserList(UI)
     Dim i As Long, count As Byte
         For i = 1 To max_pjs
             If equipos(.bando, i).index > 0 Then
                
                If UserList(equipos(.bando, i).index).flags.Muerto Then
                   count = count + 1
                End If
                
                If count >= IIf(.bando <> eBandos.ciuda, nroCri, nroCiu) Then Exit For
                
             End If
         Next i
         
If count >= IIf(.bando <> eBandos.ciuda, nroCri, nroCiu) Then
   Dim otherBando As Byte
       otherBando = IIf(.bando <> eBandos.ciuda, eBandos.Pk, eBandos.ciuda)
       
       For i = 1 To max_pjs
           definirPos i
           If UserList(i).flags.Muerto Then
              Call RevivirUsuario(i)
           End If
       Next i
       
       gralTeam(otherBando).points = gralTeam(otherBando).points + 1
       
       If .bando = eBandos.ciuda Then
          Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("　Ronda para el equipo ciudadano!!, suman " & gralTeam(eBandos.ciuda).points & " puntos.", FontTypeNames.FONTTYPE_CONSEJO))
       Else
          Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("　Ronda para el equipo criminal!!, suman " & gralTeam(eBandos.Pk).points & " puntos.", FontTypeNames.FONTTYPE_CONSEJOCAOS))
       End If
End If
         
End With
End Sub

Public Sub cerrarUserTeam(ByVal UI As Integer)
If Modalidad = eModalidad.Team Then
   With UserList(UI)
   
   If .bando = eBandos.ciuda Then
       nroCiu = nroCiu - 1
   Else
       nroCri = nroCri - 1
   End If
   
       equipos(.bando, UI).index = 0
       .bando = 0
   End With
End If
End Sub

Public Sub revivirUserMuertos()
Dim i As Long

For i = 1 To LastUser
    If UserList(i).flags.Muerto Then
       Call RevivirUsuario(i)
    End If
    
    Call definirPos(i, 0) 'transportamos a TODOS segun corresponda
    
Next i

End Sub

