Attribute VB_Name = "modHandleData"
Option Explicit

'Public Const IP_SV_FATHER   As String = "192.168.0.102"
Public IP_SV_FATHER         As String
Public Const PORT_SV_FATHER As Integer = 7668
Public Const max_Servers    As Byte = 20

Const MIN_CARACTER_SV       As Byte = 4

Public Sub handleData(ByVal rdata As String)

Select Case Left$(UCase$(rdata), 1)
       
       Case "M"
            rdata = Right$(rdata, Len(rdata) - 1)
            Call AddtoRichTextBox(frmMain.RecTxt, "SERVER >" & rdata, 255, 255, 255, True, False)
       Exit Sub

End Select

Select Case Left$(UCase$(rdata), 3)
       
       Case "LST"
            rdata = Right$(rdata, Len(rdata) - 3)
            
            Dim i As Long, X As Long, cant As Byte
            
               cant = ReadField(1, rdata, Asc(","))
            
                For i = 0 To cant
                   lstServers(i).Name = ReadField(IIf(i <> 0, (i + 2) + X, 2), rdata, Asc(","))
                   lstServers(i).Ip = ReadField(IIf(i <> 0, (i + 3) + X, 3), rdata, Asc(","))
                   lstServers(i).port = ReadField(IIf(i <> 0, (i + 4) + X, 4), rdata, Asc(","))
                   lstServers(i).mapa = ReadField(IIf(i <> 0, (i + 5) + X, 5), rdata, Asc(","))
                   lstServers(i).online = ReadField(IIf(i <> 0, (i + 6) + X, 6), rdata, Asc(","))

                   X = X + 4
                    
                   If Len(lstServers(i).Name) > 2 Then
                      frmConnect.List1.AddItem lstServers(i).Name & " " & "(" & lstServers(i).Ip & ")" & " " & "(" & lstServers(i).port & ")" & " 'map: [" & lstServers(i).mapa & "]" & " Jugadores: " & lstServers(i).online & ""
                   Else
                      frmConnect.List1.AddItem "Slot disponible"
                   End If
                    
              Next i

       Exit Sub

End Select

End Sub

Public Sub sendDataParch(ByVal data As String)
If frmConnect.Winsock1.State = sckConnected Then
   frmConnect.Winsock1.SendData data
Else
   Call MsgBox("Se ha perdido la conección", vbCritical)
End If
End Sub

