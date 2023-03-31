classdef pcssp_wrapper < SCDDSclass_wrapper
  % superclass for SCDDSdemo wrapper
  %
  %
  % [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
  % Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
  
  methods
  
      function build(obj)
          % set configuration to gcc
          SCDconf_setConf('configurationSettingsCODEgcc');
          % build
          build@SCDDSclass_wrapper(obj); % call superclass method       
          
      end
      
  end
  
  
end