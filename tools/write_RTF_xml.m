function write_RTF_xml(obj,functionblock_alias)
% Method to automatically generate an XML description of this
% PCSSP module to act as RTF FunctionBlock description. This
% XML works together with the generated code to form an RTF FB.
% You can use the optional Bus and Simulink.Parameter
% description field to describe your signal/parameter, which
% then gets put as a comment in the RTF XML.
%
% this function uses the matlab writestruct fcn to mimick this
% XML structure for RTF applications.
%% syntax
% obj.write_RTF_xml('FUN-CTRL-MAG-01');
%% inputs
% functionblock_alias : Alias linking to the PCSDB, for example
% FUN-CTRL-MAG-01

arguments
    obj {mustBeA(obj,["pcssp_wrapper","pcssp_module"])}
    functionblock_alias char = '';
end



% grab the relevant slx name etc. from the classes

if strcmpi(class(obj), 'pcssp_wrapper')
    blockName = obj.name;
    exportedtps = arrayfun(@(obj) obj.exportedtps, obj.algos,'UniformOutput',false);
    exportedtpsdefaults = arrayfun(@(obj) obj.exportedtpsdefaults, obj.algos,'UniformOutput',false);


else % is a pcssp_module
    blockName = obj.getname;
    exportedtps = obj.exportedtps;
    exportedtpsdefaults = obj.exportedtpsdefaults;


end

% fixed RTF XML type header
xml_out.NameAttribute = blockName;
xml_out.TypeAttribute = "SimulinkBlock";

% write the block description field
xml_out.Description.NameAttribute = "BlockDescription";
xml_out.Description.ValueAttribute = obj.description;

% write the block PCSDB alias field
xml_out.Alias.NameAttribute = 'pcsdbAlias';
xml_out.Alias.ValueAttribute = functionblock_alias;


% fill fixed XML parameter fields
xml_out.Parameter(1).NameAttribute  = "LibraryPath";
xml_out.Parameter(1).ValueAttribute = ['~/',blockName,'/build/'];

% loop over TPs of pcssp_module to fill XML parameter fields
% To do: use sldd values/entries for this? or tpsdefaults?


for ii=1:numel(exportedtps)

    if ~isempty(exportedtps{ii})
        tp_name = exportedtps{ii};
        tp_val = feval(exportedtpsdefaults{ii});
        

        if isa(tp_val,'struct')
            tp_valXML = tp_val;
        elseif isa(tp_val,'Simulink.Parameter')
            tp_valXML = tp_val.Value;

            % add description field if available
            if ~isempty(tp_val.Description)
                xml_out.Parameter(ii+1).Description = tp_val.Description;
            end
        else
            error('parameter %s is not a struct or Simulink.Parameter',tp_name)

        end

        % get name string of parameter to act as prefix in the XML
        prefix = exportedtps{ii};

        % loop over all parameter fields
        field_names_tp = fieldnames(tp_valXML);
        field_values_tp = struct2cell(tp_valXML);

        for jj = 1:length(field_names_tp)
            % name
            xml_out.Parameter(ii+jj).NameAttribute = [prefix,'.' field_names_tp{jj}];

            % value
            xml_out.Parameter(ii+jj).ValueAttribute = jsonencode(field_values_tp{jj});

        end

    else
        % do nothing and continue
    end

end

%% ports
% XML structure: Name="errorSignals" Signal="signal_name_bf

modelInfo = Simulink.MDLInfo(blockName);
% input ports
for jj = 1:length(modelInfo.Interface.Inports)
    signal_name = modelInfo.Interface.Inports(jj).Name;
    xml_out.InputPort(jj).NameAttribute = signal_name;

    xml_out.InputPort(jj).SignalAttribute = [signal_name, '_bf'];

end
% output ports

for kk = 1:length(modelInfo.Interface.Outports)
    output_port_name = modelInfo.Interface.Outports(kk).Name;
    xml_out.OutputPort(kk).NameAttribute = output_port_name;
    xml_out.OutputPort(kk).SignalAttribute = output_port_name;

end


writestruct(xml_out,[blockName , '_params.xml'], "StructNodeName","FunctionBlock");




end