function [bus_name_list, Buses] = define_bus_from_struct(mdl,tp,bus_name,bus_name_list, Buses, varargin)
% to define buses, dont care of array struct
% varargin{1}: 1D_array option for signal dimension
% varargin{2} is char to add prefix to original bus_name,
% varargin{3} is char to add postfix to original bus_name,
% varargin{4} is option to use SCDsignal format % new 2022
% e.g. 'Bus_xxx_postfix' is used in SAMONE for instance

%%% NEED to cleanup and review create_customized_bus: maybe removed!!!
%%% init
modif_bus_name = false;
prefix         = ''; postfix = ''; array1d = false;
is_SCDsig      = false;
dim = ''; unit = ''; description = '';

%%% get input
if numel(varargin)>=1 && isequal('1D_array',varargin{1})
  array1d = true;
end

if numel(varargin)>=2 && ischar(varargin{2})
  modif_bus_name = true;
  prefix   = varargin{2};
  if numel(varargin)>=3 && ischar(varargin{3})
    postfix = varargin{3};
  end
  bus_name = [prefix bus_name postfix];
end

if numel(varargin)>=4 && islogical(varargin{4})
  is_SCDsig = varargin{4};
end

%%% main codes
if isstruct(tp)
  state_name = fieldnames(tp)';
  %%%% for each state_name:
  for i_field = 1:numel(state_name)
    fname = state_name{i_field};
    fval  = tp.(fname);
    dim{i_field} = size(fval);
    if array1d && any(dim{i_field}<2)
      dim{i_field} = max(dim{i_field});
    end
    
    if isstruct(fval)
      [bus_name_list, Buses] = define_bus_from_struct(mdl,fval,fname,bus_name_list, Buses,varargin{:}); % recursive
      if modif_bus_name; fname =  [prefix fname postfix]; end
      type{i_field} = ['Bus: ' fname];
    else
      [type{i_field},dim{i_field},bus_name_list, Buses]= ...
        get_info_per_signal(is_SCDsig,fval,dim{i_field},bus_name_list, Buses);
    end
  end
  
  %% create bus
  my_bus        = create_customized_bus(mdl,bus_name,state_name,dim,type,unit,description);
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