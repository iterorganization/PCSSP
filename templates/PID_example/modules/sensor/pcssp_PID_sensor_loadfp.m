function fp = pcssp_PID_sensor_loadfp(obj)

%% Load other fixed parameters
fp.timing = obj.gettiming;
fp.delay = 0.002;
end