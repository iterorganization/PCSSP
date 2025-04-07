function structout = logsout2struct(out)
%
% OUT2STRUCT This helper function converts the output port and logged
% simulation data to one structure with a common resampled time base for
% easy plotting and analysis
%
% Arguments:
%   out: Simulink.SimulationOutput containing logsout and yout or struct to
%   become model arg

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.



arguments
    out Simulink.SimulationOutput
end

%% loop over yout
try out.yout.numElements
    for ii = 1:out.yout.numElements

        myElem = out.yout.getElement(ii); % grab Signal data
        
        % convert timeseries object to structure
        structout_yout = Simulink.SimulationData.forEachTimeseries(@(ts)write_structout(ts),myElem.Values);

        field_nms = fieldnames(structout_yout); %grab names of signals
        
        % write each signal as a new leaf in the struct
        for kk = 1:length(field_nms)               
            try
                structout.(field_nms{kk}) = structout_yout.(field_nms{kk}).(field_nms{kk});

            catch
                structout.(field_nms{kk}) = structout_yout.(field_nms{kk});

            end
        end

    end

catch 
    warning('no yout found in SimulationOutput, continuing')

end

%% loop over logsout
try out.logsout.numElements

    for jj = 1:out.logsout.numElements

        myElem = out.logsout.getElement(jj);
        structout_logsout = Simulink.SimulationData.forEachTimeseries(@(ts)write_structout(ts),myElem.Values);

        field_nms = fieldnames(structout_logsout);

        for kk = 1:length(field_nms)

            try
                structout.(field_nms{kk}) = structout_logsout.(field_nms{kk}).(field_nms{kk});

            catch ME
                structout.(field_nms{kk}) = structout_logsout.(field_nms{kk});

            end

        end
    end

catch ME
    warning('Error detected in logsout %s. Skipping signal, continuing writing logsout. The original error was %s',myElem.Name,ME.message);

end

end

%% Helper function

function structout = write_structout(ts)


% determine signal name
name = ts.Name;
if any(name=='<')
    name = strrep(strrep(ts.Name, '<' , ''), '>' , '');

end
structout.(name).Time = ts.Time;
structout.(name).Values = ts.Data;

end




