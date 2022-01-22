Attribute VB_Name = "mod_indexHechiz"
Option Explicit

'Módulo desarrollado para asignar hechizos a cada clase

Private Const MAX_SPELL_PER_CLASS As Byte = 14

Public numSpells    As Byte
Public numClass     As Byte
Public fastSpells() As dataSpell

Type dataSpell
     index As Byte
     Pos   As Byte
End Type

Public Sub loadFastSpell()

Dim Leer As clsIniManager
Dim i    As Long
Dim X    As Long

Set Leer = New clsIniManager

Call Leer.Initialize(DatPath & "Spells.ini")
numClass = val(Leer.GetValue("INIT", "numClass"))
i = 1

ReDim fastSpells(1 To numClass, 1 To MAX_SPELL_PER_CLASS) As dataSpell

Do While (i <= numClass)

    numSpells = val(Leer.GetValue("CLASE" & i, "nSpells"))
    
    For X = 1 To numSpells
        fastSpells(i, X).index = val(Leer.GetValue("CLASE" & i, "Spell" & X)) 'spell index
        fastSpells(i, X).Pos = val(Leer.GetValue("CLASE" & i, "posList" & X)) 'spell pos at list user
    Next X
    
    i = i + 1
    
Loop

Set Leer = Nothing

End Sub

Public Sub clearSpells(ByVal ui As Integer)
Dim i As Long

For i = 1 To MAXUSERHECHIZOS
With UserList(ui)

     .Stats.UserHechizos(i) = 0
     
End With
Next i

Call UpdateUserHechizos(True, ui, 0)

End Sub

Public Sub giveSpells(ByVal ui As Integer)
With UserList(ui)

If .Stats.MaxMAN > 0 Then

   Dim i As Long
   i = 1
   
   Do While (i <= MAX_SPELL_PER_CLASS)
         If fastSpells(.clase, i).index > 0 Then
            If fastSpells(.clase, i).Pos > 0 Then
               .Stats.UserHechizos(fastSpells(.clase, i).Pos) = fastSpells(.clase, i).index
               Call UpdateUserHechizos(False, ui, CByte(fastSpells(.clase, i).Pos))
            Else
                Call LogError("Posición de hechizo (slot) inválida en giveSpells")
            End If
         Else
                Call LogError("Índice de hechizo inválido en giveSpells")
         End If
         i = i + 1
   Loop

End If

End With
End Sub
