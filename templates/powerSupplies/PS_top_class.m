classdef PS_top_class < SCDDSclass_expcode
    
    properties (SetAccess = protected)
        mainname        = 'PS_top'   % Main slx model name
        definednodes    = 1;       % defined node
    end
    
    methods
        function obj=PS_top_class(mainname,varargin)
            % Constructor
            if ~isempty(varargin)
                code = varargin{1};
            else
                code = 1;
            end
            
            obj@SCDDSclass_expcode(mainname,code);
%             override algonameprefix
            obj.algonameprefix  = 'pcssp'; % Algorithm name prefix
%             obj.mainname = 'RTF';
%             obj.mainslxname = varargin{1}; % overwrite main slx name
%             obj.ddname = [varargin{1} '.sldd'];
            
          
            

        end
        
        function build(obj)
            % set specific configuration settings
            SCDconf_setConf('configurationSettingsCODEgcc');
            % build
            build@SCDDSclass_expcode(obj); % call superclass method
        end
        
        function node = getdefaultnode(~,~)
            % Default node to populate empty nodes if any
            node = pcssp_node_class.empty;
        end
    end

end