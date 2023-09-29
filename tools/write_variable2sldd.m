function write_variable2sldd(variable,variable_name,sldd_name,section)
% helper function to store variable with variable_name in sldd section

arguments
    variable
    variable_name   string
    sldd_name       string
    section         string
end

myDictionaryObj = Simulink.data.dictionary.open(sldd_name);
dDataSectObj = getSection(myDictionaryObj,section);
addEntry(dDataSectObj,variable_name,variable);

end

