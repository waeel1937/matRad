

addpath(genpath('C:\matRad'));
%first exsample 1 : 
profile on;

% restoredefaultpath();

runxunit(['C:' filesep 'matRad' filesep 'matRad' filesep 'unitTest' filesep 'matRad_xunits_tests']);
    
  
mocov('-cover',['C:' filesep 'matRad' filesep 'matRad' filesep 'unitTest' filesep 'matRad_xunits_tests'],...
        '-profile_info',... 
        '-cover_xml_file','coverage.xml',...
        '-cover_html_dir','coverage_html');

