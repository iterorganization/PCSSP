function TP = pcssp_PID_loadtp()
% Setup tunable control params default values
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.

TP.enable           = true;
TP.P                = [50 0 0];
TP.I                = [3  0 0];
TP.D                = [0  0 0];

end
