% Bus object: SCDalgo_demo2_outBus 
%
%
% [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
% Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
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



pcssp_PID_outBus = Simulink.Bus;
pcssp_PID_outBus.HeaderFile = '';
pcssp_PID_outBus.Description = '';
pcssp_PID_outBus.DataScope = 'Auto';
pcssp_PID_outBus.Alignment = -1;
pcssp_PID_outBus.Elements = elems;
clear elems;
