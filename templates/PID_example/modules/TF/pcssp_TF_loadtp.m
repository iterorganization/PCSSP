function TP = pcssp_TF_loadtp()
% Setup tunable control params default values
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.

TP.num              = 0.0001; % numerator of discrete time transfer function
TP.den              = [1 -0.9999]; % den of discrete time tf

end
