@echo off
rem suppress warnings about using windows style paths.
set CYGWIN=nodosfilewarning
rem In case epics is built dynamic (i.e. dlls present in bin)
if exist "dllPath.bat" (
	call dllPath.bat
)
if exist "C:\Epics\extensions\bin\%EPICS_HOST_ARCH%\procServ.exe" (
	set PATH=!PATH!;C:\Epics\extensions\bin\%EPICS_HOST_ARCH%
	procServ --allow -n "HP-DCPS" -p pid.txt -L log.txt --logstamp -i ^D^C 2010 ..\..\bin\%EPICS_HOST_ARCH%\agilentHPE3631A.exe st.cmd
)
else (
	..\..\bin\%EPICS_HOST_ARCH%\agilentHPE3631A.exe st.cmd
)
timeout /t 5 /nobreak
