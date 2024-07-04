classdef pcssp_wrapper < SCDDSclass_wrapper
  % Inherited class for PCSSP wrapper definition and manipulation
  % To define a new instance: 
  % obj_wrapper = pcssp_wrapper('name',dt);
  %

  
  methods
      
      % class constructor
      function obj = pcssp_wrapper(name,dt)
          if nargin<2, dt=1e-3; end % default wrapper period
          obj@SCDDSclass_wrapper(name,dt)
          obj.createdd = true;
          
      end
  
      function build(obj)
          % Method to generate C/C++ from a PCSSP wrapper. This method
          % first grabs the required SimulinkConfiguration settings, sets
          % them as configurationSettings in the base WS, and then calls
          % rtwbuild.
          %% Syntax
          % obj.build;   
          %% Input
          % none

          % set configuration to gcc
          sourcedd = 'configurations_container_RTF.sldd';
          SCDconf_setConf('configurationSettingsRTFcpp',sourcedd);
          % build
          build@SCDDSclass_wrapper(obj); % call superclass method       
          
      end


      function compile(obj)
          % method to compile a PCSSP wrapper (equivalent to ctrl+D in the Simulink model)
          %% Syntax
          % obj.compile
          %% Inputs
          % none

         try
           eval(sprintf('%s([],[],[],''compile'')',obj.name));
         catch ME
             try
                eval(sprintf('%s([],[],[],''term'')',obj.name)); % terminate if necessary
             catch
                rethrow(ME); % rethrow error so we can see it
             end
         end
         eval(sprintf('%s([],[],[],''term'')',obj.name)); % terminate is successful
      end


      function test_harness(obj)
          % method to run the attached wrapper harness model for testing
          % purposes. Requires the existence of a m-script called
          % <module_name>_harness_run.m to set up the simulation.
          %% Syntax
          % obj.test_harness
          %% Inputs
          % none

         harnessname = sprintf('%s_harness_run',obj.name);
         if ~exist(harnessname,'file')
           warning('no harness %s found, skipping test',harnessname);
           return
         else
           fprintf('running test harness %s\n',harnessname);

           % link sldd to harness model (for buses etc?)
           harnessmdl = [obj.name '_harness'];

           if ~bdIsLoaded(harnessmdl)
               load_system(harnessmdl);
           end

           set_param(harnessmdl,'DataDictionary',obj.ddname);
           run(sprintf('%s(obj)',harnessname)); % run script with name <wrapper_name>_harness_run.m
         end
                  
      end

      function set_model_argument_value(obj,model_path,var_name,value)  
            % Function to set the model argument (or model instance
            % parameters) in a referenced model. This is useful to inject
            % parameters from the wrapper in a parametrized pcssp module     
            % before calling this function, the referenced model needs to
            % have model arguments defined. Call the set_model_argument
            % method of the pcssp_module class for this purpose
            %% Syntax
            % obj.set_model_argument_value('<top_model_name/referenced_mode_namel>','var_name','value')
            %% inputs
            % model_path : string to point to the referenced model in the
            % top model hierarchy. For example 'closed_loop_model/PID_controller'
            % var_name : name of the model argument
            % value : value of the to-be-injected model argument
            
            if ~bdIsLoaded(obj.name)
                load_system(obj.name);
            end
            
            set_param([obj.name,'/',model_path],var_name,value);
            if ~Simulink.data.existsInGlobal(obj.name,value)
                % variable does not yet exist anywhere in relation to the
                % mdl
                warning('variable %s does not exist in base WS or sldd of model %s. Model may not compile',value,obj.name);
            end
            
            
        end
      
  end
  
  
end