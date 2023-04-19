% Bus def for VCSPF output bus of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'VCSPF';
elems(1).Dimensions = 11;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_PS_VCSPF = Simulink.Bus;
pcssp_PS_VCSPF.HeaderFile = '';
pcssp_PS_VCSPF.Description = '';
pcssp_PS_VCSPF.DataScope = 'Auto';
pcssp_PS_VCSPF.Alignment = -1;
pcssp_PS_VCSPF.Elements = elems;
clear elems;