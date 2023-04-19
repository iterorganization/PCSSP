% Bus def for VS1 volt command of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'VS1_volt_cmd';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_PS_VS1_volt_cmd = Simulink.Bus;
pcssp_PS_VS1_volt_cmd.HeaderFile = '';
pcssp_PS_VS1_volt_cmd.Description = '';
pcssp_PS_VS1_volt_cmd.DataScope = 'Auto';
pcssp_PS_VS1_volt_cmd.Alignment = -1;
pcssp_PS_VS1_volt_cmd.Elements = elems;
clear elems;