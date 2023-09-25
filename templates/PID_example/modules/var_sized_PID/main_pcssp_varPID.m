% main build script for pcssp_varPID

clear; clc; bdclose all;
% force close all zombie sldd
Simulink.data.dictionary.closeAll('-discard')

%%
obj_varPID = pcssp_varPID_obj();

obj_varPID.init;
obj_varPID.setup;
%%
obj_varPID.build;
