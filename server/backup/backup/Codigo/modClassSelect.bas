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

Public Sub selectClass(ByVal UserIndex As Integer, ByVal value As Byte, ByVal userRaza As Byte)
With UserList(UserIndex)

Dim i As Long

    If userRaza < 1 Or userRaza > 5 Then
       Else
       .Stats.UserAtributos(eAtributos.Fuerza) = 36
       .Stats.UserAtributos(eAtributos.Agilidad) = 36
       .Stats.UserAtributos(eAtributos.Inteligencia) = 18
       .Stats.UserAtributos(eAtributos.Carisma) = 18
       .Stats.UserAtributos(eAtributos.Constitucion) = 18
    End If
    
    .Genero = RandomNumber(1, 2)

Select Case value

       Case eClass.Mage '1
            .clase = value
            .raza = Elfo
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(101, 105)
                   Case Else
                        .Char.Head = RandomNumber(170, 173)
            End Select
            
            .Stats.MaxHp = (RandomNumber(6.8, 7.1) * STAT_MAXELV)
            .Stats.MinHp = .Stats.MaxHp
            
            .Stats.MaxMAN = 2530
            .Stats.MinMAN = .Stats.MaxMAN
            
            .Stats.ELV = STAT_MAXELV
       
       Case eClass.Cleric '2
            .clase = value
            .raza = Humano
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(1, 11)
                   Case Else
                        .Char.Head = RandomNumber(70, 73)
            End Select
            
            .Stats.MaxHp = RandomNumber(8, 8.2) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
            
            .Stats.MaxMAN = 980
            .Stats.MaxMAN = 980
       
       Case eClass.Warrior '3
            .clase = value
            .raza = Enano
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(301, 304)
                   Case Else
                        .Char.Head = RandomNumber(370, 373)
            End Select
            
            .Stats.MaxMAN = 0
            .Stats.MinMAN = 0
            
            .Stats.MaxHp = RandomNumber(10.5, 11) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case eClass.Assasin '4
            .clase = value
            .raza = Drow
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(202, 205)
                   Case Else
                        .Char.Head = RandomNumber(208, 210)
            End Select
            
            .Stats.MaxMAN = 1200
            .Stats.MinMAN = .Stats.MaxMAN
            
            .Stats.MaxHp = RandomNumber(7, 7.2) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case eClass.Bard '6
            .clase = value
            .raza = Elfo
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(101, 105)
                   Case Else
                        .Char.Head = RandomNumber(170, 173)
            End Select
            
            .Stats.MaxMAN = 2156
            .Stats.MinMAN = .Stats.MaxMAN
            
            .Stats.MaxHp = RandomNumber(7.2, 7.5) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case eClass.Druid '7
            .clase = value
            .raza = Elfo
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(101, 105)
                   Case Else
                        .Char.Head = RandomNumber(170, 173)
            End Select
            
            .Stats.MaxMAN = 1948
            .Stats.MinMAN = .Stats.MaxMAN
            
            .Stats.MaxHp = RandomNumber(7, 7.2) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case eClass.Paladin '9
            .clase = value
            .raza = Humano
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(1, 11)
                   Case Else
                        .Char.Head = RandomNumber(70, 73)
            End Select
            
            .Stats.MaxMAN = 948
            .Stats.MinMAN = 948
            
            .Stats.MaxHp = RandomNumber(9, 9.5) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case eClass.Hunter '10
            .clase = value
            .raza = Enano
            
            Select Case .Genero
                   Case 1
                        .Char.Head = RandomNumber(301, 304)
                   Case Else
                        .Char.Head = RandomNumber(370, 373)
            End Select
            
            .Stats.MaxMAN = 0
            .Stats.MinMAN = 0
            
            .Stats.MaxHp = RandomNumber(9.8, 10.5) * STAT_MAXELV
            .Stats.MinHp = .Stats.MaxHp
       
       Case Else
            'no disponible

End Select

        .flags.Muerto = 0
        DarCuerpoDesnudo UserIndex
        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
        Call WriteUpdateUserStats(UserIndex)
End With
End Sub

