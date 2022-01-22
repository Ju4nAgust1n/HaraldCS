Attribute VB_Name = "modRanking"
'Fecha de creación: 24/12/17
'Autor: Agushh (UserForos: Agushh - Thorkes)

Option Explicit

Private maxTop As Byte 'definimos el máximo de pjs y clanes en el top
Private cantTablas As Byte 'cuántos tipos de ranking hay?

Public topUsers() As tRank 'propiedades de cada puesto de pjs y clanes

Type tRank
  Nick As String
  Valor As Integer
End Type

Public Enum eModoRank 'tipos de ranking disponibles. actualmente hardcodeado
        mkills = 1
        mquests = 2
        mtorn = 3
End Enum

'agush: es diferente en este sentido al que hice para la 13.0, ya que no debemos leer ni grabar algo
Public Sub loadRank()

        maxTop = sv.maxOn
        cantTablas = 3 'emodorank
        
        ReDim topUsers(1 To cantTablas, 0 To maxTop, 0 To eBandos.Pk) As tRank

End Sub

'este procedimiento sirve para saber si ya estamos ubicados en la tabla, pero _
  verificando que no pongamos nuestro nombre por duplicado
Private Function rankeado(ByVal UserIndex As Integer, ByVal index As Long, ByVal Modo As Byte) As Boolean
Dim i As Long, Nick As String
For i = 0 To maxTop

If i < index Then

   Select Case Modo
     Case eModoRank.mkills
          Nick = topUsers(eModoRank.mkills, i, UserList(UserIndex).bando).Nick
     Case eModoRank.mquests
          
     Case eModoRank.mtorn
         
   End Select

   If UCase$(UserList(UserIndex).Name) = Nick Then
         rankeado = True
      Exit Function
   Else
         rankeado = False
   End If

End If

Next i
End Function

'qué posición tengo en la tabla?
Function posRanks(ByVal Name As String, ByVal Modo As Byte, ByVal bando As Byte) As Long
Dim i As Long, count As Byte
    Name = UCase$(Name)
    posRanks = -1
    
For i = 0 To maxTop
   Select Case Modo
   
          Case eModoRank.mkills

                If topUsers(eModoRank.mkills, i, bando).Nick = Name And Len(topUsers(eModoRank.mkills, i, bando).Nick) > 0 Then
                   count = count + 1
                    If count > 1 Then
                       count = 0
                       posRanks = i
                    End If
                  Exit For
                End If
                
   End Select
Next i

End Function

'reacomodo de tablas
Private Sub prepTablas(ByVal psR As Long, ByVal Modo As Byte, ByVal bando As Byte)
Dim X As Long

    topUsers(eModoRank.mkills, psR, bando).Nick = ""
    topUsers(eModoRank.mkills, psR, bando).Valor = 0
          
For X = psR To maxTop - 1
    topUsers(eModoRank.mkills, X, bando).Valor = topUsers(eModoRank.mkills, X + 1, bando).Valor
    topUsers(eModoRank.mkills, X, bando).Nick = topUsers(eModoRank.mkills, X + 1, bando).Nick
Next X

End Sub

'guardado definitivo de tablas
Private Sub defTablas(ByVal Name As String, ByVal Pos As Long, psR As Long, ByVal Modo As Byte, ByVal bando As Byte)
Dim X As Long

    If topUsers(eModoRank.mkills, Pos, bando).Nick <> UCase$(Name) Then
       For X = IIf(psR <> -1, Pos, psR + 2) To (maxTop - 1)
           If (maxTop - (X + 1)) >= Pos Then
              topUsers(eModoRank.mkills, maxTop - X, bando).Valor = topUsers(eModoRank.mkills, maxTop - (X + 1), bando).Valor
              topUsers(eModoRank.mkills, maxTop - X, bando).Nick = topUsers(eModoRank.mkills, maxTop - (X + 1), bando).Nick
           End If
       Next X
    End If

End Sub

Public Sub actualizarRanking(ByVal UserIndex As Integer, ByVal eModo As Byte)
With UserList(UserIndex)
Dim i As Long, X As Long, Pos(0 To 1) As Long

'tabla de usuarios matados
If eModo = eModoRank.mkills Then

       For i = 0 To maxTop
       
       'estamos en el ranking y deberíamos estar mejor posicionados en la tabla
           If .Stats.UsuariosMatados > topUsers(eModoRank.mkills, i, .bando).Valor And rankeado(UserIndex, i, eModoRank.mkills) = True And i < IIf(i <> 0, Pos(0), i + 1) Then
               Pos(1) = i: Pos(0) = -2
               If i > Pos(0) Then Exit For
              Exit For
           End If
       
       'no estamos en el ranking y debemos posicionarnos en la tabla
           If .Stats.UsuariosMatados > topUsers(eModoRank.mkills, i, .bando).Valor And rankeado(UserIndex, i, eModoRank.mkills) = False Then
               Pos(1) = i: Pos(0) = -2
              Exit For
           End If
           
       'fin ciclo i
       Next i
       
       'si no superamos a alguien en la tabla; adios
       If Pos(0) <> -2 Then Exit Sub
       
       Dim psR As Long
           psR = posRanks(.Name, eModoRank.mkills, .bando)
             
       If psR > -1 Then Call prepTablas(psR, eModoRank.mkills, .bando)
        
           Call defTablas(.Name, Pos(1), psR, eModoRank.mkills, .bando)
                     
       'nos incorporamos a la tabla, o en su defecto, actualizamos
           topUsers(eModoRank.mkills, Pos(1), .bando).Valor = .Stats.UsuariosMatados
           topUsers(eModoRank.mkills, Pos(1), .bando).Nick = UCase$(.Name)

End If

End With
End Sub

Public Sub closeUserRank(ByVal Name As String, ByVal bando As Byte)
Dim i As Long

For i = 0 To maxTop
    If UCase$(topUsers(eModoRank.mkills, i, bando).Nick) = UCase$(Name) Then
       
       prepTablas i, eModoRank.mkills, bando
       
     Exit For
    End If
Next i

End Sub

Public Function prepareLstCri(ByVal Modo As Byte) As String
Dim i As Long, data As String

prepareLstCri = nroCri & ","

For i = 0 To maxTop
    prepareLstCri = prepareLstCri & topUsers(Modo, i, eBandos.Pk).Nick & "," & topUsers(Modo, i, eBandos.Pk).Valor & ","
Next i

End Function

Public Function prepareLstCiu(ByVal Modo As Byte) As String
Dim i As Long, data As String

prepareLstCiu = nroCiu & ","

For i = 0 To maxTop
    prepareLstCiu = prepareLstCiu & topUsers(Modo, i, eBandos.ciuda).Nick & "," & topUsers(Modo, i, eBandos.ciuda).Valor & ","
Next i

End Function

Public Function prepareLstDeath(ByVal Modo As Byte) As String
Dim i As Long, data As String

prepareLstDeath = NumUsers & ","

For i = 0 To maxTop
    prepareLstDeath = prepareLstDeath & topUsers(Modo, i, 0).Nick & "," & topUsers(Modo, i, 0).Valor & ","
Next i

End Function
