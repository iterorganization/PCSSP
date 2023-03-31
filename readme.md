# PCSSP repository containing modules for ITER PCS development
This repository relies on a git submodule to implement the Simulink functionality regarding
data dictionaries and referenced models. This submodule is developed under a GPL license
and can be found [here](https://gitlab.epfl.ch/spc/scdds/scdds-core). 

## Directory structure:
- APS: modules for the ITER Advanced Protection System
- PCS: modules for the ITER Plasma Control System
- configurations: Simulink configuration definitions for codegen and simulation
- scdds-core: git submodule (!) to handle data-dictionaries and module references in Simulink
- src: inherited PCSSP classes
- templates: pcssp examples
- tools: useful functions for plotting etc.

## To clone: 
### clone the repository
`git clone ssh://git@git.iter.org/pcs/pcssp-nightly.git`
### init and update scdds-core submodule
`git submodule update --recursive --init`


## To run:
### define an environment variable SCDDS_COREPATH to point to scdds-core in your ~/.bashrc
`export SCDDS_COREPATH="/home/ITER/<user_name>/Documents/MATLAB/pcssp-nightly/scdds-core"`

### On SDCC in a new terminal window:
`module load intel MATLAB`
`matlab`
### run the pcssp_add_paths script
