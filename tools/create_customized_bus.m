function MyBus = create_customized_bus(mdl,bus_name,state_name,dimension,datatype, varargin)
% Create bus and add to model mdl
unit_in = ''; description_in = '';
if ~isempty(varargin)
  if numel(varargin)==1
    unit_in = varargin{1};
  elseif numel(varargin)==2
    [unit_in, description_in] = deal(varargin{:});
  end
end

% init
clear elems
elems = [];
MyBus = Simulink.Bus;
unit  = '';
description = '';
for ii = 1:numel(state_name)
  if ~isempty(datatype) && ~isempty(datatype{ii})
    type_ii =  datatype{ii};
  else
    type_ii =  'single'; % default type for numeric signals
  end  
  
  if ~isempty(unit_in) && numel(unit_in)>=ii
    unit = unit_in{ii};
  end
  if ~isempty(description_in) && numel(description_in)>=ii
    description = description_in{ii};
  end
  
  elems = addelemsignal(elems,[],type_ii,dimension{ii}, state_name{ii},unit,description);
end

MyBus.Elements = elems;
if ischar(mdl) && ~isempty(mdl)
  Simulink.data.assigninGlobal(mdl, bus_name, MyBus);
end
end

%% BUs elements adding functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [elemsout] = addelemsignal(elemsin, index, type, dimensions, name, units, description)
% use this function for both name only and name with index

index_loop = index;
if isempty(index)
  index_loop = 1;
end

for ii=1:numel(index_loop)
  
  elem(ii) = Simulink.BusElement;
  
  if  isempty(index)
    str1 = name;
    str2 = description;
  else
    str1=sprintf(name, index_loop(ii));
    str2=sprintf(description, index_loop(ii));
  end
  
  elem(ii).Name = str1;
  elem(ii).Description = str2;
  elem(ii).Dimensions = dimensions;
  elem(ii).DimensionsMode = 'Fixed';
  elem(ii).DataType = type;
  elem(ii).SampleTime = -1;
  elem(ii).Complexity = 'real';
  elem(ii).DocUnits = units;
end
elemsout=[elemsin elem];

end