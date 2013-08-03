;  LEGO® LEGOLAND Alternate Installer V1.0
;  Created 2013 Triangle717
;  <http://Triangle717.WordPress.com/>
;  Contains source code from Grim Fandango Setup
;  Copyright (c) 2007-2008 Bgbennyboy
;  <http://quick.mixnmojo.com/>

; If any version below the specified version is used for compiling, this error will be shown.
#if VER < EncodeVer(5,5,2)
  #error You must use Inno Setup 5.5.2 or newer to compile this script
#endif

#define MyInstallerName "LEGO® LEGOLAND Alternate Installer"
#define MyInstallerVersion "1.0"
#define MyAppName "LEGO® LEGOLAND"
#define MyAppNameNoR "LEGO LEGOLAND"
#define MyAppVersion "0.2.2.9"
#define MyAppPublisher "LEGO Media"
#define MyAppExeName "legoland.exe"

[Setup]
AppID={#MyInstallerName}{#MyInstallerVersion}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyInstallerVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=© 1999 {#MyAppPublisher}
LicenseFile=license.txt
; Start menu/screen and Desktop shortcuts
DefaultDirName={pf}\LEGO Media\Games\LEGOLAND
DefaultGroupName=LEGO Media\{#MyAppNameNoR}
AllowNoIcons=yes
; Installer Graphics
SetupIconFile=Icon.ico
WizardImageFile=Sidebar Image.bmp
WizardSmallImageFile=InnoSetup LEGO Logo.bmp
WizardImageStretch=True
WizardImageBackColor=clBlack
; Location of the compiled Exe
OutputDir=Here Lie The Exe
OutputBaseFilename=LEGOLAND Alternate Installer {#MyInstallerVersion}
; Uninstallation stuff
UninstallFilesDir={app}
UninstallDisplayIcon={app}\Icon.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#MyAppName}
; This is required so Inno can correctly report the installation size.
UninstallDisplaySize=112820029
; Compression
Compression=lzma2/ultra64
SolidCompression=True
InternalCompressLevel=ultra
LZMAUseSeparateProcess=yes
; From top to bottom:
; Explicitly set Admin rights, no other languages, do not restart upon finishing.
PrivilegesRequired=admin
ShowLanguageDialog=no
RestartIfNeededByRun=no

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
BeveledLabel={#MyInstallerName} {#MyInstallerVersion}
; WelcomeLabel2 is overridden because I'm unsure if every LEGO LEGOLAND disc says version 0.2.2.9 or just mine.
WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications before continuing.
; DiskSpaceMBLabel is overridden because it reports an incorrect installation size.
DiskSpaceMBLabel=At least 107 MB of free disk space is required.

; Both Types and Components sections are required to create the installation options.
; TODO: If I want to remake the original installation options, then I'll have to make another release
; [Types]
; Name: "Full"; Description: "Full Installation (With Movies)"  
; Name: "Minimal"; Description: "Minimal Installation (Without Movies)"

; [Components]
; Name: "Full"; Description: "Full Installation (With Movies)"; Types: Full
; Name: "Minimal"; Description: "Minimal Installation (Without Movies)"; Types: Minimal

[Files]
; Pull the game files off a standard LEGOLAND disc.          
; The deleteafterinstall flag removes the archive once the installation is complete
Source: "{code:GetSourceDrive}main.z"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist

; The Resource archives
Source: "{code:GetSourceDrive}Graphics1.res"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Graphics2.res"; DestDir: "{app}"; Flags: external ignoreversion
Source: "{code:GetSourceDrive}Legoland.res"; DestDir: "{app}"; Flags: external ignoreversion

; Uncompressed files
Source: "{code:GetSourceDrive}Speech\*"; DestDir: "{app}\Speech"; Flags: external ignoreversion

;; Pull the game files off a different disc layout.
;; Source: "{code:GetSourceDrive}Lego Racers\data1.cab"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist
;; Source: "{code:GetSourceDrive}Lego Racers\data1.hdr"; DestDir: "{app}"; Flags: external ignoreversion deleteafterinstall skipifsourcedoesntexist
;; Source: "{code:GetSourceDrive}Lego Racers\setupdir\0009\ReadMe.txt"; DestDir: "{app}"; Flags: external ignoreversion skipifsourcedoesntexist

; Manual, icon and readme
;; Source: "{code:GetSourceDrive}Manual.pdf"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist
Source: "Icon.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "Readme.txt"; DestDir: "{app}"; Flags: ignoreversion

; Tool needed to extract the CAB
Source: "Tools\CABExtract\i3comp.exe"; DestDir: "{app}"; Flags: deleteafterinstall

[Icons]
; Desktop and Start menu/screen icons
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Icon.ico"; Comment: "Play LEGOLAND"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Icon.ico"; Comment: "Uninstall LEGOLAND"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Icon.ico"; Comment: "Play LEGOLAND"; Tasks: desktopicon

[Tasks]
; Create Desktop icon, Run As Admin registry string
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "Admin"; Description: "Run {#MyAppName} with Administrator Rights"; GroupDescription: "{cm:AdditionalIcons}"

[Registry]
; Registry strings are always hard-coded (!No ISPP functions!) 
; to ensure everything works properly.
; Run as Admin string
Root: "HKCU"; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\LEGORacers.exe"; ValueData: "RUNASADMIN"; Flags: uninsdeletevalue; Tasks: Admin

; Required game strings
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND\1.00"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\LEGO Media\LEGOLAND\1.00"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGOLAND.exe"; ValueType: String; ValueName: "(Default)"; ValueData: "{app}\LEGOLAND.EXE"; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\LEGOLAND.exe"; ValueType: String; ValueName: "Path"; ValueData: "{app}"; Flags: uninsdeletevalue

[Run]
; From to to bottom: Extract the CAB, run game
Filename: "{app}\i3comp.exe"; Parameters: """{app}\main.z"" ""{app}\*.*"" -d -i"; Flags: runascurrentuser
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent runascurrentuser; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"

[UninstallDelete]
; Because the files came from a CAB were not installed from [Files], 
; this is needed to delete them.
Type: files; Name: "{app}\{#MyAppExeName}"
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

#include "FindDisc.iss"

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
	SourceDrive:=GetSourceCdDrive();
end;
