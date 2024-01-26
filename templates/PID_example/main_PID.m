%% Main simulation script for model referenced PCSSP with data dicts
% T. Ravensbergen March 2023
% To run this example, first run pcssp_add_paths in the root directory of
% the repository

clear; clc; bdclose all;

% force close all zombie sldd
% sldds are completely empty containers and filled with parameters from scratch
Simulink.data.dictionary.closeAll('-discard')



[topm,obj_PID,obj_TF,obj_sensor,sensor_wrapper] = pcssp_closed_loop_obj();

%% Initialize 

topm.init;
topm.setup;

%% Parametrize the PID module: 
% define a new model WS parameter 'tp' mirroring the one in the obj_PID
% definition:
% obj_PID.set_model_argument(pcssp_PID_tp,'tp');

% the model should use this 'tp' value in all its blocks.

% the following step dirties the top model, so use sparingly. This writes
% the value 'pcssp_PID_tp' to the mask parameter 'tp' in the model 'PID'.

% Effectively, the parameter value 'pcssp_PID_tp' is injected into the
% referenced model, in which it locally is known/used as 'tp'

% topm.set_model_argument_value('PID','tp','pcssp_PID_tp');


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

%% close the model

topm.close_all(0); % 0 to close without saving, 1 to save the model
