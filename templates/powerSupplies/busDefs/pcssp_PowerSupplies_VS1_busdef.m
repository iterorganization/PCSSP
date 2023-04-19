% Bus def for VS1 output bus of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'VS1';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_PS_VS1 = Simulink.Bus;
pcssp_PS_VS1.HeaderFile = '';
pcssp_PS_VS1.Description = '';
pcssp_PS_VS1.DataScope = 'Auto';
pcssp_PS_VS1.Alignment = -1;
pcssp_PS_VS1.Elements = elems;
clear elems;