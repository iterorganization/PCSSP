obj_pcssp_gas_pipe = pcssp_gas_pipe_obj();

pcssp_gas_pipe.p0 = 2e-6 * ones(20,1);

phys_const.M_gas=2; %Molair mass of H2
phys_const.eta=8.76e-6; %viscous factor Luca value H2
phys_const.gamma=1.4; %diatomic H2

%% 
gas_obj = pcssp_gas_pipe_obj('H2');
gas_obj.init;
gas_obj.setup;

gas_fp_struct = gas_obj.getfpindatadict;
gas_obj.set_model_argument(gas_fp_struct.pcssp_gas_pipe_fp,'pcssp_gas_pipe_fp_shape');