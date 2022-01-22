Attribute VB_Name = "modClassSelect"
Option Explicit

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

Public Sub selectClass(ByVal UserIndex As Integer, ByVal value As Byte, ByVal userRaza As Byte, ByVal genero As Byte)
With UserList(UserIndex)

     If (.Stats.ELV > 1) Then
        .Stats.MaxHIT = 2
        .Stats.MinHIT = 1
        .Stats.Exp = 0
        .Stats.ELU = 300
        .Stats.ELV = 1
        .Stats.MinHp = 0
        .Stats.MaxHp = 0
        .Stats.MinMAN = 0
        .Stats.MaxMAN = 0
        Call UserDie(UserIndex)
        Call LimpiarInventario(UserIndex)
        UpdateUserInv True, UserIndex, 0
        Call clearSpells(UserIndex)
     End If

     .clase = value
     .raza = userRaza
     .genero = genero
     
     Select Case .raza
            Case eRaza.Humano
                 If .genero = eGenero.Hombre Then
                             .Char.Head = RandomNumber(1, 11)
                 Else
                             .Char.Head = RandomNumber(70, 74)
                 End If
                 
            Case eRaza.Elfo
                 If .genero = eGenero.Hombre Then
                             .Char.Head = RandomNumber(101, 105)
                 Else
                             .Char.Head = RandomNumber(171, 174)
                 End If
                 
            Case eRaza.Drow
                 If .genero = eGenero.Hombre Then
                             .Char.Head = RandomNumber(202, 204)
                 Else
                             .Char.Head = RandomNumber(207, 210)
                 End If
                 
            Case eRaza.Enano
                 If .genero = eGenero.Hombre Then
                             .Char.Head = RandomNumber(301, 305)
                 Else
                             .Char.Head = RandomNumber(370, 371)
                 End If
                 
            Case eRaza.Gnomo
                 If .genero = eGenero.Hombre Then
                             .Char.Head = RandomNumber(401, 404)
                 Else
                             .Char.Head = RandomNumber(470, 473)
                 End If
            
     End Select
     
    .Stats.UserAtributos(eAtributos.Fuerza) = 18 + ModRaza(userRaza).Fuerza
    .Stats.UserAtributos(eAtributos.Agilidad) = 18 + ModRaza(userRaza).Agilidad
    .Stats.UserAtributos(eAtributos.Inteligencia) = 18 + ModRaza(userRaza).Inteligencia
    .Stats.UserAtributos(eAtributos.Carisma) = 18 + ModRaza(userRaza).Carisma
    .Stats.UserAtributos(eAtributos.Constitucion) = 18 + ModRaza(userRaza).Constitucion
    
    Dim LoopC As Long
        For LoopC = 1 To NUMATRIBUTOS
            .Stats.UserAtributosBackUP(LoopC) = .Stats.UserAtributos(LoopC)
        Next LoopC
     
     
     .flags.Muerto = 0
     DarCuerpoDesnudo UserIndex
     .OrigChar = .Char
     .flags.SeguroResu = False
     
     Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
     
     DoEvents
     
     Call WriteUpdateUserStats(UserIndex)
     
     DoEvents
     
     Call upLevelFast(UserIndex)
     
     If Modalidad = eModalidad.Team Then definirPos UserIndex

End With
End Sub

Public Sub upLevelFast(ByVal UserIndex As Integer)
With UserList(UserIndex)

Dim aumentoHIT As Integer, AumentoMANA As Integer, AumentoHP As Integer, Promedio As Double, aux As Integer, DistVida(1 To 5) As Integer

Do While .Stats.ELV < STAT_MAXELV

         .Stats.ELV = .Stats.ELV + 1

            Promedio = ModVida(.clase) - (21 - .Stats.UserAtributos(eAtributos.Constitucion)) * 0.5
            aux = RandomNumber(0, 100)
            
            If Promedio - Int(Promedio) = 0.5 Then
                DistVida(1) = DistribucionSemienteraVida(1)
                DistVida(2) = DistVida(1) + DistribucionSemienteraVida(2)
                DistVida(3) = DistVida(2) + DistribucionSemienteraVida(3)
                DistVida(4) = DistVida(3) + DistribucionSemienteraVida(4)
                
                If aux <= DistVida(1) Then
                    AumentoHP = Promedio + 1.5
                ElseIf aux <= DistVida(2) Then
                    AumentoHP = Promedio + 0.5
                ElseIf aux <= DistVida(3) Then
                    AumentoHP = Promedio - 0.5
                Else
                    AumentoHP = Promedio - 1.5
                End If
            Else
                DistVida(1) = DistribucionEnteraVida(1)
                DistVida(2) = DistVida(1) + DistribucionEnteraVida(2)
                DistVida(3) = DistVida(2) + DistribucionEnteraVida(3)
                DistVida(4) = DistVida(3) + DistribucionEnteraVida(4)
                DistVida(5) = DistVida(4) + DistribucionEnteraVida(5)
                
                If aux <= DistVida(1) Then
                    AumentoHP = Promedio + 2
                ElseIf aux <= DistVida(2) Then
                    AumentoHP = Promedio + 1
                ElseIf aux <= DistVida(3) Then
                    AumentoHP = Promedio
                ElseIf aux <= DistVida(4) Then
                    AumentoHP = Promedio - 1
                Else
                    AumentoHP = Promedio - 2
                End If
                
            End If

            Select Case .clase
                Case eClass.Warrior
                    aumentoHIT = IIf(.Stats.ELV > 35, 2, 3)
                
                Case eClass.Hunter
                    aumentoHIT = IIf(.Stats.ELV > 35, 2, 3)
                
                Case eClass.Pirat
                    aumentoHIT = 3
                
                Case eClass.Paladin
                    aumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                    AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)
                
                Case eClass.Thief
                    aumentoHIT = 2
                
                Case eClass.Mage
                    aumentoHIT = 1
                    AumentoMANA = 2.8 * .Stats.UserAtributos(eAtributos.Inteligencia)
                
                Case eClass.Worker
                    aumentoHIT = 2
                
                Case eClass.Cleric
                    aumentoHIT = 2
                    AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                
                Case eClass.Druid
                    aumentoHIT = 2
                    AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                
                Case eClass.Assasin
                    aumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                    AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)
                
                Case eClass.Bard
                    aumentoHIT = 2
                    AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                    
                Case eClass.Bandit
                    aumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                    AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia) / 3 * 2
                
                Case Else
                    aumentoHIT = 2
            End Select
            
            .Stats.MaxHp = .Stats.MaxHp + AumentoHP
            If .Stats.MaxHp > STAT_MAXHP Then .Stats.MaxHp = STAT_MAXHP
            
            .Stats.MaxMAN = .Stats.MaxMAN + AumentoMANA
            If .Stats.MaxMAN > STAT_MAXMAN Then .Stats.MaxMAN = STAT_MAXMAN
            
            .Stats.MaxHIT = .Stats.MaxHIT + aumentoHIT
            If .Stats.ELV < 36 Then
                If .Stats.MaxHIT > STAT_MAXHIT_UNDER36 Then _
                    .Stats.MaxHIT = STAT_MAXHIT_UNDER36
            Else
                If .Stats.MaxHIT > STAT_MAXHIT_OVER36 Then _
                    .Stats.MaxHIT = STAT_MAXHIT_OVER36
            End If
            
            .Stats.MinHIT = .Stats.MinHIT + aumentoHIT
            If .Stats.ELV < 36 Then
                If .Stats.MinHIT > STAT_MAXHIT_UNDER36 Then _
                    .Stats.MinHIT = STAT_MAXHIT_UNDER36
            Else
                If .Stats.MinHIT > STAT_MAXHIT_OVER36 Then _
                    .Stats.MinHIT = STAT_MAXHIT_OVER36
            End If
            
            .Stats.MinHp = .Stats.MaxHp
            
            If .Stats.UserSkills(1) < 1 Then
               Dim i As Long
                   For i = 1 To NUMSKILLS
                       .Stats.UserSkills(i) = 100
                   Next i
            End If
            
            If .Stats.ELV >= STAT_MAXELV Then Call WriteUpdateUserStats(UserIndex)
            
Loop

            If .Invent.NroItems < 1 Then Call giveKitToUser(UserIndex)

End With

End Sub

Public Sub giveKitToUser(ByVal UserIndex As Integer)
Dim armour As Obj, weapon(0 To 1) As Obj, shield As Obj, helmet As Obj, potion(0 To 3) As Obj, arrow(0 To 1) As Obj
armour.Amount = 1: weapon(0).Amount = 1: weapon(1).Amount = 1: shield.Amount = 1: helmet.Amount = 1: potion(0).Amount = 1: potion(1).Amount = 1: potion(2).Amount = 1: potion(3).Amount = 1: arrow(0).Amount = 1: arrow(1).Amount = 1


With UserList(UserIndex)

            Select Case .clase
                Case eClass.Warrior
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 392, 390)
                     weapon(0).ObjIndex = 403
                     weapon(1).ObjIndex = 664 'arco
                     helmet.ObjIndex = 405
                     shield.ObjIndex = 130
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     arrow(0).ObjIndex = 480
                
                Case eClass.Hunter
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 392, 390)
                     weapon(0).ObjIndex = 159
                     weapon(1).ObjIndex = 665 'arco
                     helmet.ObjIndex = 405
                     shield.ObjIndex = 133
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     arrow(0).ObjIndex = 553
                
                Case eClass.Paladin
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 392, 390)
                     weapon(0).ObjIndex = 403
                     helmet.ObjIndex = 405
                     shield.ObjIndex = 130
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                
                Case eClass.Mage
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 524, 986)
                     weapon(0).ObjIndex = 659
                     helmet.ObjIndex = 662
                     potion(0).ObjIndex = 38 'rojas
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                Case eClass.Cleric
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 392, 390)
                     weapon(0).ObjIndex = 129
                     helmet.ObjIndex = 405
                     shield.ObjIndex = 130
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                Case eClass.Druid
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 525, 519)
                     weapon(0).ObjIndex = 366
                     helmet.ObjIndex = 851
                     shield.ObjIndex = 404
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                Case eClass.Assasin
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 854, 356)
                     weapon(0).ObjIndex = 367
                     helmet.ObjIndex = 405
                     shield.ObjIndex = 404
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                Case eClass.Bard
                     armour.ObjIndex = IIf(isDwarf(.raza) = True, 525, 519)
                     weapon(0).ObjIndex = 366
                     helmet.ObjIndex = 851
                     shield.ObjIndex = 404
                     potion(0).ObjIndex = 38 'rojas
                     potion(1).ObjIndex = 39 'verdes
                     potion(2).ObjIndex = 36 'amarillas
                     potion(3).ObjIndex = 37 'azules
                
                Case Else
                    
            End Select
            
            If potion(3).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, potion(3))
            If potion(0).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, potion(0))
            If potion(1).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, potion(1))
            If potion(2).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, potion(2))
            
            If armour.ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, armour)
            If weapon(0).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, weapon(0))
            If weapon(1).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, weapon(1))
            If shield.ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, shield)
            If helmet.ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, helmet)
            
            If arrow(0).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, arrow(0))
            If arrow(1).ObjIndex > 0 Then Call MeterItemEnInventario(UserIndex, arrow(1))
            
            Call giveSpells(UserIndex)

End With
End Sub

Function isDwarf(ByVal raza As eRaza) As Boolean
         If raza = eRaza.Enano Or raza = Gnomo Then
            isDwarf = True
         Else
            isDwarf = False
         End If
End Function
