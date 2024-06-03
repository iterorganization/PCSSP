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
          % set configuration to gcc
          sourcedd = 'configurations_container_RTF.sldd';
          SCDconf_setConf('configurationSettingsRTFcpp',sourcedd);
          % build
          build@SCDDSclass_wrapper(obj); % call superclass method       
          
      end


      function compile(obj)
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
         harnessname = sprintf('%s_harness_run',obj.name);
         if ~exist(harnessname,'file')
           warning('no harness %s found, skipping test',harnessname);
           return
         else
           fprintf('running test harness %s\n',harnessname);

           % link sldd to harness model (for buses etc?)
           harnessmdl = [obj.name '_harness'];
           load_system(harnessmdl);
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
            % method of the pcssp_module class.
            
            load_system(obj.name);
            set_param([obj.name,'/',model_path],var_name,value);
            if ~Simulink.data.existsInGlobal(obj.name,value)
                % variable does not yet exist anywhere in relation to the
                % mdl
                warning('variable %s does not exist in base WS or sldd of model %s. Model may not compile',value,obj.name);
            end
            
            
        end
      
  end
  
  
end