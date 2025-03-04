function fp = pcssp_TF_loadfp(obj)

%% Load fixed parameters for Transfer function module
%

fp.timing = obj.gettiming;
fp.z_delay = 1; % delay in samples
end