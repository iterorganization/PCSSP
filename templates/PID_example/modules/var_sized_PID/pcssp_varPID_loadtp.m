function TP = pcssp_varPID_loadtp()
% Setup tunable control params default values
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.

TP.enable           = true;
TP.P                = 50;
TP.I                = 3;
TP.D                = 0;

TP.FFgain           = 50;

TP.const1           = 5;
TP.const2           = 10;

end
