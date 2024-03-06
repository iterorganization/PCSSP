function pcssp_add_paths()
% Script to setup paths for pcssp

thispath = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(thispath,'configurations')));
addpath(genpath(fullfile(thispath,'src'  )));
addpath(genpath(fullfile(thispath,'templates')));
addpath(genpath(fullfile(thispath,'testing')));
addpath(genpath(fullfile(thispath,'tools')));

addpath(thispath);

corepath = fullfile(thispath,'scdds-core'  );
run(fullfile(corepath,'scdds_core_paths'));



end