echo off


call "C:\Program Files\GNU Octave\Octave-6.2.0\octave.vbs" --no-gui --eval "diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');diary('on');runtests('C:\matRad\matRad') ;diary('off');quit"

:loopI
tasklist /FI "IMAGENAME eq octave-gui.exe" |find ":" > nul
if errorlevel 1 goto loop1


call "C:\Program Files\GNU Octave\Octave-6.2.0\octave.vbs" --no-gui --eval "diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');diary('on');runtests('C:\matRad\matRad') ;diary('off');quit"
:loopII
tasklist /FI "IMAGENAME eq octave-gui.exe" |find ":" > nul
if errorlevel 1 goto loop11


call "C:\Program Files\GNU Octave\Octave-6.2.0\octave.vbs" --no-gui --eval "diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');diary('on');runtests('C:\matRad\matRad') ;diary('off');quit"



:loopIII
tasklist /FI "IMAGENAME eq octave-gui.exe" |find ":" > nul
if errorlevel 1 goto loop111

call "C:\Program Files\GNU Octave\Octave-6.2.0\octave.vbs" --no-gui --eval "diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');diary('on');runtests('C:\matRad\matRad') ;diary('off');quit"


:loopIIII
tasklist /FI "IMAGENAME eq octave-gui.exe" |find ":" > nul
if errorlevel 1 goto loop11111
call "C:\Program Files\GNU Octave\Octave-6.2.0\octave.vbs" --no-gui --eval "diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');diary('on');runtests('C:\matRad\matRad') ;diary('off');quit"


exit 