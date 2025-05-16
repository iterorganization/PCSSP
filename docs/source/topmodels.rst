PCSSP top models
=================

Most often, your pcssp modules and wrappers will be part of a larger integrated simulation. To this end, pcssp supports the 'referencing' of the module and wrapper ``.slx`` from a so-called *top-model*.  
The scripts and models in ``<pcssp_root>/templates/PID_example`` show how a top model with attached class is able to inherit pcssp modules and wrappers in a complex model hierarchy. You can exploit and reproduce these capabilities via the steps below.

Class inheritance and construction
-----------------------------------

* Open a new/empty .slx-model to act as parent.

* Add 'model references' to the parent model for the modules you would like include:

	* Double-click in the empty Simulink model and search for 'model'. Add it

	* An empty red-bordered model reference will appear

	* Double click and navigate to an existing pcssp module slx you would like to add

* In Matlab, open a new .m script to act as main script attached to the parent ``.slx``. Alternatively, copy the code snippet below or one from the ``template/`` directory

* Inherit a fresh ``pcssp_top_model`` class to manipulate the parent model. During its initialization (later), this class will automatically generate and link a new ``sldd`` for the parent so no need to add it manually.

* In the main ``.m`` script, add existing wrapper and module classes to the inherited parent top-model class via the ``addmodule`` and ``addwrapper`` methods (see below) 

	* Wrappers are useful to act as an additional layer in the modeling hierarchy, for example when a module for code generation has a slightly different interface than the one for simulation.

	* The wrappers and modules you add to the top-model class instance should match the model-references you attached in the Simulink top model in step 2.

* ``init`` and ``setup`` the parent. This will automatically initialize all relevant children models.

* link the ``configurationSettingsTop``  for top-model simulation to your top model ``.slx`` (see :ref:`sec-configurationSettings`). This will set a continuous time solver and other relaxed settings on your model.

* Update the parent model (ctrl+D or ``topm.compile``) to see if everything works.

* Simulate the model, manually in the Simulink dialog or via :meth:`src.pcssp_top_class.sim`

Top model code example
-----------------------

.. code-block :: python
	
	%% configure top model
	topm = pcssp_top_class('closed_loop');
 
 
	%% initialize PCSSP modules
	obj_PID = pcssp_PID_obj(3); % input is the size of the inBus
	obj_TF = pcssp_TF_obj();
 
	%% initialize PCSSP wrappers
	wrapper_PID = pcssp_wrapper('pid_wrapper');
	wrapper_PID.timing.dt = obj_PID.gettiming.dt;
	wrapper_PID = wrapper_PID.addalgo(obj_PID);
 
	%% add modules and wrappers to top model and call init/setup
	topm = topm.addwrapper(wrapper_PID);
	topm = topm.addmodule(obj_TF);
 
	topm.init;
	topm.setup;


Data dictionary tips
---------------------

.. note ::
	PCSSP only uses the Simulink data dictionaries as an empty container that is automatically created and filled with parameters during model initialization. Therefore, changes in the ``.sldd`` should never be saved and it should in principle not be committed into the git 		repository of PCSSP. Upon closing your model(s) Matlab keeps the data-dictionaries loaded into memory. This may lead to unexpected and sluggish behaviour. We therefore provide a method in the ``top_model`` class to force close all open data dictionaries and soft/hard close 	all models: :meth:`pcssp_top_class.close_all`

It is often useful and necessary to retrieve and inspect values of the parameters in the data dictionaries. You can either manually navigate to them via the model explorer, or use the programmatic methods provided by PCSSP. See the API documentation for more info.


