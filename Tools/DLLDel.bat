rem Deletes Uninst.dll from the LEGOLAND installation directory.
rem It is unused, left over from the extraction of main.z.
rem It is perfectly safe to delete.

@echo off
del /F /Q "%~p0/Uninst.dll"
exit