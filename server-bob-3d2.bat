@echo off
bg font 1 & mode 120,80 & cls
cmdwiz showcursor 0
if defined __ goto :START
set __=.
call %0 %* | cmdgfx_gdi "" kOSf1:0,0,240,80,120,80W10
set __=
cls
bg font 6 & cmdwiz showcursor 1 & mode 80,50
goto :eof

:START
setlocal ENABLEDELAYEDEXPANSION
for /F "Tokens=1 delims==" %%v in ('set') do set "%%v="

set /a XMID=120/2, YMID=80/2-4, XMID2=120/2+120
set /a DIST=4000, ROTMODE=0, RX=0, RY=0, RZ=0, MODE=1, WAVE=0
set /a SHR=13, MOONC=0, MOONMOVE=1, MOONX=17
set ASPECT=0.66666

set "_SIN=a-a*a/1920*a/312500+a*a/1920*a/15625*a/15625*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000"
set "SINE(x)=(a=(x)%%62832, c=(a>>31|1)*a, t=((c-47125)>>31)+1, a-=t*((a>>31|1)*62832)  +  ^^^!t*( (((c-15709)>>31)+1)*(-(a>>31|1)*31416+2*a)  ), %_SIN%)"
set "_SIN="
del /Q EL.dat >nul 2>nul
set EXTRA=&for /L %%a in (1,1,100) do set EXTRA=!EXTRA!xtra

:REP
for /L %%1 in (1,1,300) do if not defined STOP (

  if !MOONMOVE!==1 for %%a in (!MOONC!) do set /a A1=%%a & set /a "MOONX=!XMID!+(%SINE(x):x=!A1!*31416/180/2%*35>>!SHR!), MOONC+=2"

  if !MODE!==0 echo "cmdgfx: fbox 1 0 b2 0,0,120,80 & fbox 1 0 08 120,0,120,80 & 3d objects\ball-object.obj 0,0 !RX!,!RY!,!RZ! 0,0,0 0.9,0.9,0.9,0,0,0 0,0,0,50 %XMID2%,%YMID%,!DIST!,%ASPECT% 0 0 0 & block 0 120,0,120,80 0,0 08 & block 0 0,0,120,70 0,50 0 0 0 ? ? x+0 (70-y)/2 & block 0 120,0,120,80 0,0 08 & skip %EXTRA%%EXTRA%%EXTRA%%EXTRA%%EXTRA%"
  
  if !MODE!==1 echo "cmdgfx: fbox 1 0 b2 0,0,120,80 & fbox 1 0 08 120,0,120,80 & 3d objects\ball-object.obj 0,0 !RX!,!RY!,!RZ! 0,0,0 0.9,0.9,0.9,0,0,0 0,0,0,50 %XMID2%,%YMID%,!DIST!,%ASPECT% 0 0 0 & block 0 120,0,120,80 0,0 08 & fellipse f 1 b1 !MOONX!,13,10,7 & fellipse f 7 db !MOONX!,13,9,6 & fellipse f 1 b1 !MOONX!,53,9,3 & fellipse f 0 db !MOONX!,53,8,2 & fellipse f 1 b1 !MOONX!,60,6,2 & fellipse f 0 db !MOONX!,60,5,2 & block 0 0,0,120,70 0,50 0 0 0 10b2=10b0,10b1=10b0,?c??=?4??,?a??=?2??,?f??=?7?? ? x+sin(y/2+!WAVE!/10)*6 (65-y)/0.66 & line 0 1 dc 0,50,120,50 & block 0 120,0,120,80 0,0 08 & skip %EXTRA%%EXTRA%%EXTRA%%EXTRA%%EXTRA%"

  rem try y divison by 0.75 or 0.66 or 2
	
  if exist EL.dat set /p KEY=<EL.dat & del /Q EL.dat >nul 2>nul
	
  if !KEY! == 32 set /A MODE=1-!MODE!
  if !KEY! == 112 cmdwiz getch
  if !KEY! == 100 set /A DIST+=100
  if !KEY! == 68 set /A DIST-=100
  if !KEY! == 27 set STOP=1
  if !KEY! == 109 set /A MOONMOVE=1-!MOONMOVE!
  if !KEY! == 13 set /A ROTMODE=1-!ROTMODE!&set /a RX=0,RY=0,RZ=0
  if !KEY! == 331 if !ROTMODE!==1 set /A RY+=20
  if !KEY! == 333 if !ROTMODE!==1 set /A RY-=20
  if !KEY! == 328 if !ROTMODE!==1 set /A RX+=20
  if !KEY! == 336 if !ROTMODE!==1 set /A RX-=20
  if !KEY! == 122 if !ROTMODE!==1 set /A RZ+=20
  if !KEY! == 90 if !ROTMODE!==1 set /A RZ-=20
  if !ROTMODE! == 0 set /a RY-=7, RX+=5, RZ+=2
  set /a WAVE+=1, KEY=0
)
if not defined STOP goto REP

endlocal
echo "cmdgfx: quit"
