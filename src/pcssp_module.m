classdef pcssp_module < SCDDSclass_algo
% derived class for PCSSP modules using the SCDDS core framework for model
% referencing with data dictionaries.

    
    methods
        
        function fpstruct = getfpindatadict(obj)
            if(~isempty(obj.fpinits)) % only try when fixed params are defined
                for ii=1:numel(obj.fpinits) % loop over all FP inits
                    fpstruct = [];
                    if ~strcmpi(obj.fpinits{ii}{3},'datadictionary')
                        fprintf('fixed params not in datadict, use obj.printinits to check');
                    else
                        % open the main sldd and grab fixed parameters
                        dictionaryObj = Simulink.data.dictionary.open(obj.getdatadictionary);
                        designDataObj = getSection(dictionaryObj, 'Design Data');
                        % append structure
                        fpstruct = [fpstruct, designDataObj.getEntry(obj.fpinits{ii}{2}{1}).getValue];
                        
                    end
                end
            end
            
        end
        
        
        
    end
    
end