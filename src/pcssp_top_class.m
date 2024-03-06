classdef pcssp_top_class
    % pcssp_top_class class implements a top model class for simulink
    % models with many layers in the hierarchy. Heavily inspired by the scdds
    % 'Expcode' class.
    
    properties (Access = public)
        % Main properties
        status        (1,:)    char    % Assessment development status
        loadverbose   (1,1)    int32   % Verbosity level of the loading (currently 0 or 1)
        name(1,:)      char % top-level model name
        moduleobjlist       % list of loaded algorithm objects with configured inits
        modulenamelist      % List of loaded algorithm names
        moduleddlist        % list of data dictionaries at algorithm level
        fpinits             % list of standard inits scripts
        modules             % list of linked algorithms objects
        wrappers            % list of wrapper objects
        exportedtps         % list of tunable parameters variable to be exported
        ddname              % top model data dictionary name
        mainslxname         % Top-level SLX name
        algonameprefix char % algorithms name prefix
        ddpath              % main expcode data dictionary save path
    end
    
    methods
        function obj = pcssp_top_class(name)
            % Class constructor
            
            
            obj.name          = name;
            obj.status        = 'debug';
            obj.mainslxname   = [name '.slx'];
            obj.ddname        = [obj.name,'.sldd'];
            obj.algonameprefix = 'pcssp';
            obj.modulenamelist  = {};
            obj.moduleddlist    = {};
            obj.wrappers        = [];
            obj.modules         = [];
            obj.exportedtps   = [];
            
            mainslxpath = fileparts(which(obj.mainslxname));
            assert(~isempty(mainslxpath),'%s.slx not found?',obj.mainslxname)
            obj.ddpath   = mainslxpath;
            
        end
        
        %% top level class methods
        
        function open(obj,varargin)
            % this method opens the top-level slx model
            openslx = obj.mainslxname;
            fprintf('Opening %s\n',openslx)
            open_system(openslx);
        end
        
        function setup(obj)
            % This method sets up the top-level Simulink model
            % to simulate this assessment model. It creates an sldd and
            % calls the setups for all attached modules and wrappers
            
            fprintf('Setting up top model ''%s'', configuring data dictionaries ...\n',obj.name);
            obj.createmaindd;
            
            obj.setupwrapperdd;
            obj.setupmaindd;
            
            % run setups for all modules
            for ii=1:numel(obj.moduleobjlist)
                obj.moduleobjlist{ii}.setup();
            end
            % run setups for all wrappers
            for jj=1:numel(obj.wrappers)
                obj.wrappers{jj}.wrapperobj.setup;
            end
            
            % Set configuration settings sldd
            SCDconf_setConf('pcssp_Simulation','configurations_container_pcssp.sldd');
            
        end
        
        function obj = init(obj)
            % Method to initialize the top model by calling inits of all
            % children
            
            % close all data dictionaries
            Simulink.data.dictionary.closeAll('-discard')
            
            % check if anything to be done
            if isempty(obj.moduleobjlist)
                fprintf(' no inits to run, done ***\n'); return;
            end

          % sort initobj list to respect dependencies in refdd parents
          obj = obj.sortmoduleobjlist;         
          
          % Carry out any init tasks of algorithms
          for ii=1:numel(obj.moduleobjlist)
            obj.moduleobjlist{ii}.init();
            
            opendds = Simulink.data.dictionary.getOpenDictionaryPaths;
            % check that .sldd is not opened by some algorithm init
            assert(~any(contains(opendds,obj.ddname)),...
              'init for %s leaves %s open - this should be avoided',...
              obj.moduleobjlist{ii}.getname,obj.ddname)
          end

          % init all wrappers

          for jj = 1:numel(obj.wrappers)
              obj.wrappers{jj}.wrapperobj.init();
          end


          fprintf('\n** DONE WITH ALL INITS **\n');
        end
        
        function compile(obj)
            load_system(obj.name);
            set_param(obj.name,'SimulationCommand','Update')
            
        end
        
        function simout = sim(obj)
            % set the correct Simulink Settings
            sourcedd = 'configurations_container_pcssp.sldd';
            SCDconf_setConf('pcssp_Simulation',sourcedd);

            % simulate the top-level simulink model
            simout = sim(obj.name);
        end
        
        %% adders
        % wrapper
        function obj = addwrapper(obj,wrapperObj)
            % add wrapper to top model
            assert(nargout==1,'must assign output for addwrapper method')
            
            % wrapper obj must be of SCDDS class
            assert(isa(wrapperObj,'SCDDSclass_wrapper'));
            
            for ii=1:numel(obj.wrappers)
                assert(~isequal(wrapperObj,obj.wrappers{ii}.wrapperobj),...
                    'wrapper %s is already present in top model %s',...
                    obj.wrappers{ii}.wrapperobj.name,obj.name)
            end
            
            mywrapper.wrapperobj = wrapperObj;
            
            for imodule = 1:numel(wrapperObj.algos)
                algoObj = wrapperObj.algos(imodule);
                obj = processalgorithm(obj,algoObj);
            end
            
            % add wrapper to obj
            obj.wrappers{end+1}  = mywrapper;
        end
        
        % module
        function obj = addmodule(obj,module)
            % add a pcssp module object to the top-model
            
            assert(nargout==1,'must assign output for addmodule method')
            assert(isa(module,'SCDDSclass_algo'),'algo is a %s and not an SCDDSclass_algo',class(module));
            
            obj = obj.processalgorithm(module);
        end
        
        %% setup helper functions
        
        function createmaindd(obj)
          % create main data dictionary from scratch to ensure it exists
          if any(contains(Simulink.data.dictionary.getOpenDictionaryPaths,obj.ddname))
              Simulink.data.dictionary.closeAll(obj.ddname,'-discard');
              % close if it exists and discard changes 
          end
          delete(which(obj.ddname));
          Simulink.data.dictionary.create(fullfile(obj.ddpath,obj.ddname));

          % link sldd to top-model slx
          load_system(obj.name);
          set_param(obj.name,'DataDictionary',obj.ddname);
        end
          
        function setupmaindd(obj)
          % prepare main top-level SLDD
          dd = Simulink.data.dictionary.open(obj.ddname);

          % link data dictionaries for active nodes
          for ii=1:length(obj.moduleddlist)

            mydatasource = obj.moduleddlist{ii};
            fprintf('adding data source %s to %s\n',mydatasource,obj.ddname)
            dd.addDataSource(mydatasource);
          end
          
          dd.saveChanges;

        end
        
        function setupwrapperdd(obj)
          % Set up the wrapper data dictionary links
          
            for ii=1:numel(obj.wrappers)
              wrapperObj = obj.wrappers{ii}.wrapperobj;
              % link to algorithms contained in the wrappers
              wrapperObj.linkalgodd(obj.algonameprefix);
            end
          
        end
        
        %% init helper functions
        
        function obj = sortmoduleobjlist(obj)
          % sort moduleobj list such that no moduleobj has dependency on other 
          % moduleobj that are further down the list. So running moduleobj inits 
          % in this order ensures that everything is initialized in the correct order.
          
          A = zeros(numel(obj.moduleobjlist)); % init adiadency matrix
          % This matrix element (col,row)=(j,i) will contain 1 if the 
          % algorithm in moduleobjlist(i) references a data dictionary which
          % depends on the algoritm in moduleobjlist(j).
          
          for ii=1:numel(obj.moduleobjlist)
            mymoduleobj = obj.moduleobjlist{ii};
            refddparentmodule = mymoduleobj.getrefddparentalgo;
             if isempty(refddparentmodule) || all(cellfun(@isempty,refddparentmodule))
               A(:,ii) = 0; % no dependency
             else
               % find indices of dependent modules
               for iref = 1:numel(refddparentmodule) % loop on possibly many dd modules
                 % index of this referenced parent module in moduleobjlist
                 jj = contains(obj.modulenamelist,refddparentmodule{iref}.getname);                
                 A(jj,ii) = 1;
               end
             end
          end
          % Use matlab tools to sort the graph. Could also write e.g. Kahn's
          % algorithm explicitly (see wikipedia/topological_sorting)
          D = digraph(A); % directed graph
          % topological sorting, maintaining index order where possible
          isort = toposort(D,'Order','stable'); 
          obj.moduleobjlist = obj.moduleobjlist(isort); % sort the init obj list
        end
        
        function obj = processalgorithm(obj,moduleObj)
            % Checking and importing algorithm name
            if(~ismember(moduleObj.getname,obj.modulenamelist))
                obj.modulenamelist{end+1} = moduleObj.getname;
                obj.modules{end+1}        = moduleObj;
            else
                fprintf('algorithm ''%s'' already present, skipping \n',moduleObj.getname);
                return
            end
            
            % Importing exported tunable parameters
            
            algoexptps=moduleObj.getexportedtps;
            if numel(algoexptps)>0
                for ii=1:numel(algoexptps)
                    if ~ismember(algoexptps{ii},obj.exportedtps)
                        obj.exportedtps{end+1}=algoexptps{ii};
                    else
                        fprintf('exported tunparams sctruct ''%s'' already present, ignoring',algoexptps{ii})
                    end
                end
            end
            
            % Importing algorithms data dictionary, only those with proper name
            moduledd=moduleObj.getdatadictionary;
            if(strcmp(moduledd(1:numel(obj.algonameprefix)),obj.algonameprefix))
                if(~ismember(moduledd,obj.moduleddlist))
                    obj.moduleddlist{end+1}=moduledd;
                else
                    warning('pcssp_top_class_class:addalgorithm','algorithm data dictionary ''%s'' already present, ignoring', moduledd);
                end
            else
                error('attempting to add algorithm data dictionary not starting with ''%s''', obj.algonameprefix)
            end
            
            
            % Importing inits
            [stdinitstmp,fpinitstmp]=moduleObj.getinits;
            if numel(fpinitstmp)>0
                toadd = ones(numel(fpinitstmp),1);
                for ii=1:numel(fpinitstmp)
                    if ~isempty(obj.fpinits)
                        for jj=1:numel(obj.fpinits)
                            for kk=1:numel(obj.fpinits{jj}{2})
                                if(strcmp(char(obj.fpinits{jj}{2}{kk}),fpinitstmp{ii}{2}))
                                    warning('pcssp_top_class_class:addalgorithm','An init driving the structure %s has already been added, ignoring this init',char(fpinitstmp{ii}{2}))
                                    toadd(ii)=0;
                                end
                            end
                        end
                    end
                    if toadd(ii)
                        temp=cell(10,1);
                        temp{1}=fpinitstmp{ii}{1};
                        temp{2}=fpinitstmp{ii}{2};
                        obj.fpinits{end+1}=temp;
                    end
                end
                if any(toadd) % if any inits from this algoobj were taken
                    obj.moduleobjlist{end+1}=moduleObj; %% Add the full algorithm object here, to see if it is fine
                end
            elseif(numel(stdinitstmp)>0)
                obj.moduleobjlist{end+1}=moduleObj;
            end
        end
        
        %% misc helper functions
            
        function close_all(obj,saveflag)
            arguments
                obj
                saveflag (1,1) logical % 0 to close without saving, 1 to save
            end
            
            fprintf('Closing all data dictionaries and discarding changes\n')
            Simulink.data.dictionary.closeAll('-discard');
            close_system(obj.name,saveflag,'closeReferencedModels','on');
            
        end
        
        function set_model_argument_value(obj,model_path,var_name,value)
            
            % Function to set the model argument (or model instance
            % parameters) in a referenced model. This is useful to inject
            % parameters from the top model in a parametrized model
            % reference.
            
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
        
        function print_model_arguments(obj,model_path)
            % helper function to print the model arguments associated with
            % a model reference in the top model
            load_system(obj.name);
            path_spec = [obj.name,'/',model_path];
            instSpecParams = get_param(path_spec,'InstanceParameters');
            
            fprintf('Referenced model %s has the following model instance parameters\n',path_spec);
     
 
            for ii = 1:length(instSpecParams)
                fprintf('Name: %s \t \t Value: %s\n',instSpecParams(ii).Name, instSpecParams(ii).Value);
            end
       
        end
            
        
        
    end
end

