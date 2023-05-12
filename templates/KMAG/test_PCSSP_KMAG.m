classdef test_PCSSP_KMAG < matlab.unittest.TestCase
    % PCSSP test class to demonstrate how the matlab unit test framework
    % can be used to author tests in PCSSP/Simulink
    %
    % You can run this particular test like this:
    % >> results = runtests('test_PCSSP_MFC_event_demo')
    % table(results) returns a convenient overview of all tests
    
    %%%%%%%%%%%%%%%%%%%%%%%%% Class Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    properties          % additional properties of the test class
        obj             % pcssp_module class obj of the model
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% Class-wide Setup and Teardown %%%%%%%%%%%%%%
    %
    % The functions inside the TestClassSetup run before all others to set
    % up the whole class environment
    % The functions inside the TestClassTeardown run once after all other
    % test are done
    methods(TestClassSetup)
        
        function init(testCase)
            %% initialize object
            testCase.obj = pcssp_KMAG_module_obj();

            testCase.obj.init;
            testCase.obj.setup;
            
            load_system(testCase.obj.getname); % does not physically open the model
            
            % add teardown to close model once the test is finished
            addTeardown(testCase, @() close_system(testCase.obj.getname, 0))
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% Method-wide Setup and Teardown %%%%%%%%%%%%%
    %
    % The functions inside the TestMethodSetup run before every test in the
    % class
    % The functions in the TestMethodTeardown run after every test
    
    methods(TestMethodSetup)
        % empty for now
    end
    
    methods(TestMethodTeardown)
        % empty for now
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% Test definitions %%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Each function in this Test method is ran as a separate test with one
    % result
    methods (Test)
        function run_verification_sim(testCase)
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            
            KMAG_logged = load('KMAG_logged');
            
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(testCase.obj.getname);
            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds{1}.extFF = KMAG_logged.KMAG_logged.getElement('extFF').Values;
            ds{2}.ref = KMAG_logged.KMAG_logged.getElement('Ref').Values;
            ds{3}.y = KMAG_logged.KMAG_logged.getElement('y').Values;
            ds = setElement(ds,4,KMAG_logged.KMAG_logged.getElement('enable'));
            
            Simin = Simulink.SimulationInput('pcssp_KMAG');
            Simin = Simin.setExternalInput(ds);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','-40','StopTime','-34');
            
            
            %% simulate
            out = sim(Simin);
            
            %% compare
            
            l = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
            
            % get logged signals from stored baseline and current sim
            usim = out.logsout{1}.Values.u.Data;
            ulog = KMAG_logged.KMAG_logged.getElement('output').Values.u.Data;
            
            for ii = 1:11
                h1 = nexttile;
                plot(out.logsout{1}.Values.u.Time,usim(:,ii)); hold on
                plot(KMAG_logged.KMAG_logged.getElement('output').Values.u.Time,...
                    ulog(:,ii));         
            end

            % compare signals within some tolerance
            testCase.verifyThat(out.logsout{1}.Values.u,MatchesSignal(KMAG_logged.KMAG_logged.getElement('output').Values.u,...
                                'reltol',0.01,'WithOptions',opts));
            
        end
        
        function SIL_MIL_comparison(testCase)
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            
            KMAG_logged = load('KMAG_logged');
            
            %% prepare wrapper
            
            wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
            wrapper.timing.dt = testCase.obj.gettiming.dt;
            wrapper = wrapper.addalgo(testCase.obj);
            load_system(wrapper.name);
            
            SCDconf_setConf('configurationSettingsCODEgcc');
            
            
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(wrapper.name);
            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds{1}.extFF = KMAG_logged.KMAG_logged.getElement('extFF').Values;
            ds{2}.ref = KMAG_logged.KMAG_logged.getElement('Ref').Values;
            ds{3}.y = KMAG_logged.KMAG_logged.getElement('y').Values;
            ds = setElement(ds,4,KMAG_logged.KMAG_logged.getElement('enable'));
            
            Simin = Simulink.SimulationInput('pcssp_KMAG_wrapper');
            Simin = Simin.setExternalInput(ds);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','-40','StopTime','-34');
            
            % run as SIL
            Simin = Simin.setModelParameter('SimulationMode','Software-in-the-loop (SIL)');
            
            
            %% simulate
            out = sim(Simin);

            % compare signals within some tolerance
            testCase.verifyThat(out.logsout{1}.Values.u,MatchesSignal(KMAG_logged.KMAG_logged.getElement('output').Values.u,...
                                'reltol',0.01,'WithOptions',opts)); 
        end
        
        
    end
end



