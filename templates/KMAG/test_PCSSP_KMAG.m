classdef test_PCSSP_KMAG < pcssp_module_test
    % PCSSP test class to demonstrate how the matlab unit test framework
    % can be used to author tests in PCSSP/Simulink
    %
    % You can run this particular test like this:
    % >> results = runtests('test_PCSSP_KMAG')
    % table(results) returns a convenient overview of all tests
    
    %%%%%%%%%%%%%%%%%%%%%%%%% Class Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    properties          % additional properties of the test class
        algoobj = @pcssp_KMAG_module_obj;
        isCodegen = false; % strange bug in KMAG .slx. Should be true in the future
    end
   
    %%%%%%%%%%%%%%%%%%%%%%%%%% Test definitions %%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Each function in this Test method is ran as a separate test with one
    % result
    methods (Test)
        function run_verification_sim(testCase)
            
            module = testCase.algoobj();
            module.init;
            module.setup;
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            
            KMAG_logged = load('KMAG_logged');
            
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(module.getname);
            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds = setElement(ds,1,KMAG_logged.KMAG_logged.getElement('extFF'));
            ds = setElement(ds,2,KMAG_logged.KMAG_logged.getElement('Ref'));
            ds = setElement(ds,3,KMAG_logged.KMAG_logged.getElement('y'));
            ds = setElement(ds,4,KMAG_logged.KMAG_logged.getElement('enable'));
            
            Simin = Simulink.SimulationInput(module.modelname);
            Simin = Simin.setExternalInput(ds);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','-40','StopTime','-34');
            
            
            %% simulate
            out = sim(Simin);
            
            out_struct = logsout2struct(out.logsout);
            
            %% compare
            
            l = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
            
            % get logged signals from stored baseline
     
            ulog_time = load('u_out_KMAG_logged_time');
            ulog= load('u_out_KMAG_logged_data');
            
            for ii = 1:11
                h1 = nexttile;
                plot(out_struct.time,out_struct.u(ii,:)); hold on
                plot(ulog_time,ulog(:,ii));
                
                % validate signals 1 by 1
                u_out = timeseries(out_struct.u(ii,:)',out_struct.time);
                u_base = timeseries(ulog(:,ii),ulog_time);
                
                % compare signals within some tolerance
                testCase.verifyThat(u_out,MatchesSignal(u_base,'reltol',0.01,'WithOptions',opts));
                
                
            end
            
            
            
        end
        
%         function SIL_MIL_comparison(testCase)
%             
%             import Simulink.sdi.constraints.MatchesSignal;
%             import Simulink.sdi.constraints.MatchesSignalOptions;
%             opts = MatchesSignalOptions('IgnoringExtraData',true);
%             
%             %% load and prep test data
%             
%             KMAG_logged = load('KMAG_logged');
%             
%             %% prepare module
%             module = testCase.algoobj();
%             module.init;
%             module.setup;
%             
%             %% prepare wrapper
%             
%             wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
%             wrapper.timing.dt = module.gettiming.dt;
%             wrapper = wrapper.addalgo(module);
%             load_system(wrapper.name);
%             
%             SCDconf_setConf('configurationSettingsCODEgcc'); % to be replaced with wrapper.build
%             
%             
%             % get an empty input Dataset from the input ports of the model
%             ds = createInputDataset(wrapper.name);
%             
%             % directly write timeseries objects to structures matching the input buses
%             % of the model
%             ds = setElement(ds,1,KMAG_logged.KMAG_logged.getElement('extFF'));
%             ds = setElement(ds,2,KMAG_logged.KMAG_logged.getElement('Ref'));
%             ds = setElement(ds,3,KMAG_logged.KMAG_logged.getElement('y'));
%             ds = setElement(ds,4,KMAG_logged.KMAG_logged.getElement('enable'));
%             
%             Simin = Simulink.SimulationInput('pcssp_KMAG_wrapper');
%             Simin = Simin.setExternalInput(ds);
%             
%             % overwrite start/stop time to match reference simulation UMC_demo
%             Simin = Simin.setModelParameter('StartTime','-40','StopTime','-34');
%             
%             % run as SIL
%             Simin = Simin.setModelParameter('SimulationMode','Software-in-the-loop (SIL)');
%             
%             
%             %% simulate
%             out = sim(Simin);
% 
%             % compare signals within some tolerance
%             testCase.verifyThat(out.logsout{1}.Values.u,MatchesSignal(KMAG_logged.KMAG_logged.getElement('output').Values.u,...
%                                 'reltol',0.01,'WithOptions',opts)); 
%         end
        
        
    end
end



