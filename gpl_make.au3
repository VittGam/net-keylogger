#cs
	GPL_Make.au3 v1.0.0.0 - Convert the GPL to AutoIt3 include file
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
$licensetext=FileRead("LICENSE.txt")
$f=FileOpen("GPL.au3",2)
FileWrite($f,"#include-once"&@CRLF&"Func GPL()"&@CRLF&"Local $licensetext"&@CRLF)
For $each In StringSplit($licensetext,@CRLF,3)
	FileWrite($f,"$licensetext=$licensetext&"""&StringReplace($each,"""","""""")&"""&@CRLF"&@CRLF)
Next
FileWrite($f,"Return $licensetext"&@CRLF&"EndFunc"&@CRLF)
FileClose($f)
