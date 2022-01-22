Attribute VB_Name = "mod_ban"
Option Explicit

Public banning             As tlstBan
Private Const MAX_TIME_BAN As Byte = 25

Type tlstBan
     vote      As Byte
     lastCount As Byte
     count     As Byte
     index     As Integer
     IP        As String
End Type

Public Sub makeListBan(ByVal UserIndex As Integer, ByVal name As String)
Dim other As Integer
    other = NameIndex(name)


    If banning.count > 1 Then
       Call WriteConsoleMsg(UserIndex, "Ya hay una votación en curso", FontTypeNames.FONTTYPE_INFO)
ElseIf other < 1 Then
       Call WriteConsoleMsg(UserIndex, "User offline", FontTypeNames.FONTTYPE_INFO)
ElseIf other = UserIndex Then
       Call WriteConsoleMsg(UserIndex, "No puedes sancionarte a tí mismo", FontTypeNames.FONTTYPE_INFO)
ElseIf UserList(other).flags.Privilegios > PlayerType.User Then
       Call WriteConsoleMsg(other, "" & UserList(UserIndex).name & " quiso banearte =P", FontTypeNames.FONTTYPE_INFO)
       Call WriteConsoleMsg(UserIndex, "No puedes banearlo. El servidor le avisó que quisiste banearlo, je.", FontTypeNames.FONTTYPE_INFO)
Else

       banning.count = MAX_TIME_BAN
       banning.index = other
       banning.lastCount = 0
       banning.IP = UserList(other).IP
       
       Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("¿Quieres banear a " & LCase$(UserList(other).name) & "?, tipea /KICK si así lo deseas.", FontTypeNames.FONTTYPE_TALK))

End If
End Sub

Public Sub refreshListBan()
If banning.count > 0 Then
 
   banning.count = banning.count - 1

   Select Case banning.count

          Case 5
               Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("¿Quieres banear a " & LCase$(UserList(banning.index).name) & "?, tipea /KICK.", FontTypeNames.FONTTYPE_TALK))
       
          Case 2
               Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("¿Quieres banear a " & LCase$(UserList(banning.index).name) & "?, tipea /KICK.", FontTypeNames.FONTTYPE_TALK))
   
          Case 0
               Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("El usuario NO ha sido baneado.", FontTypeNames.FONTTYPE_TALK))

    End Select


End If

End Sub

Public Sub voteBan(ByVal UserIndex As Integer)
If banning.count > 0 Then
   banning.vote = banning.vote + 1

   If banning.vote >= CInt(NumUsers * 0.6) Then
      If banning.index > 0 Then
      
         Call BanIpAgrega(banning.IP)
         If NameIndex(UserList(banning.index).name) > 0 Then Call CloseSocket(banning.index)
         
         Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> La IP del personaje " & LCase$(UserList(banning.index).name) & " ha sido bloqueada.", FontTypeNames.FONTTYPE_TALK))
         
         banning.count = 0
         banning.index = 0
         banning.lastCount = 0
         banning.vote = 0
         
      End If
   End If

End If
End Sub
