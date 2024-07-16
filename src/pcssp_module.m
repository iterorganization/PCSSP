classdef pcssp_module < SCDDSclass_algo
    % derived class for PCSSP modules using the SCDDS core framework for model
    % referencing with data dictionaries.


    properties
        description
    end
    
    
    methods


        %% SLDD helper functions
        function fpstruct = get_nominal_fp_value(obj,param_name)
            % function to grab fixed params from the sldd. If no param_name
            % is provided all fp's are grabbed
            %% Syntax
            % fpstruct = get_nominal_fp_value('pcssp_fp_name');    
            %% inputs
            % param_name (optional) name of param to be grabbed

            
            arguments
            obj 
            param_name string = '';
            end


            % open the main sldd and grab fixed parameters
            dictionaryObj = Simulink.data.dictionary.open(obj.getdatadictionary);
            designDataObj = getSection(dictionaryObj, 'Design Data');

            if ~(param_name=="") && designDataObj.exist(param_name)
                fpstruct = designDataObj.getEntry(param_name).getValue;

            elseif ~(param_name=="") && ~designDataObj.exist(param_name)
                error('sldd %s does not have parameter %s',obj.datadictionary,param_name);

            elseif (param_name=="")
                % loop over all params
                for ii=1:numel(obj.fpinits) % loop over all FP inits
                        
                    % append structure

                    name = designDataObj.getEntry(obj.fpinits{ii}{2}{1}).Name;
                    fpstruct.(name) = designDataObj.getEntry(obj.fpinits{ii}{2}{1}).getValue;                   
                end

            else
                error("unrecognized input");
            end
        end
        
        
        
        %% Model parameterization helper functions
        function set_model_argument(obj,param,param_name)
            % function to set model arguments to allow parametrization when
            % referencing this module from a top model. The parameter is
            % put in the model workspace and exposed as a mask parameter.
            % If the parameter already exists in the model WS it is updated
            % when needed
            %% Syntax
            % set_model_argument(param,param_name_in_mask)   
            %% inputs
            % param Simulink.Parameter or struct to become model arg
            % param_name name of the parameter in the model WS and mask

            arguments
            obj 
            param {mustBeA(param,["Simulink.Parameter","struct"])}
            param_name string
            end

            if ~bdIsLoaded(obj.modelname)
                load_system(obj.modelname);
            end
            
            
            % grab model WS
            hws = get_param(obj.modelname, 'modelworkspace');
            
            % grab current model argument names
            model_arg_names = obj.get_model_arguments;
            
            % append string for set_param command later
            if ~isempty(model_arg_names)
                model_arg_string = [model_arg_names,',', param_name];
            else
                model_arg_string = param_name;
            end
              
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
                set_param(obj.modelname,'ParameterArgumentNames',model_arg_string);
                
            elseif hws.hasVariable(param_name) % model WS has a var with the same name
                param_MWS = hws.getVariable(param_name); % param in model WS
                
                assert(strcmpi(class(param_MWS),class(param)),...
                    'class clash of variables in function input vs model WS: model WS has %s whereas input has %s',class(param_MWS),class(param));
                
                if isa(param_MWS,'struct')
                    paramMWS_value = param_MWS;
                    param_value = param;
                elseif isa(param_MWS,'Simulink.Parameter')
                    paramMWS_value = param_MWS.Value;
                    param_value = param.Value;
                else
                    error('parameter %s is not a struct or Simulink.Parameter',param_name)
                    
                end
                
                % update param_MWS with the new param value
                if isequaln(paramMWS_value,param_value)
                        fprintf('variable %s is already up to date, skipping\n',param_name);
                        return
                else
                    hws.assignin(param_name, param);
                    
                    % set param as model argument
                    set_param(obj.modelname,'ParameterArgumentNames',model_arg_string);
                end
                
                
            end
            
        end

        function clear_model_ws(obj,variables)
            % This method clears all or a comma-separated list of variables 
            % from the model workspace of this PCSSP module
            %% Syntax
            % obj.clear_model_ws
            % obj.clear_model_ws('tp1','tp2','tp3')
            %% Inputs
            % none or a comma separated list of to-be-deleted parameters
            
            arguments
                obj
            end
            
            arguments(Repeating)
               variables char
            end

            mdlWks = get_param(obj.modelname,'ModelWorkspace');
            if isempty(variables)
                % clear everything
                
                clear(mdlWks);

            else
                % clear only variables specified in repeating input
                % 'variables'
                for ii = 1:length(variables)
                    clear(mdlWks, variables{ii});
                end
            end

        end
        
        % helper function to grab model arguments
        function names = get_model_arguments(obj)
            % This method grabs all model arguments that are currently
            % defined in the model workspace of this PCSSP module. You can
            % define new model arguments using the set_model_arguments
            % method
            %% syntax
            % obj.get_model_arguments
            %% inputs
            % none

            if ~bdIsLoaded(obj.modelname)
                load_system(obj.modelname);
            end

            names = get_param(obj.modelname,'ParameterArgumentNames');
        end

        %% RTF/codegen functions
        function build(obj,build_target)
            % method to generate C/C++ from a PCSSP module. The method
            % first grabs the required SimulinkConfiguration settings, sets
            % them as configurationSettings in the base WS, and then calls
            % rtwbuild. Optionally, a build target can be provided ('rtf' 
            % or 'auto'). Select auto to automatically detect an installed
            % toolchain on your machine and use use the hardcore RTF
            % settings.
            %% Syntax
            % obj.build or obj.build('rtf')
            %% inputs
            % build_target optional target for C code generation. Current
            % options are 'rtf' or 'auto' to automatically select an
            % installed toolchain.
            % function 
            arguments
                obj
                build_target {mustBeMember(build_target,{'rtf','auto'})} = 'rtf';
            end

            if strcmpi(build_target,'rtf')
                % set configuration to cpp with super duper RTF constraints
                sourcedd = 'configurations_container_RTF.sldd';
                SCDconf_setConf('configurationSettingsRTFcpp',sourcedd);

            elseif strcmpi(build_target,'auto')
                % relax constraints to build on macOS or win64 toolchains
                sourcedd = 'configurations_container_pcssp.sldd';
                SCDconf_setConf('configurationSettingsAutocpp',sourcedd);
           
            else
                error('build target %s is unknown to pcssp',build_target);
            end
            
            % build
            rtwbuild(obj.modelname);
            
        end



        function write_XML(obj,function_block_alias)
            % Method to automatically generate an XML description of this
            % PCSSP module to act as RTF FunctionBlock description. This
            % XML works together with the generated code to form an RTF FB.
            % You can use the optional Bus and Simulink.Parameter
            % description field to describe your signal/parameter, which
            % then gets put as a comment in the RTF XML.
            %
            % this function uses the matlab writestruct fcn to mimick this
            % XML structure for RTF applications.
            %% syntax
            % obj.write_RTF_xml('FUN-CTRL-MAG-01');
            %% inputs
            % functionblock_alias : Alias linking to the PCSDB, for example
            % FUN-CTRL-MAG-01

            arguments
                obj
                function_block_alias char = '';
            end

            write_RTF_xml(obj,function_block_alias);
        end


        function obj = set_module_description(obj,description_string)
            % this method adds a descriptive text to the module obj property
            % obj.description, and sets it in the description of the
            % attached slx model. 
            %% syntax
            % obj = set_module_description('some piece of text');
            %% inputs
            % description_string : char array containing the description


            arguments
                obj
                description_string char = ''
            end
            
            if ~bdIsLoaded(obj.modelname)
                load_system(obj.modelname);
            end

            set_param(obj.modelname,'Description',description_string);

            obj.description = description_string;

        end




        
        
        
    end
    
end