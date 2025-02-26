classdef pcssp_module < SCDDSclass_algo
    % derived class for PCSSP modules using the SCDDS core framework for model
    % referencing with data dictionaries.


    properties
        description
    end
    
    
    methods
  

        function init(obj)
            % initializes this pcssp module. During initialization, the
            % following steps are performed:
            %
            % -put a SimulinkConfiguration set in the base WS that can be
            % referred to in the model slx (needs to be linked manually)
            %
            % -create a fresh new sldd
            %
            % -call the parameter and bus init fcns and stick their nominal
            % values in the freshly created sldd
            % 
            % This method should be called before obj.setup 
            %
            % syntax: obj.init
            %
            % Arguments:
            %   none

            init@SCDDSclass_algo(obj);

            SCDconf_setConf('pcssp_Simulation','configurations_container_pcssp.sldd');

        end
        
        %% Model parameterization helper functions
        function set_model_argument(obj,param,param_name)
            % sets model arguments to allow parametrization when
            % referencing this module from a top model. The parameter is
            % put in the model workspace and exposed as a mask parameter.
            % If the parameter already exists in the model WS it is updated
            % when needed
            %
            % syntax: obj.set_model_arguments(param,'tp_name')
            %
            % Arguments:
            %   param: Simulink.Parameter or struct to become model arg
            %   param_name: name of the parameter in the model WS and mask

            arguments
            obj 
            param {mustBeA(param,["Simulink.Parameter","struct"])}
            param_name char
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

                if isa(param,'Simulink.Parameter')
                    % set the storage class for the new 'model parameter
                    % argument' we just created
                    cm = coder.mapping.api.get(obj.modelname);

                    cm.setModelParameter(param_name,"StorageClass","MultiInstance");
                end

                
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

                    if isa(param,'Simulink.Parameter')
                    % set the storage class for the new 'model parameter
                    % argument' we just updated
                    cm = coder.mappings.api.get(obj.modelname);

                    cm.setModelParameter(param_name,"StorageClass","MultiInstance");
                    end
                end
                
                
            end
            
        end

        function clear_model_ws(obj,variables)
            % Clears all or a comma-separated list of variables 
            % from the model workspace of this PCSSP module
            % 
            % Syntax: obj.clear_model_ws('tp1','tp2','tp3')
            % or: obj.clear_model_ws
            %
            % Arguments:
            %   parameters: comma separated list of to-be-deleted parameters (optional)
            
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
            % Grabs all model arguments that are currently
            % defined in the model workspace of this PCSSP module. You can
            % define new model arguments using the set_model_arguments
            % method
            %
            % syntax: obj.get_model_arguments
            %
            % Parameters:
            %   none

            if ~bdIsLoaded(obj.modelname)
                load_system(obj.modelname);
            end

            names = get_param(obj.modelname,'ParameterArgumentNames');
        end

        %% RTF/codegen functions
        function build(obj,build_target)
            % generates C/C++ from a PCSSP module. The method
            % first grabs the required SimulinkConfiguration settings, sets
            % them as configurationSettings in the base WS, and then calls
            % rtwbuild. Optionally, a build target can be provided ('rtf' 
            % or 'auto'). Select auto to automatically detect an installed
            % toolchain on your machine or use 'rtf' to pick the hardcore RTF
            % settings.
            %
            % Syntax: obj.build or obj.build('rtf')
            %
            % Arguments:
            %   build_target: optional target for C code generation.
            % Current options are 'rtf' or 'auto' to automatically select
            % an installed toolchain.

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
            % Automatically generates an XML description of this
            % PCSSP module to act as RTF FunctionBlock description. This
            % XML works together with the generated code to form an RTF FB.
            % You can use the optional Bus and Simulink.Parameter
            % description field to describe your signal/parameter, which
            % then gets put as a comment in the RTF XML.
            %
            % this function uses the matlab writestruct fcn to mimick this
            % XML structure for RTF applications.
            %
            % syntax: obj.write_RTF_xml('FUN-CTRL-MAG-01');
            %
            % Arguments:
            %   functionblock_alias: Alias linking to the PCSDB

            arguments
                obj
                function_block_alias char = '';
            end

            write_RTF_xml(obj,function_block_alias);
        end


        function obj = set_module_description(obj,description_string)
            % Adds a descriptive text to the module obj property
            % obj.description, and sets it in the description of the
            % attached slx model. 
            %
            % syntax: obj = set_module_description('some piece of text');
            %
            % Arguments:
            %   description_string: char array containing the description


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