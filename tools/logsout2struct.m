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

        % determine signal name
        prefix_name = '';
        if any(myElem.Name=='<') % it's a bus, name not unique. Add the blockPath
            % prefix_name = strrep(strrep(myElem.Name, '<' , ''), '>' , '');
            block_name = getBlock(myElem.BlockPath,1);
            block_name = strsplit(block_name,'/'); 
            prefix_name = [block_name{end}, '_'];
            prefix_name = strrep(prefix_name,' ','');
        end
        
        % convert timeseries object to structure
        structout_yout = Simulink.SimulationData.forEachTimeseries(@(ts)write_structout(ts,prefix_name),myElem.Values);

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
        
        % determine signal name
        prefix_name = '';
        if any(myElem.Name=='<') % it's a bus, name not unique. Add the blockPath
            block_name = getBlock(myElem.BlockPath,1);
            block_name = strsplit(block_name,'/'); 
            prefix_name = [block_name{end}, '_'];
            prefix_name = strrep(prefix_name,' ','_');
        end


        structout_logsout = Simulink.SimulationData.forEachTimeseries(@(ts)write_structout(ts,prefix_name),myElem.Values);

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

function structout = write_structout(ts,prefix_name)

if any(ts.Name=='<')
    ts_name = strrep(strrep(ts.Name, '<' , ''), '>' , '');

else
    ts_name = ts.Name;
    
end
write_name = [prefix_name , ts_name];

structout.(write_name).Time = ts.Time;
structout.(write_name).Values = ts.Data;

end




