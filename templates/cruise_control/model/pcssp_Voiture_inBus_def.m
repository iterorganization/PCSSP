function [busNames, Buses] = pcssp_Voiture_inBus_def()

    busNames={};
    Buses={};    

    clear elems;
    elems(1) = Simulink.BusElement;
    elems(1).Name = 'acceleration';
    elems(1).Dimensions = 1;
    elems(1).DimensionsMode = 'Fixed';
    elems(1).DataType = 'double';
    elems(1).SampleTime = -1;
    elems(1).Complexity = 'real';
    elems(1).DocUnits = 'm/s^2';

    pcssp_voiture_inBus = Simulink.Bus;
    pcssp_voiture_inBus.Description = 'input acceleration for car model';
    pcssp_voiture_inBus.DataScope = 'Auto';
    pcssp_voiture_inBus.Elements = elems;
    
    busNames{1} = 'pcssp_voiture_inBus';
    Buses{1} = pcssp_voiture_inBus;
    
end
