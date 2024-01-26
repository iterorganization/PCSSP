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
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            load('/work/imas/shared/TEST/pcssp/KMAG_logged.mat');
            
            % get an empty input Dataset from the input ports of the model
            ds = createInputDataset(module.getname);

            % temporary fix to change the datatype of enable for WRL
            entemp = KMAG_logged.getElement('enable').Values;

            en = timeseries(double(entemp.Data),entemp.Time);

            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds = setElement(ds,1,KMAG_logged.getElement('ExtFF'));
            ds = setElement(ds,2,KMAG_logged.getElement('Ref'));
            ds = setElement(ds,3,KMAG_logged.getElement('y'));
            ds = setElement(ds,4,en);
            
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
     
            ulog = KMAG_logged.getElement('u');    
            
            for ii = 1:11
                h1 = nexttile;
                plot(out_struct.time,out_struct.u(ii,:)); hold on
                plot(ulog.Values.Time,ulog.Values.Data(:,ii));
                
                % validate signals 1 by 1
                u_out = timeseries(out_struct.u(ii,:)',out_struct.time);
                u_base = timeseries(ulog.Values.Data(:,ii),ulog.Values.Time);
                
                % compare signals within some tolerance
                testCase.verifyThat(u_out,MatchesSignal(u_base,'reltol',0.01,'WithOptions',opts));
                
                
            end
            
            
            
        end
        
        function SIL_MIL_comparison(testCase)
            
            import Simulink.sdi.constraints.MatchesSignal;
            import Simulink.sdi.constraints.MatchesSignalOptions;
            opts = MatchesSignalOptions('IgnoringExtraData',true);
            
            %% load and prep test data
            
            load('/work/imas/shared/TEST/pcssp/KMAG_logged.mat');
            
            %% prepare module
            module = testCase.algoobj();
            module.init;
            module.setup;
            module.load;
            
            %% prepare wrapper
            
            wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
            wrapper.timing.dt = module.gettiming.dt;
            wrapper = wrapper.addalgo(module);
            load_system(wrapper.name);
            
            % shift logged signals in time to meet codegen t=0 starting
            % condition

            ExtFFts = KMAG_logged.getElement('ExtFF').Values;
            ExtFFts.Time = ExtFFts.Time+abs(ExtFFts.Time(1));

            yts = KMAG_logged.getElement('y').Values;
            yts.Time = yts.Time+abs(yts.Time(1));

            uts = KMAG_logged.getElement('u').Values;
            uts.Time = uts.Time+abs(uts.Time(1));

            Refts = KMAG_logged.getElement('Ref').Values;
            Refts.Time = Refts.Time+abs(Refts.Time(1));

            
            wrapper.build;
            
            % get an empty input Dataset from the input ports of the model
            wrapper.load;
            ds = createInputDataset(wrapper.mdlname);
            
            % directly write timeseries objects to structures matching the input buses
            % of the model
            ds = setElement(ds,1,ExtFFts);
            ds = setElement(ds,2,Refts);
            ds = setElement(ds,3,yts);
            % temporary fix to change the datatype of enable for WRL
            entemp = KMAG_logged.getElement('enable').Values;

            en = timeseries(double(entemp.Data),entemp.Time+40);
            ds = setElement(ds,4,en);
            
            Simin = Simulink.SimulationInput('pcssp_KMAG_wrapper');
            Simin = Simin.setExternalInput(ds);
            
            % overwrite start/stop time to match reference simulation UMC_demo
            Simin = Simin.setModelParameter('StartTime','0','StopTime','10');
            
            % run as SIL
            Simin = Simin.setModelParameter('SimulationMode','Software-in-the-loop (SIL)');
            
            
            %% simulate
            out = sim(Simin);
            out_struct = logsout2struct(out.logsout);

            % only compare the first element of controller output u.
            % Simulink doesnt like it when you feed in more
            u_out_check = timeseries(out_struct.u(1,:)',out_struct.time,'Name','u');
            u_out_logged = timeseries(uts.Data(:,1),uts.Time,'Name',uts.Name);
            
            % compare signals within some tolerance
            testCase.verifyThat(u_out_check,MatchesSignal(u_out_logged,...
                                'reltol',0.05,'WithOptions',opts)); 
        end
        
        
    end
end



