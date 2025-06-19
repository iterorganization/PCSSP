function TP = pcssp_Voiture_loadtp()
% Setup tunable control params default values for PCSSP car module in the
% cruise control example
%
TP.numerator        = 1;
TP.denominator      = [1e-2 1];
TP.v0               = 0;
TP.s0               = 0;

end
