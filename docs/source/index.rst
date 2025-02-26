
PCSSP documentation
===================

Introduction
-------------------

Simulink software is powerful to simulate controllers in conjunction with models for actuator systems and plant dynamics. The ITER Plasma Control System Simulation Platform (PCSSP) standardizes modeling in Simulink, and provides a programmatic interface to systematically interact with a complex hierarchy of many models. The PCSSP relies on standalone Simulink models that each represent a module, for example a power supply or a controller. To form an integrated simulation, these modules may be embedded into another Simulink model, known as model referencing. Currently, PCSSP supports three layers in the model hierarchy, namely:

* PCSSP Module. The layer implementing individual PCSSP modules as standalone model

* PCSSP Wrapper. A layer around modules to group them into a standalone entity, for example multiple gas valves into a gas valve box. 

* PCSSP Top Model. The highest level of PCSSP, capable of combining many modules and wrappers in one integrated simulation.

Each layer is associated with a physical Simulink model created by a module developer (.slx file), a data dictionary for parameters and signal (bus) definitions that is automatically created and filled by PCSSP, ánd an instance of a dedicated class. This instance can be used to manipulate the model, associate parameters to it, etc. Given an existing PCSSP module, the following code would set it up for simulation:

.. code-block :: python

	obj_PS = pcssp_PowerSupplies_obj(); % call the existing instance of the pcssp-module class
	obj_PS.init; % create a fresh data dict, call the associated parameter definitions, stick them in the data dict
	obj_PS.setup; % call the simulinkConfiguration settings for simulation


Getting started
-----------------

PCSSP and its documentation is shared via a public git repository, you can find the link at the top of this page. PCSSP inherits functionality to manipulate the data-dictionaries programmatically from an additional open-source package. This package is called Simulink-based Control Design and Deployment Suite (SCDDS).  It is automatically added as a git submodule to PCSSP but can be accessed `here <https://gitlab.epfl.ch/spc/scdds/scdds-core>`_.

Please follow the steps in the PCSSP readme to initialize PCSSP and the SCDDS submodule correctly. 

In the following pages the different layers of PCSSP models are explained further. 


Table of contents
------------------

.. toctree::
	:caption: PCSSP classes
	:maxdepth: 1

	modules
	wrappers
	topmodels


.. toctree::
	:caption: Advanced topics
	:maxdepth: 1

	parametrization
	configurationSettings


.. toctree::
	:caption: Testing
	:maxdepth: 1

	module_tests
	compliance_tests

.. toctree::
	:caption: Code generation
	:maxdepth: 1

	code_generation


.. toctree::
	:caption: API documentation
	:maxdepth: 1

	modules-api
	wrapper-api
	top-model-api
	

		


