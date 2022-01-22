Attribute VB_Name = "modHandleData"
Option Explicit

Public Const IP_SV_FATHER   As String = "127.0.0.1"
Public Const PORT_SV_FATHER As Integer = 7668

Public Sub handleData(ByVal rdata As String)

Select Case Left$(UCase$(rdata), 1)
       
       Case "M"
            rdata = Right$(rdata, Len(rdata) - 1)
            MsgBox rdata
       Exit Sub

End Select

End Sub

Public Sub sendDataParch(ByVal data As String)
If frmMain.Winsock1.State = sckConnected Then
   frmMain.Winsock1.SendData data & vbCrLf
Else
   Call MsgBox("Se ha perdido la conección", vbCritical)
End If
End Sub
