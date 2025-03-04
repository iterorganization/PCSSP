% Input bus object for Transfer function PCSSP module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'controlCmd';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_TF_inBus = Simulink.Bus;
pcssp_TF_inBus.HeaderFile = '';
pcssp_TF_inBus.Description = '';
pcssp_TF_inBus.DataScope = 'Auto';
pcssp_TF_inBus.Alignment = -1;
pcssp_TF_inBus.Elements = elems;
clear elems;
