function write_variable2sldd(variable,variable_name,sldd_name,section)
% helper function to store variable with variable_name in sldd section

% PCSSP - Plasma Control System Simulation Platform
% Copyright ITER Organization 2025
% Route de Vinon-sur-Verdon, 13115, St. Paul-lez-Durance, France
% Distributed under the terms of the GNU Lesser General Public License,
% LGPL-3.0-only
% All rights reserved.

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

