function fp = pcssp_TF_loadfp(obj)

%% Load other fixed parameters
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
fp.timing = obj.gettiming;
fp.z_delay = 1; % delay in samples
end