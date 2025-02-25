
PCSSP documentation
===================

Introduction
-------------------

Simulink software is powerful to simulate controllers in conjunction with models for actuator systems and plant dynamics. The ITER Plasma Control System Simulation Platform (PCSSP) standardizes modeling in Simulink, and provides a programmatic interface to systematically interact with a complex hierarchy of many models. The PCSSP relies on standalone Simulink models that each represent a module, for example a power supply or a controller. To form an integrated simulation, these modules may be embedded into another Simulink model, known as model referencing. Currently, PCSSP supports three layers in the model hierarchy, namely:

* PCSSP Module. The layer implementing individual PCSSP modules as standalone model

* PCSSP Wrapper. A layer around modules to group them into a standalone entity, for example multiple gas valves into a gas valve box. 

* PCSSP Top Model. The highest level of PCSSP, capable of combining many modules and wrappers in one integrated simulation.

Table of contents
------------------

.. toctree::
	:caption: PCSSP classes
	:maxdepth: 2

	modules
	wrappers
	topmodels


.. toctree::
	:caption: Advanced topics

	parametrization
	configurationSettings


.. toctree::
	:caption: Testing

	module_tests
	compliance_tests

.. toctree::
	:caption: Code generation

	code_generation


.. toctree::
	:caption: API documentation

	modules-api
	wrapper-api
	top-model-api
	

		


