% Bus def for CSPF current measurements of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'CSPF_curr_meas';
elems(1).Dimensions = 11;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_PS_CSPF_curr_meas = Simulink.Bus;
pcssp_PS_CSPF_curr_meas.HeaderFile = '';
pcssp_PS_CSPF_curr_meas.Description = '';
pcssp_PS_CSPF_curr_meas.DataScope = 'Auto';
pcssp_PS_CSPF_curr_meas.Alignment = -1;
pcssp_PS_CSPF_curr_meas.Elements = elems;
clear elems;