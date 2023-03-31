classdef pcssp_node_class < SCDDSclass_node
    
    methods
        function obj = pcssp_node_class(nodenr)
            % call superclass constructor
            
            obj@SCDDSclass_node(nodenr);
            
            % overwrite with PCSSP specific stuff
            name = sprintf('RTF_%02d',nodenr);
            obj.name    = name;
            obj.ddname  = [name,'.sldd'];
            obj.mdlname = [name,'.slx'];
            
            % get node-specific configurations
            obj = defaultnodeconfig(obj,nodenr);
        end
        
        
        function node = defaultnodeconfig(node,nodenr)
            node.name = sprintf('NODE%02d',nodenr); %Default node names
            switch nodenr
                case 1
                    node.ncpu = 2;
                    node.type = '4cpus2015a';
                    node.timing.t_start = 0.0;
                    node.timing.t_stop = 10.0;
                    node.timing.dt = 1e-3;
                    node.buildcfg.conffile = cell(node.ncpu,1);
                    node.buildcfg.conffile{1} = 'standard';
                    node.buildcfg.conffile{2} = 'standard';
                    node.buildcfg.initscdbeforecomp = [0 0];
                    node.haswavegen = false;
                    node.hasadc = false;
                otherwise
                    error('node not defined')
            end
        end
    end
end