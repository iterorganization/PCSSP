function fp = pcssp_gas_pipe_loadfp(gasType)

%  Setup of Gas Pipe PCSSP block
%
%  SYNTAX: GasPipe_setup(module_path)
%
%  PURPOSE:  Define configuration, initial, and tsdata for gas pipe
%  INPUT:
%       module_path   = path of module for which setup_data is being constructed
%
%  OUTPUT:
%	setup_data 
 
%  RESTRICTIONS:
%
%  METHOD:  
%
%  WRITTEN BY:  Rémy Nouailletas, CE, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Gas pipe configuration
run('Parameters.m');

fp.port=3;
fp.position= 1; % 1 for "upper" or 0 for "lower"
fp.length = pipes(1);
%fp.gas_type= 1;
fp.R0 = R0;
fp.N = N;  %number of spatial discretization points of the pipes
fp.Katan=1e5; %To smooth sign function
fp.Cp = Cp; % Coefficient for vessel/pipe aperture
fp.Temp = Temp; % gas temperature [K] 
fp.bnd_cond_mode=1; %=0: external boundary condition, =1: aperture boundary condition

%% old mask init variables
R=8.3144621; %Perfect gas constant

%M operator
M=eye(fp.N);

for i=2:fp.N
    M(i,i-1)=-1;
end

fp.AM=[zeros(fp.N,fp.N) M; -M' zeros(fp.N,fp.N)];
fp.AM(2*fp.N,:)=0;
fp.BM=zeros(2*fp.N,2);
fp.BM(1,1)=-1;
fp.BM(2*fp.N,2)=1;
fp.CM=zeros(2,2*fp.N);
fp.CM(1,1)=1;
fp.CM(2,2*fp.N)=1;

%Step size
fp.dx=fp.length/(fp.N-1);

%pipe diameter
fp.d=2*fp.R0; %[m]
%pipe section
fp.A=pi*fp.R0^2; %[m²]

switch gasType
    case 'H2'
        
        M_gas=2; %Molair mass of H2
        eta=8.76e-6; %viscous factor Luca value H2
        gamma=1.4; %diatomic H2
    case 'He'
        M_gas=4; %Molair mass of He
        eta=19e-6; %viscous factor Luca value He
        gamma=1.667; %monoatomic He
    otherwise
        M_gas=0; %Molair mass
        eta=0; %viscous factor
        gamma=0;
end
fp.gamma = gamma;

fp.v=sqrt(3*R*fp.Temp/M_gas); %Moleculare velocity

fp.C0=pi/12*fp.d^3*fp.v; %Molecular conductance
C1=eye(fp.N);
C1(fp.N,:)=0;
for i=1:fp.N-1
    C1(i,i+1)=1;
end

fp.C1=pi*fp.R0^4/8/eta*C1;%viscous conductance gain

fp.C1out=pi*fp.R0^4/8/eta/fp.dx/2; %viscous conductance gain for boundary condition at x=l


% initial conditions
fp.p0 = p0(1)*ones(fp.N,1);




end