function fp = pcssp_PowerSupplies_loadfp(obj)

%% Load fixed parameters for PowerSupplies module in PCSSP
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
fp.timing = obj.gettiming;

% CS/PF main converters
%config.nMConverters=[1 1 2 1 1 1 3 3 3 3 1]'; % First Plasma
fp.nMConverters = [2 2 4 2 2 2 3 3 3 3 2]'; % Basic Configuration
fp.VMCpositiveSR = 1050*fp.nMConverters/15e-3;
fp.VMCnegativeSR = -1050*fp.nMConverters/15e-3;
fp.VMCtaud = 3e-3*[1 1 1 1 1 1 1 1 1 1 1];


% VS1 power supply
fp.nVS1Converters = 6;
fp.VS1positiveSR = 1050*fp.nVS1Converters/15e-3;
fp.VS1negativeSR = -1050*fp.nVS1Converters/15e-3;
fp.VS1taud = 3e-3;

% VS3 Power Supply
fp.VS3filterNum = 1;
fp.VS3filterDen = [7.5e-3 1];
fp.VS3taud = 2.5e-3;

end