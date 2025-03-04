function TP = pcssp_TF_loadtp()
% Setup tunable control params default values
%

TP.num              = 0.0001; % numerator of discrete time transfer function
TP.den              = [1 -0.9999]; % den of discrete time tf

end
