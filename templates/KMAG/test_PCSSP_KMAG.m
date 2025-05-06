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
            module.load;
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true,'IgnoringSignalsNotAligned',false);
            
            %% load and prep test data
            load('KMAG_test_signals.mat');
            
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(module.getname);

            en = timeseries(ones(length(KMAG_test_signals.getElement('ExtFF').Time),1),KMAG_test_signals.getElement('ExtFF').Time);
       
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds = setElement(ds,1,KMAG_test_signals.getElement('ExtFF'));
            ds = setElement(ds,2,KMAG_test_signals.getElement('Ref'));
            ds = setElement(ds,3,KMAG_test_signals.getElement('y'));
            ds = setElement(ds,4,en);

            
            Simin = Simulink.SimulationInput(module.modelname);
            Simin = Simin.setExternalInput(ds);

            % inject a parameter to the model
            % Simin = Simin.setVariable('bla',5);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','-40','StopTime','-34');
            Simin = Simin.setModelParameter('SaveOutput', 'on');
            
            
            %% simulate
            out = sim(Simin);
            
            out_struct = logsout2struct(out);
            
            %% compare
            
            l = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
            
            % get logged signals from stored baseline
     
            ulog = KMAG_test_signals.getElement('u');    
            
            for ii = 1:11
                h1 = nexttile;
                
                % validate signals 1 by 1
                u_out = timeseries(out_struct.u.Values(:,ii),out_struct.u.Time);
                u_out = u_out.resample(ulog.Time);

                u_base = timeseries(ulog.Data(:,ii),ulog.Time);

                % remove first 1s transient before comparing
                u_out = u_out.delsample('Index',[1:20]);
                u_base = u_base.delsample('Index',[1:20]);

                plot(u_out); hold on; plot(u_base);
                       
                % compare signals within some tolerance
                testCase.verifyThat(u_out,MatchesSignal(u_base,'reltol',0.01,'WithOptions',opts));         
            end         
        end
        
        function SIL_MIL_comparison(testCase)
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            
            load('KMAG_test_signals.mat');
            
            %% prepare module
            module = testCase.algoobj();
            module.init;
            module.setup;
            module.load;
            
            %% prepare wrapper
            
            wrapper = pcssp_wrapper('pcssp_KMAG_wrapper',module.gettiming.dt);
            wrapper = wrapper.addalgo(module);
            wrapper.init;
            wrapper.setup;
            
            % shift logged signals in time to meet codegen t=0 starting
            % condition

            ExtFFts = KMAG_test_signals.getElement('ExtFF');
            ExtFFts = setuniformtime(ExtFFts,'StartTime',0);

            yts = KMAG_test_signals.getElement('y');
            yts = setuniformtime(yts,'StartTime',0);

            uts = KMAG_test_signals.getElement('u');
            uts = setuniformtime(uts,'StartTime',0);

            Refts = KMAG_test_signals.getElement('Ref');
            Refts = setuniformtime(Refts,'StartTime',0);

            
            wrapper.build('auto');
            
            load_system(wrapper.name)
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(wrapper.name);
            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds = setElement(ds,1,ExtFFts);
            ds = setElement(ds,2,Refts);
            ds = setElement(ds,3,yts);


            en = timeseries(ones(length(KMAG_test_signals.getElement('ExtFF').Time),1),Refts.Time);
            ds = setElement(ds,4,en);
            
            Simin = Simulink.SimulationInput('pcssp_KMAG_wrapper');
            Simin = Simin.setExternalInput(ds);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','0','StopTime','10');
            
            % run as SIL
            Simin = Simin.setModelParameter('SimulationMode','Software-in-the-loop (SIL)');
            Simin = Simin.setModelParameter('RootIOFormat','Structure reference');
            Simin = Simin.setModelParameter('InstructionSetExtensions','None');
            
            
            %% simulate
            out = sim(Simin);
            out_struct = logsout2struct(out);

            % only compare the first element of controller output u.
            % Simulink doesnt like it when you feed in more
                u_out = timeseries(out_struct.u.Values(:,ii),out_struct.u.Time);
                ulog = KMAG_test_signals.getElement('u');
                u_out = u_out.resample(ulog.Time);

                u_base = timeseries(ulog.Data(:,1),ulog.Time);

                % remove first 1s transient before comparing
                u_out = u_out.delsample('Index',[1:20]);
                u_base = u_base.delsample('Index',[1:20]);
            
            % compare signals within some tolerance
            testCase.verifyThat(u_out,MatchesSignal(u_base,...
                                'reltol',0.05,'WithOptions',opts)); 
        end
        
        
    end
end



