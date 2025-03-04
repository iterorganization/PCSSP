function TP = pcssp_varPID_loadtp()
% Setup tunable control params default values
%
%

TP.enable           = true;
TP.P                = 50;
TP.I                = 3;
TP.D                = 0;

TP.FFgain           = 50;

TP.const1           = 5;
TP.const2           = 10;

end
