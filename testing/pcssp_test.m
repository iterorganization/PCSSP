classdef (Abstract) pcssp_test < matlab.unittest.TestCase
  % Superclass for SCDDSdemo tests
  %
  %
  % [ SCDDS - Simulink Control Development & Deployment Suite ] Copyright SPC-EPFL Lausanne 2022.
  % Distributed under the terms of the GNU Lesser General Public License, LGPL-3.0-only.
  methods(TestClassSetup)
    % common methods for all tests
    function setup_paths(~) % function to setup desired paths
      rootpath = fileparts(fileparts(mfilename('fullpath')));
      run(fullfile(rootpath,'pcssp_add_paths'));
    end
  end
end

