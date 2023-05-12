function param_struct = read_RTF_xml(filename)


xml_in = readstruct(filename);

% RTF parameter XML is structured as follows:

% <FunctionBlock Name="<block_name>" Type="SimulinkBlock">
%   	<Parameter Name="LibraryPath" Value="<block_name>/build/lib<block_name>.so"/>
%  	<Parameter Name="BlockName" Value="<block_name>"/>
%
%   <Parameter Name="KdRef" Value= [0 0 0 ]"/>
%               :
%               :

% readstruct returns a structure that follows the leaves in this XML:
% xml_in =
%     NameAttribute: "<block_name>"
%     TypeAttribute: "SimulinkBlock"
%         Parameter: [1×n struct]
%         InputPort: [1×m struct]
%        OutputPort: [1×l struct]


for ii = 1:length(xml_in.Parameter)

    % parameter entry is string
    if isstring(xml_in.Parameter(ii).ValueAttribute)

        try % parameter entry is JSON string
            paramValue = jsondecode(xml_in.Parameter(ii).ValueAttribute); % num JSON encoded

        catch % parameter is just a string
            paramValue = xml_in.Parameter(ii).ValueAttribute; % string
        end
        % parameter entry is already numeric
    elseif isnumeric(xml_in.Parameter(ii).ValueAttribute)
        paramValue = xml_in.Parameter(ii).ValueAttribute;
    else
        error('Parameter entry %s in XML not JSON or scalar\n',xml_in.Parameter(ii).NameAttribute);
    end

    param_struct.(xml_in.Parameter(ii).NameAttribute) = paramValue;
end

if any(isfield(param_struct,{'LibraryPath','BlockName'}))
    param_struct = rmfield(param_struct,{'LibraryPath','BlockName'});
end

end