


@echo off


CALL matlab -automation -r "try;cd('C:\matRad\matRad');diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');  diary('on');runtests('C:\matRad\matRad\runtests\'); disp(datestr(now));diary('off');catch;end;quit"

:loop1
tasklist /fi "imagename eq MATLAB.exe" |find ":" > nul
if errorlevel 1 goto loop1



CALL matlab -automation -r "try;cd('C:\matRad\MOxUnit-master\tests');diary(strcat('moxunit_report', date));addpath('C:\matRad\matRad');  diary('on');moxunit_runtests(); disp(datestr(now));diary('off');catch;end;quit"

:loop2
tasklist /fi "imagename eq MATLAB.exe" |find ":" > nul
if errorlevel 1 goto loop2



CALL matlab -automation -r "try;cd('C:\matRad\MOxUnit-master\tests');diary(strcat('moxunit_report', date));addpath('C:\matRad\matRad');  diary('on');moxunit_runtests(); disp(datestr(now));diary('off');catch;end;quit"

:loop3
tasklist /fi "imagename eq MATLAB.exe" |find ":" > nul
if errorlevel 1 goto loop3

CALL matlab -automation -r "try;cd('C:\matRad\matRad');diary(strcat('matRad_Unitest_report', date));addpath('C:\matRad\matRad');  diary('on');success =  moxunit_runtests(['C:' filesep 'matRad' filesep 'matRad' filesep 'unitTest' filesep 'matRad_moxunits_tests'],'-with_coverage','-cover',['C:' filesep 'matRad' filesep 'matRad' ],'-cover_xml_file','coverage.xml','-cover_html_dir','coverage_html'); disp(datestr(now));diary('off');catch;end;quit"

:loop4
tasklist /fi "imagename eq MATLAB.exe" |find ":" > nul
if errorlevel 1 goto loop1


exit
exit

pause