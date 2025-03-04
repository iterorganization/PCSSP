function MyBus = create_customized_bus(mdl,bus_name,state_name,dimension,datatype,busoptions)

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.

arguments
   mdl                      char
   bus_name                 char
   state_name               cell
   dimension                cell
   datatype                 cell
   busoptions               struct
   
end


unit_cell = cell(1,numel(state_name));
description_cell = cell(1,numel(state_name));

for ii = 1:length(unit_cell)
    if numel(busoptions.unit) == 1
        unit_cell{ii} = busoptions.unit{1};      
    else
        unit_cell{ii} = busoptions.unit{ii};     
    end  
end

for ii = 1:length(description_cell)
    if numel(busoptions.description) == 1
        description_cell{ii} = busoptions.description{1};      
    else
        description_cell{ii} = busoptions.description{ii};     
    end  
end




% init
clear elems
elems = [];
MyBus = Simulink.Bus;

for ii = 1:numel(state_name)
  if ~isempty(datatype) && ~isempty(datatype{ii})
    type_ii =  datatype{ii};
  else
    type_ii =  'single'; % default type for numeric signals
  end  
  

  unit = unit_cell{ii};
  description = description_cell{ii};


  
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