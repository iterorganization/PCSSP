%% Main simulation script for model referenced PCSSP with data dicts
% T. Ravensbergen March 2023
% To run this example, first run pcssp_add_paths in the root directory of
% the repository. The script to re-create this PDF is located in the
% templates/PID_example directory. You can run the m-file either as script,
% or publish as PDF by calling publish("main_PID.m","pdf")

clear; clc; bdclose all;

%%
% This example showcases the three layers of simulink models supported in
% PCSSP: three modules, a wrapper, and a top model combining these. The
% demo contains three PID controllers coupled to three transfer functions
% whose output is 'measured' by a sensor module.
% The PID module is parametrized: each instance may use dedicated values
% for the controller gains.

%%
% First we force close all zombie sldds that may still be openend in your
% Simulink session. In PCSSP, sldds are completely empty containers and
% filled with parameters from scratch

Simulink.data.dictionary.closeAll('-discard')

%%
% Next we create instances of the different PCSSP components: three PCSSP
% modules, a wrapper, and a top model. 
[topm,obj_PID,obj_TF,obj_sensor,sensor_wrapper_obj] = pcssp_closed_loop_obj();

%%
% The topm instance is using the PCSSP top model class:
topm

%% Initialize and setup the top model to define and fill all sldds
% By calling the init and setup methods of the top model, all modules and
% wrappers attached to it will be automatically initialized:
topm.init;
topm.setup;

%% PID module parameterization
% The PID module has a model mask, allowing to 'inject' a custom variable
% structure for each instance. The custom structure needs to match the
% nominally defined one in terms of data types and names. We can use the
% PCSSP methods to introspect the nominal value:
pcssp_PID_tp = obj_PID.get_nominal_param_value('pcssp_PID_tp');

%%
% For the purpose of this demo, we clear the model workspace of the PID
% module and re-define the model argument from scratch. Normally you would
% only have to do this the first time you create the model mask, or when
% the mask needs parameter changes. Please check the confluence pages for
% full instructions 

obj_PID.clear_model_ws;
obj_PID.set_model_argument(pcssp_PID_tp,'tp');
% to avoid conflicts with the nominal parameter we have to clear
% PCSSP_PID_tp from the base WS:
clear pcssp_PID_tp; 


% create a mask variable for PID2 and PID3 with gains
pcssp_PID2_tp = struct('enable',true,'P', 0,'I',0,'D',0);
pcssp_PID3_tp = struct('enable',true,'P', 0,'I',0,'D',0);

%%
% write the new variable value programatically to the masks. Note that this
% action is performed from the top model level/class:

topm.set_model_argument_value('PID2','tp','pcssp_PID2_tp');
topm.set_model_argument_value('PID3','tp','pcssp_PID3_tp');

%%
% Effectively, the parameter values 'pcssp_PIDXX_tp' are injected into the
% referenced models PID2 and PID3. Internally in the PID module they are
% known just as 'tp'. Note that these steps dirty the slx models, so use
% sparingly.

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
