classdef pcssp_module < SCDDSclass_algo
% derived class for PCSSP modules using the SCDDS core framework for model
% referencing with data dictionaries.

    
    methods
        
        function fpstruct = getfpindatadict(obj)
            % TO DO: check use of
            % Simulink.data.evalinGlobal(obj,'paramname') for this
            
            
            if(~isempty(obj.fpinits)) % only try when fixed params are defined
                for ii=1:numel(obj.fpinits) % loop over all FP inits
                    if ~strcmpi(obj.fpinits{ii}{3},'datadictionary')
                        fprintf('fixed params not in datadict, use obj.printinits to check');
                    else
                        % open the main sldd and grab fixed parameters
                        dictionaryObj = Simulink.data.dictionary.open(obj.getdatadictionary);
                        designDataObj = getSection(dictionaryObj, 'Design Data');
                        % append structure
                        fpstruct.(obj.fpinits{ii}{1}) = designDataObj.getEntry(obj.fpinits{ii}{2}{1}).getValue;
                        
                    end
                end
            end
            
        end
        
        
        function set_tp_model_mask(obj,param,param_name)
            
            arguments
                obj
                param (1,1) Simulink.Parameter
                param_name (1,:) char
            end
            
            % function to parametrize referenced models via a model mask
            
            % this function takes the Simulink.Parameter and its desired
            % mask name as input.
            % It then creates a Simulink.Bus object and sticks
            % the param in the model workspace of the wrapper. If the parameters
            % are already there, the function checks whether they need
            % updating and does so accordingly.
            
            % open points: 
            % - requires model to be loaded
            % - only works for one param with one model in the wrapper
            % - Should be combined with the obj.setup to make sure the
            %   instance parameters are updated?
            % -
            
           
            % grab model WS
            hws = get_param(obj.modelname, 'modelworkspace');
            
            % only update param in model workspace when (1) the param is not
            % there or (2) outdated/dirty. The isequaln command is insensitive to
            % ordering within the structures
            
            if ~hws.hasVariable(param_name) % params absent
                
                % Create bus objects in sldd
%                 dictionaryObj = Simulink.data.dictionary.open(obj.getdatadictionary);
                
                % seems that the bus must live in the base WS. Commented
                % out for now
%                 businfoTP = Simulink.Bus.createObject(param.Value,[],[],dictionaryObj);
%                 param.DataType = ['Bus: ' businfoTP.busName];

                hws.assignin(param_name, param);
                
                % set param as model argument
                set_param(obj.modelname,'ParameterArgumentNames',param_name)
                
            elseif ~isequaln(hws.getVariable(param_name).Value, param.Value) % TP outdated
                hws.assignin(param_name, param);
                
            else 
                fprintf('parameter %s already up-to-date in model WS. Skipping',param_name)
                
            end
            
        end
        
        
        
    end
    
end