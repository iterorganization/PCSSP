function [busNames, Buses] = pcssp_Voiture_outBus_def()

    busNames={};
    Buses={};    

    clear elems;
    elems(1) = Simulink.BusElement;
    elems(1).Name = 'position';
    elems(1).Dimensions = 1;
    elems(1).DimensionsMode = 'Fixed';
    elems(1).DataType = 'double';
    elems(1).SampleTime = -1;
    elems(1).Complexity = 'real';
    elems(1).DocUnits = 'm';

    elems(2) = Simulink.BusElement;
    elems(2).Name = 'velocity';
    elems(2).Dimensions = 1;
    elems(2).DimensionsMode = 'Fixed';
    elems(2).DataType = 'double';
    elems(2).SampleTime = -1;
    elems(2).Complexity = 'real';
    elems(2).DocUnits = 'm/s';
 


    pcssp_Voiture_outBus = Simulink.Bus;
    pcssp_Voiture_outBus.Elements = elems;
    
    busNames{1} = 'pcssp_Voiture_outBus';
    Buses{1} = pcssp_Voiture_outBus;
end