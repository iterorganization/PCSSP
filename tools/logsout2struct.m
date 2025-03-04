function [out,tsout] = logsout2struct(logsout)
% function [out,tsout] = logsout2struct(logsout)
% out: structure with data
% tsout: structure with timeseries
%
% Convert logged data to structure

%%

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.

arguments
    logsout Simulink.SimulationData.Dataset
end

% determine smallest common time base
for iel = 1:logsout.numElements
   % seek longest common base to use for all timeseries
    ts = logsout.getElement(iel).Values;
    if ~isa(ts,'timeseries')
        warning('signal %s is not a timeseries, please log only buses',logsout.getElementNames{iel})
        continue
    end
    base_timevector = ts.Time;
    if iel == 1
      % do nothing, keep base time vector
    elseif  ts.TimeInfo.Length>0 && ts.TimeInfo.Length < numel(base_timevector)
      base_timevector = ts.Time;
    end
end 
%base_ts = timeseries(zeros(size(base_timevector)),base_timevector);

for iel = 1:logsout.numElements
    myElement = logsout.getElement(iel);
    if ~isa(myElement.Values,'timeseries')
        continue
    end
    
    if myElement.Values.TimeInfo.Length>0
    ts = resample(myElement.Values,base_timevector); % resample to common base
    name = myElement.Name;
    else
        warning('Signal %s has empty time base, skipping',name)
        continue;
    end
    
    % skip signal if name is empty or if not properly defined
    if isempty(name) 
        warning('Signal skipped, because signal name empty or not defined in Simulink')
        continue; 
    end
    if any(name=='<')
%         warning('Signal skipped, because signal name contains <>, Simulink took it probably from previous block')
        name = strrep(strrep(name, '<' , ''), '>' , '');
%         continue
    end
        
    try
    tsdata.(name) = ts;
        % store as structure
        % make sure time index always last
        if isstruct(ts)
            ts = ts.value; % if it's a DCS bus signal
        end
        if ts.IsTimeFirst % case [nt x m]
            dd=ts.Data';
        elseif numel(ts.Data)==length(ts.Data) % case [1 x 1 x nt]
            dd=squeeze(ts.Data)';
        else % case [a x b x nt];
            dd=squeeze(ts.Data);
        end
        datastruct.(name) = dd;
    catch me
    end
    
    if ~isfield(datastruct,'time')
        datastruct.time = ts.Time;
    end
end

% out
out = datastruct;
tsout = tsdata;

return
