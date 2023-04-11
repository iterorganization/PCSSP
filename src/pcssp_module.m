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
        
        
        function update_model_mask_params(obj,tp)
            % function to parametrize referenced models via a model mask
            
            % this function takes the tp Simulink.Parameter and grabs the fp
            % from the obj. It then creates Simulink.Parameters and sticks
            % them in the model workspace of the wrapper. If the parameters
            % are already there, the function checks whether they need
            % updating and does so accordingly.
            
            % open points: 
            % - requires model to be loaded
            % - only works for one TP/FP with one model in the wrapper
            % - Should be combined with the obj.setup to make sure the
            %   instance parameters are updated?
            % - Buses seem to be not necessary. I am not sure what changed
            
            % create empty tp if it does not exist
            if nargin < 2
                tp = Simulink.Parameter(0);
            end
            
            % grab FP structures from obj (assume there's one for now)
            fpinits = obj.fpinits;
            
            % for now assume only one FP exists
            fphandle = str2func(fpinits{1}{1});
            fp_val = fphandle(obj);
            
            % (!!) create buses TBD (!!)
            % Create bus objects.
            % businfoFP = Simulink.Bus.createObject(fp_val);
            % businfoTP = Simulink.Bus.createObject(tp_val);
            
            % write bus to sldd of wrapper here
            
            % create Simulink.Parameter objects
            fp = Simulink.Parameter(fp_val);
            % tp.DataType = ['Bus:' 'blabla'];
            % fp.DataType = ['Bus:' 'blabla'];
            
            
            % grab model WS
            hws = get_param(obj.modelname, 'modelworkspace');
            
            % only update Tp/FP params in model workspace when (1) the params are not
            % there or (2) outdated/dirty. The isequaln command is insensitive to
            % ordering within the structures
            
            
            
            if ~hws.hasVariable('tp') || ~hws.hasVariable('fp') % params absent
                

                hws.assignin('tp', tp);
                hws.assignin('fp', fp);
                
                % set params as model argument
                set_param(obj.modelname,'ParameterArgumentNames','tp,fp')
                
            elseif ~isequaln(hws.getVariable('tp').Value, tp.Value) % TP outdated
                hws.assignin('tp', tp);
                
            elseif ~isequaln(hws.getVariable('fp').Value, fp_val) % FP outdated
                hws.assignin('fp', fp);
                
            end
            
        end
        
        
        
    end
    
end