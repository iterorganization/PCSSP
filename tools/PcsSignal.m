function [busNames,Buses] = PcsSignal(n_input,name_of_signal,description)
% This function returns a standarized bus definition for signals
% required by the Pulse Supervisory Controller (PSC) module to describe
% signals that contain a quality and status flag

arguments
    n_input (1,1) double
    name_of_signal (1,:) {mustBeA(name_of_signal,["string","char"])} 
    description (1,:) {mustBeA(description,["string","char"])} = "PcsSignal"
end

    busNames={};
    Buses={};    

    clear elems;
    elems(1) = Simulink.BusElement;
    elems(1).Name = name_of_signal;
    elems(1).Dimensions = n_input;
    elems(1).DimensionsMode = 'Fixed';


    elems(2) = Simulink.BusElement;
    elems(2).Name = "Quality";
    elems(2).DataType = "string";

    elems(3) = Simulink.BusElement;
    elems(3).Name = "Activity";
    elems(3).DataType = "string";




    PcsSignal = Simulink.Bus;
    PcsSignal.HeaderFile = '';
    PcsSignal.Description = description;
    PcsSignal.DataScope = 'Auto';
    PcsSignal.Alignment = -1;
    PcsSignal.Elements = elems;
    
    busNames{1} = 'PcsSignal';
    Buses{1} = PcsSignal;
    
    clear elems;
end


