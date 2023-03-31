classdef pcssp_top_class < SCDDSclass_expcode
    
    properties (SetAccess = protected)
        mainname        = 'top'   % Main slx model name
        definednodes    = 1;       % defined node
    end
    
    methods
        function obj=pcssp_top_class(varargin)
            % Constructor
            obj@SCDDSclass_expcode(varargin{:});
            
            % override algonameprefix
            obj.algonameprefix  = 'pcssp'; % Algorithm name prefix
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