function [busNames, Buses] = pcssp_PID_inBus_def(n_input)

    busNames={};
    Buses={};    

    clear elems;
    elems(1) = Simulink.BusElement;
    elems(1).Name = 'error';
    elems(1).Dimensions = n_input;
    elems(1).DimensionsMode = 'Fixed';
    elems(1).DataType = 'double';
    elems(1).SampleTime = -1;
    elems(1).Complexity = 'real';
    elems(1).Min = [];
    elems(1).Max = [];
    elems(1).DocUnits = '';
    elems(1).Description = '';


    pcssp_PID_inBus = Simulink.Bus;
    pcssp_PID_inBus.HeaderFile = '';
    pcssp_PID_inBus.Description = '';
    pcssp_PID_inBus.DataScope = 'Auto';
    pcssp_PID_inBus.Alignment = -1;
    pcssp_PID_inBus.Elements = elems;
    
    busNames{1} = 'pcssp_PID_inBus';
    Buses{1} = pcssp_PID_inBus;
    
    clear elems;
end
