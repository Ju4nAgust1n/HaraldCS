Attribute VB_Name = "readMapInfo"
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
Public mapLoad               As Integer

Public Sub cargarLista()

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
