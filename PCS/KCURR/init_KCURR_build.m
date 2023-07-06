%% Main script to generate code for the KMAG PCSSP module
% T. Ravensbergen with help from G. deTommasi 2023

clear; clc; bdclose all;
% force close all zombie sldd
Simulink.data.dictionary.closeAll('-discard')

writedata = 0; % flag to export logged data to txt

%% init slx model
obj_KMAG = pcssp_KCURR_obj();
obj_KMAG.init;
obj_KMAG.setup;

%% input size struct
size.extFF = [11 1];
size.Ref = [10 1];
size.y = [10 1];
size.enable = 1;

%% build
obj_KMAG.build;

%% build wrapper

wrapper = pcssp_wrapper('pcssp_KMAG_wrapper');
wrapper.timing.dt = obj_KMAG.gettiming.dt;
wrapper = wrapper.addalgo(obj_KMAG);
wrapper.build;        

%% prep logged data for RTF export
if writedata
    load('KMAG_logged.mat');
    KMAGin = logsout2struct(KMAG_logged);
    fieldN = fieldnames(KMAGin);

    for ii = 1:length(fieldN)
        writematrix(transpose(KMAGin.(fieldN{ii})),['KMAG_in_' fieldN{ii}],'FileType','text');

    end
end

%% write XML parameter structure
xml_out.NameAttribute = "KMAG";
xml_out.TypeAttribute = "SimulinkBlock";



names = ["LibraryPath","BlockName","P","I","D","N","Ke"];
Paramstrings = ["~/pcssp_KMAG/build/libpcssp.so","KMAG"];


for ii = 1:length(names)
    xml_out.Parameter(ii).NameAttribute =  names(ii);

    if ii>2
    xml_out.Parameter(ii).ValueAttribute = jsonencode(eval(sprintf('pcssp_KMAG_%s.Value',names(ii))));
    
    else
        xml_out.Parameter(ii).ValueAttribute = Paramstrings(ii);
    end
end


%%

% if writedata
    writestruct(xml_out,'KMAG_params.xml',"StructNodeName","FunctionBlock");
% end


