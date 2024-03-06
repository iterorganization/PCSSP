%% Main script to generate code for the KMAG PCSSP module
% T. Ravensbergen with help from G. deTommasi 2023

clear; clc; bdclose all;
% force close all zombie sldd
Simulink.data.dictionary.closeAll('-discard')

writedata = 0; % flag to export logged data to txt

%% init slx model
obj_KMAG = pcssp_KMAG_module_obj();
obj_KMAG.init;
obj_KMAG.setup;

%% build
obj_KMAG.build;

%% build wrapper

wrapper = pcssp_KMAG_wrapper();
wrapper.build;        

%% prep logged data for RTF export
if writedata
    load('KMAG_in.mat');
%     KMAGin = logsout2struct(KMAG_logged);
    fieldN = fieldnames(KMAG_in);

    for ii = 1:length(fieldN)
        writematrix(transpose(KMAG_in.(fieldN{ii})),['KMAG_in_' fieldN{ii}],'FileType','text');

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
%     writestruct(xml_out,'KMAG_params.xml',"StructNodeName","FunctionBlock");
% end


