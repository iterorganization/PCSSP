function pcssp_add_paths()
%% Script to setup paths for pcssp

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.

%% close sldd's, if any
Simulink.data.dictionary.closeAll('-discard');

thispath = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(thispath,'configurations')));
addpath(genpath(fullfile(thispath,'src'  )));
addpath(genpath(fullfile(thispath,'templates')));
addpath(genpath(fullfile(thispath,'testing')));
addpath(genpath(fullfile(thispath,'tools')));

addpath(thispath);

corepath = fullfile(thispath,'scdds-core'  );
run(fullfile(corepath,'scdds_core_paths'));

%% Set paths for generated code and cache files
% set code generation and cache file location
gencodes = fullfile(fileparts(mfilename('fullpath')),'gencodes');
if ~logical(exist(gencodes,'dir'))
    fprintf('folder %s does not exist, generating it',gencodes);
    mkdir(gencodes);
end

fprintf('setting Simulink Cache and CodeGen folders in %s\n',gencodes)
CacheFolder   = fullfile(gencodes,'CacheFolder');
CodeGenFolder = fullfile(gencodes,'CodeGenFolder');
pause(2); % keep this here because matlab is black magic

Simulink.fileGenControl('set',...
    'CacheFolder',CacheFolder,...
    'CodeGenFolder',CodeGenFolder,...
    'createdir',true, ...
    'CodeGenFolderStructure',Simulink.filegen.CodeGenFolderStructure.ModelSpecific);



end