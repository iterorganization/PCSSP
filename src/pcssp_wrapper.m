classdef pcssp_wrapper < SCDDSclass_wrapper
  % superclass for SCDDSdemo wrapper
  %
  %
  % [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
  % Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
  
  methods
      
      % class constructor
      function obj = pcssp_wrapper(name,dt)
          if nargin<2, dt=1e-3; end % default wrapper period
          obj@SCDDSclass_wrapper(name,dt)
          obj.createdd = true;
          
      end
  
      function build(obj)
          % set configuration to gcc
          sourcedd = 'configurations_container_RTF.sldd';
          SCDconf_setConf('configurationSettingsRTFcpp',sourcedd);
          % build
          build@SCDDSclass_wrapper(obj); % call superclass method       
          
      end
      
  end
  
  
end