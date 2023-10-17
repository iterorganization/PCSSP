function [busNames, Buses] = pcssp_PowerSupplies_busdef()

busNames={};
Buses={};

%% Bus def for CSPF current measurements of PowerSupplies module
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


busNames{1} = 'pcssp_PS_CSPF_curr_meas';
Buses{1} = pcssp_PS_CSPF_curr_meas;

%% Bus def for CSPF voltage commands of PowerSupplies module
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'CSPF_volt_cmd';
elems(1).Dimensions = 11;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

pcssp_PS_CSPF_volt_cmd = Simulink.Bus;
pcssp_PS_CSPF_volt_cmd.DataScope = 'Auto';
pcssp_PS_CSPF_volt_cmd.Alignment = -1;
pcssp_PS_CSPF_volt_cmd.Elements = elems;

busNames{2} = 'pcssp_PS_CSPF_volt_cmd';
Buses{2} = pcssp_PS_CSPF_volt_cmd;

clear elems;

%% Bus def for VCSPF output bus of PowerSupplies module
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

busNames{3} = 'pcssp_PS_VCSPF';
Buses{3} = pcssp_PS_VCSPF;
clear elems;

%% Bus def for VS1 output bus of PowerSupplies module
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

busNames{4} = 'pcssp_PS_VS1';
Buses{4} = pcssp_PS_VS1;
clear elems;

%% Bus def for VS1 volt command of PowerSupplies module
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

busNames{5} = 'pcssp_PS_VS1_volt_cmd';
Buses{5} = pcssp_PS_VS1_volt_cmd;
clear elems;

%% Bus def for VS3 output bus of PowerSupplies module

elems(1) = Simulink.BusElement;
elems(1).Name = 'VS3';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';

pcssp_PS_VS3 = Simulink.Bus;
pcssp_PS_VS3.HeaderFile = '';
pcssp_PS_VS3.Description = '';
pcssp_PS_VS3.DataScope = 'Auto';
pcssp_PS_VS3.Alignment = -1;
pcssp_PS_VS3.Elements = elems;

busNames{6} = 'pcssp_PS_VS3';
Buses{6} = pcssp_PS_VS3;
clear elems;


%% Bus def for VS3 volt command of PowerSupplies module
elems(1) = Simulink.BusElement;
elems(1).Name = 'VS3_volt_cmd';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';


pcssp_PS_VS3_volt_cmd = Simulink.Bus;
pcssp_PS_VS3_volt_cmd.HeaderFile = '';
pcssp_PS_VS3_volt_cmd.Description = '';
pcssp_PS_VS3_volt_cmd.DataScope = 'Auto';
pcssp_PS_VS3_volt_cmd.Alignment = -1;
pcssp_PS_VS3_volt_cmd.Elements = elems;

busNames{7} = 'pcssp_PS_VS3_volt_cmd';
Buses{7} = pcssp_PS_VS3_volt_cmd;
clear elems;




