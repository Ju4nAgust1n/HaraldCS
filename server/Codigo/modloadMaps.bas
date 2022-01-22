Attribute VB_Name = "modloadMaps"
'agus sapeee

Option Explicit

Public Enum eMapas
            de_cbble = 1
            de_conjun = 2
            de_desert = 3
            de_dust2 = 4
            de_nuke = 5
            fy_bloque = 6
            fy_caverna = 7
            fy_cruz = 8
            fy_duel = 9
            fy_duel2 = 10
            fy_duel3 = 11
            fy_dust = 12
            fy_fuerte = 13
            fy_iceword = 14
            fy_planted = 15
            fy_poolday = 16
End Enum

Public mapReference(1 To 16) As String
Public mapLoad      As Integer

Public Sub cargarLista()
With frmCrear
     .lstMapas.AddItem "de_cbble"
     .lstMapas.AddItem "de_conjun"
     .lstMapas.AddItem "de_desert"
     .lstMapas.AddItem "de_dust2"
     .lstMapas.AddItem "de_nuke"
     .lstMapas.AddItem "fy_bloque"
     .lstMapas.AddItem "fy_caverna"
     .lstMapas.AddItem "fy_cruz"
     .lstMapas.AddItem "fy_duel"
     .lstMapas.AddItem "fy_duel2"
     '.lstMapas.AddItem "fy_duel3"
     '.lstMapas.AddItem "fy_dust"
     '.lstMapas.AddItem "fy_fuerte"
     '.lstMapas.AddItem "fy_iceworld"
     '.lstMapas.AddItem "fy_planted"
     '.lstMapas.AddItem "fy_poolday"
End With

mapReference(eMapas.de_cbble) = "de_cbble"
mapReference(eMapas.de_conjun) = "de_conjun"
mapReference(eMapas.de_desert) = "de_desert"
mapReference(eMapas.de_dust2) = "de_dust2"
mapReference(eMapas.de_nuke) = "de_nuke"
mapReference(eMapas.fy_bloque) = "fy_bloque"
mapReference(eMapas.fy_caverna) = "fy_caverna"
mapReference(eMapas.fy_cruz) = "fy_cruz"
mapReference(eMapas.fy_duel) = "fy_duel"
mapReference(eMapas.fy_duel2) = "fy_duel2"
mapReference(eMapas.fy_duel3) = "fy_duel3"
mapReference(eMapas.fy_dust) = "fy_dust"
mapReference(eMapas.fy_fuerte) = "fy_fuerte"
mapReference(eMapas.fy_iceword) = "fy_iceworld"
mapReference(eMapas.fy_planted) = "fy_planted"
mapReference(eMapas.fy_poolday) = "fy_poolday"

End Sub

Public Sub definirPos(ByVal UserIndex As Integer, Optional logued As Byte = 0)
Dim X As Integer, Y As Integer
With UserList(UserIndex)

   .Pos.Map = mapLoad

If Modalidad = eModalidad.Deathmatch Then
     
     Select Case .Pos.Map
     
            Case eMapas.de_cbble
                 X = RandomNumber(40, 52)
                 Y = RandomNumber(77, 86)
            Case eMapas.de_conjun
                 X = RandomNumber(30, 43)
                 Y = RandomNumber(40, 50)
            Case eMapas.de_desert
                 X = RandomNumber(42, 52)
                 Y = RandomNumber(47, 54)
            Case eMapas.de_dust2
                 X = RandomNumber(59, 74)
                 Y = RandomNumber(17, 22)
            Case eMapas.de_nuke
                 X = RandomNumber(42, 56)
                 Y = RandomNumber(50, 60)
            Case eMapas.fy_bloque
                 X = RandomNumber(30, 40)
                 Y = RandomNumber(20, 30)
            Case eMapas.fy_caverna
                 X = RandomNumber(43, 66)
                 Y = RandomNumber(40, 48)
            Case eMapas.fy_cruz
                 X = RandomNumber(19, 26)
                 Y = RandomNumber(44, 57)
            Case eMapas.fy_duel
                 X = RandomNumber(40, 59)
                 Y = RandomNumber(44, 67)
            Case eMapas.fy_duel2
                 X = RandomNumber(42, 63)
                 Y = RandomNumber(45, 66)
            Case eMapas.fy_duel3
                 X = RandomNumber(44, 54)
                 Y = RandomNumber(63, 71)
            Case eMapas.fy_dust
                 X = RandomNumber(10, 20)
                 Y = RandomNumber(47, 55)
            Case eMapas.fy_fuerte
                 X = RandomNumber(40, 57)
                 Y = RandomNumber(40, 60)
            Case eMapas.fy_iceword
                 If RandomNumber(1, 2) = 1 Then
                    X = RandomNumber(27, 70)
                    Y = RandomNumber(18, 24)
                 Else
                    X = RandomNumber(27, 70)
                    Y = RandomNumber(55, 60)
                 End If
            Case eMapas.fy_planted
                   X = RandomNumber(38, 48)
                   Y = RandomNumber(54, 58)
            Case eMapas.fy_poolday
                 If RandomNumber(1, 2) = 1 Then
                    X = RandomNumber(41, 68)
                    Y = RandomNumber(40, 44)
                 Else
                    X = RandomNumber(41, 68)
                    Y = RandomNumber(58, 62)
                 End If
                 
             Case Else
     
     End Select
     
Else 'team !

     Select Case .Pos.Map
            Case eMapas.de_cbble
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(37, 47)
                     Y = RandomNumber(77, 87)
                 Else
                     X = RandomNumber(76, 85)
                     Y = RandomNumber(77, 87)
                 End If
                 
            Case eMapas.de_conjun
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(80, 90)
                     Y = RandomNumber(47, 54)
                 Else
                     X = RandomNumber(10, 20)
                     Y = RandomNumber(47, 54)
                 End If
            Case eMapas.de_desert
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(40, 50)
                     Y = RandomNumber(50, 55)
                 Else
                     X = RandomNumber(66, 80)
                     Y = RandomNumber(51, 57)
                 End If
            Case eMapas.de_dust2
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(47, 58)
                     Y = RandomNumber(28, 31)
                 Else
                     X = RandomNumber(15, 22)
                     Y = RandomNumber(19, 28)
                 End If
            Case eMapas.de_nuke
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(76, 86)
                     Y = RandomNumber(36, 43)
                 Else
                     X = RandomNumber(17, 28)
                     Y = RandomNumber(78, 83)
                 End If
            Case eMapas.fy_bloque
                 If .bando = eBandos.ciuda Then
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(24, 28)
                        Y = RandomNumber(76, 81)
                     Else
                        X = RandomNumber(53, 57)
                        Y = RandomNumber(76, 81)
                     End If
                 Else
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(24, 28)
                        Y = RandomNumber(20, 24)
                     Else
                        X = RandomNumber(53, 57)
                        Y = RandomNumber(20, 24)
                     End If
                 End If
            Case eMapas.fy_caverna
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(43, 50)
                     Y = RandomNumber(40, 50)
                 Else
                     X = RandomNumber(43, 50)
                     Y = RandomNumber(63, 70)
                 End If
            Case eMapas.fy_cruz
                 If .bando = eBandos.ciuda Then
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(43, 56)
                        Y = RandomNumber(16, 22)
                     Else
                        X = RandomNumber(43, 56)
                        Y = RandomNumber(83, 89)
                     End If
                 Else
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(19, 23)
                        Y = RandomNumber(44, 57)
                     Else
                        X = RandomNumber(80, 84)
                        Y = RandomNumber(44, 57)
                     End If
                 End If
            Case eMapas.fy_duel
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(52, 59)
                     Y = RandomNumber(60, 67)
                 Else
                     X = RandomNumber(40, 46)
                     Y = RandomNumber(44, 50)
                 End If
            Case eMapas.fy_duel2
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(43, 50)
                     Y = RandomNumber(40, 50)
                 Else
                     X = RandomNumber(43, 50)
                     Y = RandomNumber(63, 70)
                 End If
            Case eMapas.fy_duel3
                 If .bando = eBandos.ciuda Then
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(50, 55)
                        Y = RandomNumber(29, 35)
                     Else
                        X = RandomNumber(73, 79)
                        Y = RandomNumber(53, 58)
                     End If
                 Else
                     If RandomNumber(1, 2) = 1 Then
                        X = RandomNumber(26, 30)
                        Y = RandomNumber(53, 58)
                     Else
                        X = RandomNumber(50, 55)
                        Y = RandomNumber(76, 83)
                     End If
                 End If
            Case eMapas.fy_dust
                 X = RandomNumber(10, 20)
                 Y = RandomNumber(47, 55)
            Case eMapas.fy_fuerte
                 If .bando = eBandos.ciuda Then
                     X = RandomNumber(46, 53)
                     Y = RandomNumber(25, 37)
                 Else
                     X = RandomNumber(9, 16)
                     Y = RandomNumber(25, 37)
                 End If
            Case eMapas.fy_iceword
                 If RandomNumber(1, 2) = 1 Then
                    X = RandomNumber(27, 70)
                    Y = RandomNumber(18, 24)
                 Else
                    X = RandomNumber(27, 70)
                    Y = RandomNumber(55, 60)
                 End If
            Case eMapas.fy_planted
                   X = RandomNumber(38, 48)
                   Y = RandomNumber(54, 58)
            Case eMapas.fy_poolday
                 If RandomNumber(1, 2) = 1 Then
                    X = RandomNumber(41, 68)
                    Y = RandomNumber(40, 44)
                 Else
                    X = RandomNumber(41, 68)
                    Y = RandomNumber(58, 62)
                 End If
                 
             Case Else
     
     End Select

End If

If logued > 0 Then
   .Pos.X = X
   .Pos.Y = Y
Else
   WarpUserChar UserIndex, .Pos.Map, X, Y, True, True
End If
     

End With
End Sub
