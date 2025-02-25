PCSSP wrappers
===============

The PCSSP wrapper layer acts as an intermediate layer in the hierarchy, set between PCSSP modules (see :ref:`sec-moduleDevelopment`) and the PCSSP top model classes. The wrapper layer provides functionality to combine a small number of modules, or define a different interface to a module. The wrapper class supports the definition of new buses specifically for this purpose. Additional supporting methods, however, are much more limited compared to the top-model class. 

A PCSSP wrapper consists of:

* a .slx model that references one or more PCSSP module(s)

* A data dictionary containing the referenced module parameters. This sldd is automatically created and linked to the wrapper slx upon its init/setup
* Optionally: new bus definitions to handle the rewiring of signals in between top model and individual pcssp modules.

A wrapper is initialized using the following commands:

.. code-block :: python

	obj_sensor = pcssp_PID_sensor_obj();
	dt = 1e-3;
	sensor_wrapper = pcssp_wrapper('pid_wrapper',dt);
	sensor_wrapper = sensor_wrapper.addalgo(obj_sensor);
 
	sensor_wrapper.init % creates and links the sldd if necessary, links to module objects
	sensor_wrapper.setup % fills the wrapper sldd with module parameters from the referenced sldds 