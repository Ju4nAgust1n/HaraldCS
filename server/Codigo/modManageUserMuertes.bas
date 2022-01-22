Attribute VB_Name = "modManageUserMuertes"
Option Explicit

Private Const frag_limit As Byte = 5
Public save_frag         As Collection
Public save_death        As Collection

Public Enum eManageFrags
    eFrag = 0
    eDeath = 1
End Enum


Public Sub loadSave_Frag()
  Set save_frag = New Collection
  Set save_death = New Collection
End Sub

Public Sub addFragCollection(ByVal UI As Integer, ByVal death As Integer)
With UserList(UI)

     save_frag.Add LCase$(.Name)
     save_death.Add LCase$(UserList(death).Name)
     
     checkFragCollection

End With
End Sub

Public Sub checkFragCollection()
Dim temp As String
Dim i As Long

With save_frag

     If .count >= frag_limit Then
        
            For i = 1 To .count
                temp = temp & .Item(i) & ","
                .Remove (i)
            Next i
            
            For i = 1 To save_death.count
                temp = temp & save_death.Item(i) & ","
                save_death.Remove (i)
            Next i
        
            'Call modHandleData.writeManageMuertes(temp)
            
     End If

End With


End Sub
