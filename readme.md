# Introduction to the Plasma Control System Simulation Platform (PCSSP)
PCSSP provides standardized methods for the design and assessment of modules and models for plasma control. It essentially provides you with a systematic framework to develop, test, integrate, and deploy controller and tokamak models. PCSSP relies on a git submodule called SCDDS to implement the Simulink functionality regarding data dictionaries and referenced models. Both PCSSP and SCDDS are developed under a GPL license. You are invited to contribute to both projects that ultimately will be merged into one toolbox for control development and deployment on tokamaks. 

## Directory structure:
- configurations: Simulink configuration definitions for codegen and simulation
- scdds-core: git submodule (!) to handle data-dictionaries and module references in Simulink
- src: inherited PCSSP classes
- testing: inherited PCSSP classes for testing modules
- templates: pcssp examples
- tools: useful functions for plotting etc.

## To clone the repository:
`git clone git@github.com:iterorganization/pcssp.git`
### init and update scdds-core submodule
`git submodule update --init`

## To run:
### (Only required for code generation): define an environment variable SCDDS_COREPATH to point to scdds-core in your ~/.bashrc. For example, on a typical linux system the path could be:
`export SCDDS_COREPATH="~/Documents/MATLAB/pcssp-nightly/scdds-core"`

### Open Matlab on your system. On the ITER SDCC cluster you can for example type the following in a new terminal window:
`module load intel MATLAB`
`matlab`
### run the pcssp_add_paths script

### Inside matlab, execute the following command once to setup git merges with simulink:
`comparisons.ExternalSCMLink.setupGitConfig()`
This will tell git to use the simulink 3-way merge tool to resolve merge conflicts in binary slx files. 

### Navigate to the templates/ directory, and open one of the provided examples
Detailed documentation on how to develop your own PCSSP modules is not yet integrated in this repo, you can contact one of the lead developers below to obtain a PDF.

### License
This code is distributed under the `LGPL-v3` license.

This license allows you to develop derivative works that use this library (for example by calling its functions, derive classes, call binaries...) without needing to share it back. For example, you can develop (components of) a tokamak control system using these tools without the need to make it publicly available.
However, any modifications and updates to the library _itself_ must be shared under the same LGPL license. Also if you copy components of the library into other codes, that code should be shared back under the same LGPL license.

The authors would greatly appreciate it if the modifications are shared back to the source repository at the ITER Organization of the EPFL, see the `Contributing` section below.

The above is a non binding summary of the legal text. The full and legally binding text is in the license file `LICENSE.md`.

Note that this software requires Matlab/Simulink, including toolboxes needed for C code generation (typically Embedded coder) and Simulink Test. Users must obtain their own licenses from Mathworks.

### Contributing
The code is hosted on [https://github.com/iterorganization/pcssp](https://github.com/iterorganization/pcssp) and can be freely cloned. The Git submodule is hosted on [https://gitlab.epfl.ch/spc/scdds/scdds-core](https://gitlab.epfl.ch/spc/scdds/scdds-core) 

You are invited to actively contribute to both these codes by requesting membership to their respective projects. This allows you to read and post issues, or propose merge requests. Before proposing major changes or doing large developments, it is recommended to open an issue and discuss with other developers.

Currently PCSSP and SCDDS are seperate projects. However, in 2025 these will be formally merged together in one toolbox for controller design and deployment on tokamaks.

### Main contributors:

* [Cristian Galperti (SPC-EPFL)](mailto:cristian.galperti@epfl.ch) (2014 - )
* [Federico Felici (SPC-EPFL)](mailto:federico.felici@epfl.ch) (2009 - )
* [Timo Ravensbergen (ITER Organization)](mailto:timo.ravensbergen@iter.org) (2017 - )
* [Igor Gomez Ortiz (IPP Garching)](mailto:igor.gomez@ipp.mpg.de) (2021 - )
