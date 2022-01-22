Attribute VB_Name = "mdllUtil"
Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
 
Public Function IP_Publica() As String
Dim cTemp As String
Dim arTemp() As String
Dim url As String
Dim IP As String
IP = "c:\ip.txt"
'URL = "http://miip.es"
url = "http://www.cualesmiip.com"
'URL = "http://myip.es" 'AUN NO FUNCIONA
If dir(IP) <> "" Then Kill IP
Call URLDownloadToFile(0, url, IP, 0, 0)
If dir(IP) <> "" Then
  cTemp = CreateObject("Scripting.FileSystemObject").OpenTextFile(IP).ReadAll
  If url = "http://miip.es" Then
    If InStr(cTemp, "<h2>") > 0 Then
      arTemp = Split(Replace(cTemp, "</h2>", "<h2>"), "<h2>")
      IP_Publica = Trim(Right(arTemp(1), Len(arTemp(1)) - 9))
    End If
  ElseIf url = "http://www.cualesmiip.com" Then
    If InStr(cTemp, "Cual es mi IP Tu IP real es ") > 0 Then
      arTemp = Split(Replace(cTemp, " (", "Cual es mi IP Tu IP real es "), "Cual es mi IP Tu IP real es ")
      IP_Publica = Trim(arTemp(1))
    End If
  ElseIf url = "http://myip.es" Then
    If InStr(cTemp, "<aside>") > 0 Then
      arTemp = Split(Replace(cTemp, "</aside>", "<aside>"), "<aside>")
      IP_Publica = Trim(Right(arTemp(1), Len(arTemp(1)) - 9))
    End If
  End If
  Kill IP
End If
End Function
