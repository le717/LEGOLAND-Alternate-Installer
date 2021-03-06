﻿;  LEGO® LEGOLAND Alternate Installer
;  Created 2013-2014 Triangle717
;  <http://Triangle717.WordPress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5, 5, 2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define InstallerName "LEGO® LEGOLAND Alternate Installer"
#define InstallerVersion "1.0.1"
#define AppName "LEGO® LEGOLAND"
#define AppNameNoR "LEGO LEGOLAND"
#define AppVersion "0.2.2.9"
#define AppPublisher "LEGO Media"
#define AppExeName "legoland.exe"

[Setup]
AppID={#InstallerName}{#InstallerVersion}
AppName={#AppName}
AppVersion={#AppVersion}
VersionInfoVersion={#InstallerVersion}
AppPublisher={#AppPublisher}
AppCopyright=(C) 1999 {#AppPublisher}
LicenseFile=Info\license.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={pf}\LEGO Media\Games\LEGOLAND
DefaultGroupName=LEGO Media\{#AppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Icon.ico
WizardImageFile=Sidebar.bmp
WizardSmallImageFile=Small-Image.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=bin
OutputBaseFilename={#AppNameNoR} Alternate Installer {#InstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Icon.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#AppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=232783872
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finish.
PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#InstallerName} {#InstallerVersion}
; WelcomeLabel2 is overridden because I'm unsure if every LEGO LEGOLAND disc
; says version 0.2.2.9 or just mine.
WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
DiskSpaceMBLabel=At least 222 MB of free disk space is required.

;; Both Types and Components sections are required to create the installation options.
;; TODO: If I want to remake the original installation options, then I'll have to make another release
;; [Types]
;; Name: "Full"; Description: "Full Installation (With Movies)"
;; Name: "Minimal"; Description: "Minimal Installation (Without Movies)"

;; [Components]
;; Name: "Full"; Description: "Full Installation (With Movies)"; Types: Full
;; Name: "Minimal"; Description: "Minimal Installation (Without Movies)"; Types: Minimal

[Files]
; Grab main.z
Source: "{code:GetSourceDrive}main.z"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist

; Resource archives
Source: "{code:GetSourceDrive}Graphics1.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:GetSourceDrive}Graphics2.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:GetSourceDrive}Legoland.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist

; Uncompressed files
Source: "{code:GetSourceDrive}Speech\*"; DestDir: "{app}\Speech"; Flags: external ignoreversion skipifsourcedoesntexist

; Funclub alternate release
Source: "{code:GetSourceDrive}TODO\main.z"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist
Source: "{code:GetSourceDrive}TODO\Graphics1.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:GetSourceDrive}TODO\Graphics2.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:GetSourceDrive}TODO\Legoland.res"; DestDir: "{app}\Volumes"; Flags: external ignoreversion skipifsourcedoesntexist
Source: "{code:GetSourceDrive}TODO\Speech\*"; DestDir: "{app}\Speech"; Flags: external ignoreversion skipifsourcedoesntexist

; Manual, icon and readme
Source: "Info\LL_Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist
Source: "Info\license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Icon.ico"; DestDir: "{app}"; Flags: ignoreversion

; Tool needed to extract the CAB
Source: "Tools\CABExtract\i3comp.exe"; DestDir: "{app}"; Flags: deleteafterinstall
; Delete Uninst.dll from extracted main.z
Source: "Tools\DLLDel.bat"; DestDir: "{app}"; Flags: deleteafterinstall

[Icons]
; Desktop and Start menu/screen icons
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; IconFilename: "{app}\Icon.ico"; Comment: "Play LEGOLAND"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Icon.ico"; Comment: "Uninstall LEGOLAND"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; IconFilename: "{app}\Icon.ico"; Comment: "Play LEGOLAND"; Tasks: desktopicon

[Tasks]
; Create Desktop icon, Run As Admin registry string
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#AppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Registry]
; Registry strings are always hard-coded (!No ISPP functions!)
; to ensure everything works properly.
; Run as Administrator string
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\legoland.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin

; Required game strings
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND\1.00"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND\1.00"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGOLAND.exe"; ValueType: String; ValueName: ; ValueData: "{app}\LEGOLAND.EXE"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGOLAND.exe"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue

[Run]
; From to to bottom: extract the CAB, delete unused DLL, run game
Filename: "{app}\i3comp.exe"; Parameters: """{app}\main.z"" ""{app}\*.*"" -d -i"; Flags: runascurrentuser
Filename: "{app}\DLLDel.bat"; Flags: runascurrentuser
Filename: "{app}\{#AppExeName}"; Flags: nowait postinstall skipifsilent runascurrentuser; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"

[UninstallDelete]
; Because the files came from a CAB were not installed from [Files],
; this is needed to delete them.
Type: files; Name: "{app}\{#AppExeName}"
Type: files; Name: "{app}\EGC.BMP"
Type: files; Name: "{app}\DeIsL1.isu"
Type: files; Name: "{app}\Lego.TTF"
Type: files; Name: "{app}\Legoland.icm"
Type: files; Name: "{app}\*.avi"
Type: filesandordirs; Name: "{app}\IMusic"
Type: filesandordirs; Name: "{app}\RollerCoaster"
Type: filesandordirs; Name: "{app}\Speech"
Type: filesandordirs; Name: "{app}\strings"
Type: filesandordirs; Name: "{app}\Volumes"
Type: filesandordirs; Name: "{app}\zbuffers"

[Dirs]
; Created to ensure the save games are not removed
; (which should never ever happen).
Name: "{app}\profiles"; Flags: uninsneveruninstall

[Code]
// Pascal script from Bgbennyboy to pull files off a CD,
// greatly trimmed up and modified to support ANSI and Unicode Inno Setup
// by Triangle717.
var
  SourceDrive: string;

#include "FindDisc.pas"

function GetSourceDrive(Param: String): String;
begin
  Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
  SourceDrive:=GetSourceCdDrive();
end;
