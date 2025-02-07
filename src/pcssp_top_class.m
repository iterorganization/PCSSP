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
        wrappers            % list of wrapper objects       
        ddname              % top model data dictionary name
        mainslxname         % Top-level SLX name
        
    end

    properties (Access = private)
        algonameprefix char % algorithms name prefix
        ddpath              % main expcode data dictionary save path
        exportedtps         % list of tunable parameters variable to be exported
        fpinits             % list of standard inits scripts
        moduleddlist        % list of data dictionaries at algorithm level
        wrapperddlist       % list of data dictionaries at wrapper level
        directobjlist       % list of module objects that are directly 
                            % referenced in the top model (without wrapper)
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
            obj.wrapperddlist = {};
            obj.wrappers        = [];
            obj.exportedtps   = [];
            obj.directobjlist = {};
            
            mainslxpath = fileparts(which(obj.mainslxname));
            assert(~isempty(mainslxpath),'%s.slx not found?',obj.mainslxname)
            obj.ddpath   = mainslxpath;
            
        end
        
        %% top level class methods
        
        function open(obj)
            % this method physically opens the top-level slx model
            %% syntax
            % obj.open
            %% inputs
            % none
            openslx = obj.mainslxname;
            fprintf('Opening %s\n',openslx)
            open_system(openslx);
        end
        
        
        function obj = init(obj)
            % Method to initialize the top model by calling inits of all
            % children, both wrappers and modules. It sorts the referenced
            % modules to make sure they are initialized in the correct
            % order
            %% syntax
            % obj.init
            %% Inputs
            % none

            % close all data dictionaries
            Simulink.data.dictionary.closeAll('-discard')

            % check if anything to be done
            if isempty(obj.moduleobjlist)
                fprintf(' no inits to run, done ***\n'); return;
            end

            % sort initobj list to respect dependencies in refdd parents
            obj = obj.sortmoduleobjlist;

            % compile a list of all modules, both directly referenced from
            % the top model and indirectly in wrappers

            
            % init all wrappers
            for jj = 1:numel(obj.wrappers)
                obj.wrappers{jj}.wrapperobj.init();
            end

          % Carry out any init tasks of directly referenced algorithms (not
          % via wrapper)
          obj = obj.modules_to_init();
            for ii=1:numel(obj.directobjlist)
                obj.directobjlist{ii}.init();

                opendds = Simulink.data.dictionary.getOpenDictionaryPaths;
                % check that .sldd is not opened by some algorithm init
                assert(~any(contains(opendds,obj.ddname)),...
                    'init for %s leaves %s open - this should be avoided',...
                    obj.moduleobjlist{ii}.getname,obj.ddname)
            end



          fprintf('\n** DONE WITH ALL INITS **\n');
        end


        function setup(obj)
            % This method sets up the top-level Simulink model
            % to prepare simulation of the model. It creates an sldd and
            % calls the setups for all attached modules. For wrappers, it
            % only calls the bus definition scripts to prevent parameter
            % clashes.
            %% syntax
            % obj.setup
            %% inputs
            % none
            
            fprintf('Setting up top model ''%s'', configuring data dictionaries ...\n',obj.name);
            
            obj.createmaindd;
            obj.setupwrapperdd;
            obj.setupmaindd;
            

            % run setups for all wrappers
            for jj=1:numel(obj.wrappers)
                obj.wrappers{jj}.wrapperobj.setup;
            end

            % run setups for directly referenced modules
            obj = obj.modules_to_init();

            for ii=1:numel(obj.directobjlist)
                obj.directobjlist{ii}.setup();
            end
            
            % Set configuration settings sldd
            SCDconf_setConf('pcssp_Simulation','configurations_container_pcssp.sldd','configurationSettingsTop');
            
        end
        
        function compile(obj)
            % method to compile the top model attached to this class
            % (equivalent to ctrl+D in Simulink)
            %% Syntax
            % obj.compile
            %% inputs
            % none

            if ~bdIsLoaded(obj.name)
                load_system(obj.name);
            end
            set_param(obj.name,'SimulationCommand','Update')
            
        end
        
        function simout = sim(obj)
            % method to simulate the top model
            %% syntax
            % obj.sim
            %% inputs
            % none

            % set the correct Simulink Settings
            sourcedd = 'configurations_container_pcssp.sldd';
            SCDconf_setConf('pcssp_Simulation',sourcedd);

            % simulate the top-level simulink model
            simout = sim(obj.name);
        end
        
        %% adders
        % wrapper
        function obj = addwrapper(obj,wrapperObj)
            % method to add a wrapper instance to the top model
            % add wrapper to top model. This wrapper must be an instance of
            % the pcssp wrapper class
            %% Syntax
            % topm_obj = topm_obj.addwrapper(wrapper_obj)
            %% inputs
            % wrapperObj : instance of the wrapper class to be attached to
            % the top model
            
            arguments
                obj
                wrapperObj pcssp_wrapper 
            end


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
                obj = process_pcssp_module(obj,algoObj);
            end
            
            % add wrapper to obj
            obj.wrappers{end+1}  = mywrapper;

            % add sldd to topmodel
            obj = obj.process_pcssp_wrapper(wrapperObj);
        end
        
        % module
        function obj = addmodule(obj,module)
            % method to add a pcssp module object to the top-model
            %% syntax
            % topm_obj = topm_obj.addmodule(pcssp_module_obj)
            %% input
            % module : instance of pcssp module class to be attached to top
            % model

            arguments
                obj
                module pcssp_module
            end
            
            assert(nargout==1,'must assign output for addmodule method')
            
            obj = obj.process_pcssp_module(module);
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
            %% syntax
            % obj.set_model_argument_value('path_to_model_in_hierarchy','var_name','var_value')
            %% inputs
            % model_path (string) : path to model in the hierarchy of the top model
            % var_name (string) : name of the to-be-injected variable in
            % the model mask
            % value : value of the to-be-injected variable
            
            arguments
                obj
                model_path (1,:) char
                var_name (1,:) char
                value 
            end
            
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
        
        function print_model_arguments(obj,model_path)
            % helper function to print the model arguments associated with
            % a model reference in the top model
            %% syntax
            % obj.prin_model_arguments('path_to_model')
            %% inputs
            % model_path : relative path to the referenced model in the top model hierarchy

            arguments
                obj
                model_path (1,:) char
            end

            if ~bdIsLoaded(obj.name)
                load_system(obj.name);
            end

            path_spec = [obj.name,'/',model_path];
            instSpecParams = get_param(path_spec,'InstanceParameters');
            
            fprintf('Referenced model %s has the following model instance parameters\n',path_spec);
     
 
            for ii = 1:length(instSpecParams)
                fprintf('Name: %s \t \t Value: %s\n',instSpecParams(ii).Name, instSpecParams(ii).Value);
            end
       
        end

    end



    methods(Hidden = true)
        
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

          % link data dictionaries for active PCSSP modules
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
        
        %% module init helper functions
        
        function obj = sortmoduleobjlist(obj)
          % sort moduleobj list such that no moduleobj has dependency on other 
          % moduleobj that are further down the list. So running moduleobj inits 
          % in this order ensures that everything is initialized in the correct order.
          
          A = zeros(numel(obj.moduleobjlist),numel(obj.moduleobjlist)); % init adiadency matrix
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

          % sort the properties related to pcssp modules
          obj.moduleobjlist = obj.moduleobjlist(isort);
          obj.moduleddlist = obj.moduleddlist(isort);
          obj.modulenamelist = obj.modulenamelist(isort);
        end

        function obj = modules_to_init(obj)
            
            % first build a long string array of all modules that are
            % referenced via a wrapper
            module_names_wrps = [];
            for ii = 1:length(obj.wrappers)
                algos = obj.wrappers{ii}.wrapperobj.algos;
                module_names_wrps =  vertcat(module_names_wrps,...
                        arrayfun(@(module) string(module.getname),algos));
            end
            
            if isempty(module_names_wrps)
                obj.directobjlist = obj.moduleobjlist;
            else
                k = contains(obj.modulenamelist,module_names_wrps);
                obj.directobjlist = obj.moduleobjlist(~k);
            end

        end
        
        function obj = process_pcssp_module(obj,moduleObj)
            % Checking and importing algorithm name
            if(~ismember(moduleObj.getname,obj.modulenamelist))
                obj.modulenamelist{end+1} = moduleObj.getname;
                obj.moduleobjlist{end+1}=moduleObj;
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
            
            
            % Importing fixed parameter inits
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
            end
            
        end
        

        %% wrapper init helper functions

        % Importing algorithms data dictionary, only those with proper name

        function obj = process_pcssp_wrapper(obj,wrapperObj)
            wrapperdd=wrapperObj.ddname;
            if(~ismember(wrapperdd,obj.wrapperddlist))
                obj.wrapperddlist{end+1}=wrapperdd;
            else
                warning('pcssp_top_class_class:process_wrapper','Wrapper data dictionary ''%s'' already present, ignoring', wrapperdd);
            end
        end


        function addwrapperbusestosldd(obj)
            % Add buses to data dictionary from .m file descriptions
            dictionaryObj = Simulink.data.dictionary.open(obj.ddname);
            designDataObj = getSection(dictionaryObj, 'Design Data');

            for jj = 1:length(obj.wrappers)

                busList = obj.wrappers{jj}.wrapperobj.buslist;

                for ii=1:numel(busList)
                    mybusSource = busList(ii).source;
                    busName = busList(ii).name;

                    if ischar(mybusSource)
                        % User specified a file that contains a bus definition
                        % (typically exported from bus editor)
                        fprintf('Adding wrapper bus %s from %s to %s\n',busName,mybusSource,obj.ddname);

                        assert(logical(exist(mybusSource,'file')),'%s does not exist',mybusSource)

                        eval(mybusSource); % eval bus script here

                        assert(exist(busName,'var')~=0,...
                            'no variable %s found despite running script %s',busName,which(mybusSource))
                        names{1} = busName; buses{1} = eval(busName);
                        sourcename = mybusSource;
                    elseif isa(mybusSource,'function_handle')
                        % user specified a function that returns cell arrays of
                        % bus names and bus objects. busNames is ignored in this case
                        [names,buses] = mybusSource();
                        sourcename = func2str(mybusSource);
                    else
                        error('Bus source %s is neither a fcn handle nor script definition',class(mybusSource))
                    end

                    for kk=1:numel(buses) % loop over buses to be added
                        fprintf('adding bus %25s from function %s to %s\n',...
                            names{kk},sourcename,obj.ddname)
                        obj.replaceorcreateddentry(designDataObj,names{kk},buses{kk});
                    end
                end

            end

            % Save if necessary
            if dictionaryObj.HasUnsavedChanges
                dictionaryObj.saveChanges;
            end

        end

        function replaceorcreateddentry(obj,designDataObj,entry,value)
            if designDataObj.exist(entry)
                oldEntry = designDataObj.getEntry(entry);
                assert(numel(oldEntry)==1,'multiple entries found for %s',entry)
                if isequal(oldEntry.getValue,value)
                    fprintf('%s: keep old value of %s since not changed\n',obj.name,entry);
                else
                    oldEntry.setValue(value); % replace
                    fprintf('%s: replaced value of %s since it changed\n',obj.name,entry);
                end
            else
                fprintf('   %s: added new %s\n',obj.name, entry);
                designDataObj.addEntry(entry,value);
            end
        end

        
                  
    end
end

