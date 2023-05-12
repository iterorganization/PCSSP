%% Main script to generate code for the KMAG PCSSP module
% T. Ravensbergen with help from G. deTommasi 2023

clear; clc; bdclose all;
% force close all zombie sldd
Simulink.data.dictionary.closeAll('-discard')

obj_KMAG = pcssp_KMAG_module_obj();

obj_KMAG.init;
obj_KMAG.setup;

%% build
obj_KMAG.build;
