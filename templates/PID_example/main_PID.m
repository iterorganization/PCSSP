%% Main simulation script for model referenced PCSSP with data dicts
% T. Ravensbergen March 2023
% To run this example, first run pcssp_add_paths in the root directory of
% the repository

clear; clc; bdclose all;

% force close all zombie sldd
% sldds are completely empty containers and filled with parameters from scratch
Simulink.data.dictionary.closeAll('-discard')


%% configure top model
topm = pcssp_top_class('closed_loop');


%% initialize PCSSP modules
obj_PID = pcssp_PID_obj(3); % input is the size of the inBus
obj_TF = pcssp_TF_obj();

%% initialize PCSSP wrappers

wrapper_PID = pcssp_wrapper('pid_wrapper');
wrapper_PID.timing.dt = obj_PID.gettiming.dt;
wrapper_PID = wrapper_PID.addalgo(obj_PID);

%% add modules and wrappers to top model and call init/setup

topm = topm.addwrapper(wrapper_PID);
topm = topm.addmodule(obj_TF);

topm.init;
topm.setup;


%% Simulate top model
out = topm.sim;

simout = logsout2struct(out.logsout);

%% plot outputs
h = tiledlayout(3,1,'TileSpacing','compact','Padding','compact');

h1 = nexttile;
plot(h1,simout.time,simout.yMeas,simout.time,simout.r);
legend(h1,'system output','reference')

h2 = nexttile;

plot(h2,simout.time,simout.e);
legend(h2,'erreur')

h3 = nexttile;
plot(h3,simout.time,simout.controlCmd);
legend(h3,'controller command');

h.XLabel.String = 't (s)';
