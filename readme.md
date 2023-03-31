PCSSP repository containing modules for ITER PCS development

Directory structure:
- APS: modules for the ITER Advanced Protection System
- PCS: modules for the ITER Plasma Control System
- configurations: Simulink configuration definitions for codegen and simulation
- scdds-core: git submodule (!) to handle data-dictionaries and module references in Simulink
- src: inherited PCSSP classes
- templates: pcssp examples
- tools: useful functions for plotting etc.

To start: 
- define an environment variable SCDDS_COREPATH to point to scdds-core in your ~/.bashrc:
export SCDDS_COREPATH="/home/ITER/<user_name>/Documents/MATLAB/pcssp-nightly/scdds-core"
- on SDCC in a new terminal window:
- module load intel MATLAB
- matlab
- run the pcssp_add_paths script
