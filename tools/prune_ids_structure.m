function var_out = prune_ids_structure(var_in)
%
% ret = prune_ids_structure(structure_in)
% 
% Removes empty, and empty representing, values and structures from IDS 
% structure.
%

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.


    empty_values = {-9.0000e+40, int32(-999999999), -999999999};

%     disp('-----')
%     var_in
    if isa(var_in, 'struct')
        %
        % structure
        %
        fn = fields(var_in);
        for f_idx = 1 : length(fn)
%             disp('var_in.(fn{f_idx}):')
%             var_in.(fn{f_idx})
            
            dummy = prune_ids_structure(var_in.(fn{f_idx}));
            if (isempty(dummy))
                var_in = rmfield(var_in, fn{f_idx});
            else
                var_in.(fn{f_idx}) = dummy;
            end
        end % end for structure fields    
        
        fn = fields(var_in);
        tf = cellfun(@(c) isempty(var_in.(c)), fn);
        var_out = rmfield(var_in, fn(tf));
        if isempty(fieldnames(var_out))
            var_out = '';
        end
    elseif isa(var_in, 'char')
        %
        % char/string
        %
        var_out = var_in;
    elseif isa(var_in, 'int32') | isa(var_in, 'double')
        %
        % integer or double
        % 
        var_out = var_in;
        for e_idx = 1:length(empty_values)
            if all(var_out == empty_values{e_idx})
                var_out = '';
            end
        end
    elseif isa(var_in, 'cell')
        l = length(var_in);
        var_out = var_in;
        for c_idx=1:l
            dummy = prune_ids_structure(var_in{c_idx});
            if ~isempty(dummy)
                var_out{c_idx} = dummy;
            end
        end
    else
        error('NOT COVERED YET')
    end

    
end
