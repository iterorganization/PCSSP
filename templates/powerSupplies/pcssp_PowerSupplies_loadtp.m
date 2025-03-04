function TP = pcssp_PowerSupplies_loadtp()
% Setup tunable control params default values
%

TP.currentLim = [0 55 200]*1e3; % Curva per il limite di tensione
TP.voltageLim = [1.2 1.05 1.05]*1e3;

TP.VS3Vup  = 1e3*2.3;
TP.VS3Vlow = -1e3*2.3;



end
