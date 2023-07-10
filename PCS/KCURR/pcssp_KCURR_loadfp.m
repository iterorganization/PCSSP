function fp = pcssp_KCURR_loadfp(obj)

%% Load other fixed parameters
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
fp.timing = obj.gettiming;

fp.PosCurSlewRate = [1383.4 1382.3 1061.8 1382.3 1383.4,1491.3 6679.4 1697.5 2019.1 2024.7 440.6];
fp.NegCurSlewRate =-[1383.4 1382.3 1061.8 1382.3 1383.4 1491.3 6679.4 1697.5 2019.1 2024.7 440.6];
end