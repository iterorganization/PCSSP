function [bus_name_list, Buses] = define_bus_from_struct(mdl,tp,bus_name,...
    bus_name_list, Buses, options,busoptions)
% function to define a bus from a structure tp. The structure may be nested
% in which case child buses are automatically created.

% inputs:
% - mdl                 model name
% - tp                  structured parameter. Can be nested
% - bus_name            desired name of bus (string)
% - bus_name_list       cell array of existing buses
% - Buses               cell array of existing bus objects
% - options             name-value options (see below)
%   busoptions          name-value options for bus fields (see below)

% optional arguments:
% ...,'array1d',false,'prefix','some_string','postfix','some_string','is_SCDsig',false);

% optional arguments for bus fields:
% ...,'unit','m2','description','velocity of car');

arguments
   mdl                      char
   tp                       struct
   bus_name                 char
   bus_name_list            cell
   Buses                    cell
   options.array1d          logical = false; 
   options.prefix           char = '';
   options.postfix          char = '';
   options.is_SCDsig        logical = false;
   busoptions.unit          cell = {''};
   busoptions.description   cell = {''};
end

bus_name = [options.prefix, bus_name, options.postfix];
dim = '';


%%% main codes
if isstruct(tp)
  state_name = fieldnames(tp)';
  %%%% for each state_name:
  for i_field = 1:numel(state_name)
    fname = state_name{i_field};
    fval  = tp.(fname);
    dim{i_field} = size(fval);
    if options.array1d && any(dim{i_field}<2)
      dim{i_field} = max(dim{i_field});
    end
    
    if isstruct(fval)
      [bus_name_list, Buses] = define_bus_from_struct(mdl,fval,fname,bus_name_list, Buses,...
            'prefix',options.prefix,'postfix',options.postfix,'array1d',options.array1d); % recursive

      fname =  [options.prefix, fname, options.postfix];
      type{i_field} = ['Bus: ' fname];
    else
      [type{i_field},dim{i_field},bus_name_list, Buses]= ...
        get_info_per_signal(options.is_SCDsig,fval,dim{i_field},bus_name_list, Buses);
    end
  end
  
  %% create bus
  my_bus        = create_customized_bus(mdl,bus_name,state_name,dim,type,busoptions);
  bus_name_list = [bus_name_list bus_name];
  Buses         = [Buses {my_bus}];
end

function [type,dim,bus_name_list, Buses]= get_info_per_signal(is_SCDsig,fval,dim,bus_name_list, Buses)
% allowed_classes = {'single','logical','int32','int8'}; 
if is_SCDsig  % running in rtccode
  [type,bus_name_list, Buses]  = create_bus_for_individual_signal(fval,bus_name_list, Buses);
  dim = 1;
else % stand-alone mode
  if isnumeric(fval)
    if isequal(class(fval),'double')
      type = 'single'; % convert all double to single
    else
       type = class(fval);
    end
  elseif islogical(fval)
    type = 'boolean';
  else
    error('support only numeric structure for simulink')
  end
end