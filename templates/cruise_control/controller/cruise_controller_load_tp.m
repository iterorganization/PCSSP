function [tp] = cruise_controller_load_tp()
%% function to define tunable parameters for the cruise controller

%% define PID parameter for PID pcssp module for velocity control

tp.Pvel = 3;
tp.Ivel  =0;
tp.Dvel = 0;

%% define Transfer function numerator and denominator for position control 
tp.pos_num = [4320 -4.2772e+03];
tp.pos_den = [1 -0.8931];

%% saturation limits
tp.pos_acc_saturation = 1000;
tp.neg_acc_saturation = -1000;

%% controller constants
tp.switch_constant    = 10; % distance between cars when to switch to pos control
tp.min_safety_distance= 5; % minimum safety distance between cars
tp.safe_time          = 2; % safe time between cars


end

