function cs = configurationSettingsCODEgcc()
% MATLAB function for configuration set generated on 12-May-2023 11:51:15
% MATLAB version: 9.9.0.1538559 (R2020b) Update 3

cs = Simulink.ConfigSet;

% Original configuration set version: 20.1.0
if cs.versionCompare('20.1.0') < 0
    error('Simulink:MFileVersionViolation', 'The version of the target configuration set is older than the original configuration set.');
end

% Character encoding: UTF-8

% Do not change the order of the following commands. There are dependencies between the parameters.
cs.set_param('Name', 'configurationSettingsCODEgcc'); % Name
cs.set_param('Description', ''); % Description

% Original configuration set target is ert_shrlib_scd.tlc
try
    cs.switchTarget('ert_shrlib_scd.tlc', '');
catch ME
    disp(ME.message);
    disp('Setting ''System target file'' to ''ert.tlc''.');
    cs.switchTarget('ert.tlc', '');
end

cs.set_param('HardwareBoard', 'None');   % Hardware board

cs.set_param('TargetLang', 'C');   % Language

cs.set_param('CodeInterfacePackaging', 'Reusable function');   % Code interface packaging

cs.set_param('GenerateAllocFcn', 'on');   % Use dynamic memory allocation for model initialization

cs.set_param('Solver', 'FixedStepDiscrete');   % Solver

% Solver
cs.set_param('StartTime', '0');   % Start time
cs.set_param('StopTime', '4');   % Stop time
cs.set_param('SampleTimeConstraint', 'Unconstrained');   % Periodic sample time constraint
cs.set_param('SolverType', 'Fixed-step');   % Type
cs.set_param('SolverName', 'FixedStepDiscrete');   % Solver
cs.set_param('ConcurrentTasks', 'off');   % Allow tasks to execute concurrently on target
cs.set_param('FixedStep', 'auto');   % Fixed-step size (fundamental sample time)
cs.set_param('EnableMultiTasking', 'off');   % Treat each discrete rate as a separate task
cs.set_param('PositivePriorityOrder', 'off');   % Higher priority value indicates higher task priority
cs.set_param('AutoInsertRateTranBlk', 'off');   % Automatically handle rate transition for data transfer

% Data Import/Export
cs.set_param('Decimation', '1');   % Decimation
cs.set_param('LoadExternalInput', 'off');   % Load external input
cs.set_param('SaveFinalState', 'off');   % Save final state
cs.set_param('LoadInitialState', 'off');   % Load initial state
cs.set_param('LimitDataPoints', 'off');   % Limit data points
cs.set_param('SaveFormat', 'StructureWithTime');   % Format
cs.set_param('SaveOutput', 'off');   % Save output
cs.set_param('SaveState', 'off');   % Save states
cs.set_param('SignalLogging', 'on');   % Signal logging
cs.set_param('DSMLogging', 'off');   % Data stores
cs.set_param('InspectSignalLogs', 'off');   % Record logged workspace data in Simulation Data Inspector
cs.set_param('SaveTime', 'off');   % Save time
cs.set_param('ReturnWorkspaceOutputs', 'off');   % Single simulation output
cs.set_param('SignalLoggingName', 'logsout');   % Signal logging name
cs.set_param('LoggingToFile', 'off');   % Log Dataset data to file
cs.set_param('DatasetSignalFormat', 'timeseries');   % Dataset signal format

% Optimization
cs.set_param('BlockReduction', 'on');   % Block reduction
cs.set_param('BooleanDataType', 'on');   % Implement logic signals as Boolean data (vs. double)
cs.set_param('ConditionallyExecuteInputs', 'on');   % Conditional input branch execution
cs.set_param('DefaultParameterBehavior', 'Inlined');   % Default parameter behavior
cs.set_param('UseDivisionForNetSlopeComputation', 'off');   % Use division for fixed-point net slope computation
cs.set_param('GainParamInheritBuiltInType', 'off');   % Gain parameters inherit a built-in integer type that is lossless
cs.set_param('UseFloatMulNetSlope', 'on');   % Use floating-point multiplication to handle net slope corrections
cs.set_param('DefaultUnderspecifiedDataType', 'double');   % Default for underspecified data type
cs.set_param('UseSpecifiedMinMax', 'off');   % Optimize using the specified minimum and maximum values
cs.set_param('InlineInvariantSignals', 'off');   % Inline invariant signals
cs.set_param('OptimizationCustomize', 'off');   % Specify custom optimizations
cs.set_param('OptimizationPriority', 'Balanced');   % Priority
cs.set_param('OptimizationLevel', 'level2');   % Level
cs.set_param('DataBitsets', 'off');   % Use bitsets for storing Boolean data
cs.set_param('StateBitsets', 'off');   % Use bitsets for storing state configuration
cs.set_param('LocalBlockOutputs', 'on');   % Enable local block outputs
cs.set_param('EnableMemcpy', 'on');   % Use memcpy for vector assignment
cs.set_param('ExpressionFolding', 'on');   % Eliminate superfluous local variables (expression folding)
cs.set_param('BufferReuse', 'on');   % Reuse local block outputs
cs.set_param('OptimizeBlockIOStorage', 'on');   % Signal storage reuse
cs.set_param('AdvancedOptControl', '');   % Disable incompatible optimizations
cs.set_param('BitwiseOrLogicalOp', 'Same as modeled');   % Operator to represent Bitwise and Logical Operator blocks
cs.set_param('MemcpyThreshold', 64);   % Memcpy threshold (bytes)
cs.set_param('PassReuseOutputArgsAs', 'Individual arguments');   % Pass reusable subsystem outputs as
cs.set_param('PassReuseOutputArgsThreshold', 12);   % Maximum number of arguments for subsystem outputs
cs.set_param('RollThreshold', 5);   % Loop unrolling threshold
cs.set_param('ActiveStateOutputEnumStorageType', 'Native Integer');   % Base storage type for automatically created enumerations
cs.set_param('ZeroExternalMemoryAtStartup', 'on');   % Remove root level I/O zero initialization
cs.set_param('ZeroInternalMemoryAtStartup', 'on');   % Remove internal data zero initialization
cs.set_param('InitFltsAndDblsToZero', 'off');   % Use memset to initialize floats and doubles to 0.0
cs.set_param('NoFixptDivByZeroProtection', 'off');   % Remove code that protects against division arithmetic exceptions
cs.set_param('EfficientFloat2IntCast', 'on');   % Remove code from floating-point to integer conversions that wraps out-of-range values
cs.set_param('EfficientMapNaN2IntZero', 'on');   % Remove code from floating-point to integer conversions with saturation that maps NaN to zero
cs.set_param('LifeSpan', 'auto');   % Application lifespan (days)
cs.set_param('MaxStackSize', 'Inherit from target');   % Maximum stack size (bytes)
cs.set_param('BufferReusableBoundary', 'on');   % Buffer for reusable subsystems
cs.set_param('SimCompilerOptimization', 'off');   % Compiler optimization level
cs.set_param('AccelVerboseBuild', 'on');   % Verbose accelerator builds
cs.set_param('UseRowMajorAlgorithm', 'off');   % Use algorithms optimized for row-major array layout
cs.set_param('LabelGuidedReuse', 'off');   % Use signal labels to guide buffer reuse
cs.set_param('DenormalBehavior', 'GradualUnderflow');   % In accelerated simulation modes, denormal numbers can be flushed to zero using the 'flush-to-zero' option.
cs.set_param('EfficientTunableParamExpr', 'on');   % Remove code from tunable parameter expressions that saturates out-of-range values

% Diagnostics
cs.set_param('RTPrefix', 'warning');   % "rt" prefix for identifiers
cs.set_param('ConsistencyChecking', 'warning');   % Solver data inconsistency
cs.set_param('ArrayBoundsChecking', 'none');   % Array bounds exceeded
cs.set_param('SignalInfNanChecking', 'none');   % Inf or NaN block output
cs.set_param('StringTruncationChecking', 'error');   % String truncation checking
cs.set_param('SignalRangeChecking', 'warning');   % Simulation range checking
cs.set_param('ReadBeforeWriteMsg', 'EnableAllAsError');   % Detect read before write
cs.set_param('WriteAfterWriteMsg', 'EnableAllAsError');   % Detect write after write
cs.set_param('WriteAfterReadMsg', 'EnableAllAsError');   % Detect write after read
cs.set_param('AlgebraicLoopMsg', 'error');   % Algebraic loop
cs.set_param('ArtificialAlgebraicLoopMsg', 'error');   % Minimize algebraic loop
cs.set_param('SaveWithDisabledLinksMsg', 'warning');   % Block diagram contains disabled library links
cs.set_param('SaveWithParameterizedLinksMsg', 'error');   % Block diagram contains parameterized library links
cs.set_param('UnderspecifiedInitializationDetection', 'Simplified');   % Underspecified initialization detection
cs.set_param('MergeDetectMultiDrivingBlocksExec', 'error');   % Detect multiple driving blocks executing at the same time step
cs.set_param('SignalResolutionControl', 'UseLocalSettings');   % Signal resolution
cs.set_param('BlockPriorityViolationMsg', 'error');   % Block priority violation
cs.set_param('MinStepSizeMsg', 'warning');   % Min step size violation
cs.set_param('TimeAdjustmentMsg', 'none');   % Sample hit time adjusting
cs.set_param('MaxConsecutiveZCsMsg', 'error');   % Consecutive zero crossings violation
cs.set_param('MaskedZcDiagnostic', 'warning');   % Masked zero crossings
cs.set_param('IgnoredZcDiagnostic', 'warning');   % Ignored zero crossings
cs.set_param('SolverPrmCheckMsg', 'warning');   % Automatic solver parameter selection
cs.set_param('InheritedTsInSrcMsg', 'error');   % Source block specifies -1 sample time
cs.set_param('MultiTaskDSMMsg', 'error');   % Multitask data store
cs.set_param('MultiTaskCondExecSysMsg', 'error');   % Multitask conditionally executed subsystem
cs.set_param('MultiTaskRateTransMsg', 'error');   % Multitask data transfer
cs.set_param('SingleTaskRateTransMsg', 'none');   % Single task data transfer
cs.set_param('TasksWithSamePriorityMsg', 'warning');   % Tasks with equal priority
cs.set_param('SigSpecEnsureSampleTimeMsg', 'error');   % Enforce sample times specified by Signal Specification blocks
cs.set_param('CheckMatrixSingularityMsg', 'warning');   % Division by singular matrix
cs.set_param('IntegerOverflowMsg', 'warning');   % Wrap on overflow
cs.set_param('Int32ToFloatConvMsg', 'warning');   % 32-bit integer to single precision float conversion
cs.set_param('ParameterDowncastMsg', 'error');   % Detect downcast
cs.set_param('ParameterOverflowMsg', 'error');   % Detect overflow
cs.set_param('ParameterUnderflowMsg', 'error');   % Detect underflow
cs.set_param('ParameterPrecisionLossMsg', 'warning');   % Detect precision loss
cs.set_param('ParameterTunabilityLossMsg', 'error');   % Detect loss of tunability
cs.set_param('FixptConstUnderflowMsg', 'none');   % Detect underflow
cs.set_param('FixptConstOverflowMsg', 'none');   % Detect overflow
cs.set_param('FixptConstPrecisionLossMsg', 'none');   % Detect precision loss
cs.set_param('UnderSpecifiedDataTypeMsg', 'none');   % Underspecified data types
cs.set_param('UnnecessaryDatatypeConvMsg', 'warning');   % Unnecessary type conversions
cs.set_param('VectorMatrixConversionMsg', 'warning');   % Vector/matrix block input conversion
cs.set_param('FcnCallInpInsideContextMsg', 'error');   % Context-dependent inputs
cs.set_param('SignalLabelMismatchMsg', 'none');   % Signal label mismatch
cs.set_param('UnconnectedInputMsg', 'error');   % Unconnected block input ports
cs.set_param('UnconnectedOutputMsg', 'error');   % Unconnected block output ports
cs.set_param('UnconnectedLineMsg', 'error');   % Unconnected line
cs.set_param('SFcnCompatibilityMsg', 'warning');   % S-function upgrades needed
cs.set_param('FrameProcessingCompatibilityMsg', 'error');   % Block behavior depends on frame status of signal
cs.set_param('UniqueDataStoreMsg', 'error');   % Duplicate data store names
cs.set_param('BusObjectLabelMismatch', 'error');   % Element name mismatch
cs.set_param('RootOutportRequireBusObject', 'error');   % Unspecified bus object at root Outport block
cs.set_param('AssertControl', 'DisableAll');   % Model Verification block enabling
cs.set_param('AllowSymbolicDim', 'on');   % Allow symbolic dimension specification
cs.set_param('ModelReferenceIOMsg', 'warning');   % Invalid root Inport/Outport block connection
cs.set_param('ModelReferenceVersionMismatchMessage', 'none');   % Model block version mismatch
cs.set_param('ModelReferenceIOMismatchMessage', 'error');   % Port and parameter mismatch
cs.set_param('UnknownTsInhSupMsg', 'error');   % Unspecified inheritability of sample time
cs.set_param('ModelReferenceDataLoggingMessage', 'warning');   % Unsupported data logging
cs.set_param('ModelReferenceNoExplicitFinalValueMsg', 'none');   % No explicit final value for model arguments
cs.set_param('ModelReferenceSymbolNameMessage', 'warning');   % Insufficient maximum identifier length
cs.set_param('ModelReferenceExtraNoncontSigs', 'error');   % Extraneous discrete derivative signals
cs.set_param('StateNameClashWarn', 'warning');   % State name clash
cs.set_param('OperatingPointInterfaceChecksumMismatchMsg', 'warning');   % Operating point restore interface checksum mismatch
cs.set_param('NonCurrentReleaseOperatingPointMsg', 'error');   % Operating point object from a different release
cs.set_param('PregeneratedLibrarySubsystemCodeDiagnostic', 'warning');   % Behavior when pregenerated library subsystem code is missing
cs.set_param('InitInArrayFormatMsg', 'warning');   % Initial state is array
cs.set_param('StrictBusMsg', 'ErrorOnBusTreatedAsVector');   % Bus signal treated as vector
cs.set_param('BusNameAdapt', 'WarnAndRepair');   % Repair bus selections
cs.set_param('NonBusSignalsTreatedAsBus', 'error');   % Non-bus signals treated as bus signals
cs.set_param('SFUnusedDataAndEventsDiag', 'warning');   % Unused data, events, messages and functions
cs.set_param('SFUnexpectedBacktrackingDiag', 'error');   % Unexpected backtracking
cs.set_param('SFInvalidInputDataAccessInChartInitDiag', 'error');   % Invalid input data access in chart initialization
cs.set_param('SFNoUnconditionalDefaultTransitionDiag', 'error');   % No unconditional default transitions
cs.set_param('SFTransitionOutsideNaturalParentDiag', 'error');   % Transition outside natural parent
cs.set_param('SFUnreachableExecutionPathDiag', 'error');   % Unreachable execution path
cs.set_param('SFUndirectedBroadcastEventsDiag', 'error');   % Undirected event broadcasts
cs.set_param('SFTransitionActionBeforeConditionDiag', 'warning');   % Transition action specified before condition action
cs.set_param('SFOutputUsedAsStateInMooreChartDiag', 'error');   % Read-before-write to output in Moore chart
cs.set_param('SFTemporalDelaySmallerThanSampleTimeDiag', 'warning');   % Absolute time temporal value shorter than sampling period
cs.set_param('SFSelfTransitionDiag', 'warning');   % Self-transition on leaf state
cs.set_param('SFExecutionAtInitializationDiag', 'none');   % 'Execute-at-initialization' disabled in presence of input events
cs.set_param('SFMachineParentedDataDiag', 'warning');   % Use of machine-parented data instead of Data Store Memory
cs.set_param('IntegerSaturationMsg', 'warning');   % Saturate on overflow
cs.set_param('AllowedUnitSystems', 'SI,SI (extended)');   % Allowed unit systems
cs.set_param('UnitsInconsistencyMsg', 'none');   % Units inconsistency messages
cs.set_param('AllowAutomaticUnitConversions', 'on');   % Allow automatic unit conversions
cs.set_param('RCSCRenamedMsg', 'warning');   % Detect non-reused custom storage classes
cs.set_param('RCSCObservableMsg', 'warning');   % Detect ambiguous custom storage class final values
cs.set_param('ForceCombineOutputUpdateInSim', 'off');   % Combine output and update methods for code generation and simulation
cs.set_param('UnderSpecifiedDimensionMsg', 'warning');   % Underspecified dimensions
cs.set_param('DebugExecutionForFMUViaOutOfProcess', 'off');   % FMU Import blocks
cs.set_param('ArithmeticOperatorsInVariantConditions', 'warning');   % Arithmetic operations in variant conditions
cs.set_param('VariantConditionMismatch', 'none');   % Variant condition mismatch at signal source and destination

% Hardware Implementation
cs.set_param('ProdHWDeviceType', 'Intel->x86-64');   % Production device vendor and type
cs.set_param('ProdLongLongMode', 'off');   % Support long long
cs.set_param('ProdLargestAtomicInteger', 'Char');   % Largest atomic integer size
cs.set_param('ProdLargestAtomicFloat', 'None');   % Largest atomic floating-point size
cs.set_param('ProdIntDivRoundTo', 'Zero');   % Production hardware signed integer division rounds to
cs.set_param('ProdEqTarget', 'off');   % Test hardware is the same as production hardware
cs.set_param('TargetHWDeviceType', 'MATLAB Host');   % Test device vendor and type
cs.set_param('TargetLargestAtomicInteger', 'Char');   % Largest atomic integer size in test hardware
cs.set_param('TargetLargestAtomicFloat', 'None');   % Largest atomic floating-point size in test hardware
cs.set_param('TargetPreprocMaxBitsSint', 32);   % Maximum bits for signed integer in C preprocessor
cs.set_param('TargetPreprocMaxBitsUint', 32);   % Maximum bits for unsigned integer in C preprocessor
cs.set_param('HardwareBoardFeatureSet', 'EmbeddedCoderHSP');   % Feature set for selected hardware board

% Model Referencing
cs.set_param('UpdateModelReferenceTargets', 'IfOutOfDate');   % Rebuild
cs.set_param('EnableRefExpFcnMdlSchedulingChecks', 'on');   % Enable strict scheduling checks for referenced models
cs.set_param('EnableParallelModelReferenceBuilds', 'on');   % Enable parallel model reference builds
cs.set_param('ParallelModelReferenceErrorOnInvalidPool', 'on');   % Perform consistency check on parallel pool
cs.set_param('ParallelModelReferenceMATLABWorkerInit', 'Copy Base Workspace');   % MATLAB worker initialization for builds
cs.set_param('ModelReferenceNumInstancesAllowed', 'Multi');   % Total number of instances allowed per top model
cs.set_param('PropagateVarSize', 'Infer from blocks in model');   % Propagate sizes of variable-size signals
cs.set_param('ModelDependencies', '');   % Model dependencies
cs.set_param('ModelReferencePassRootInputsByReference', 'off');   % Pass fixed-size scalar root inputs by value for code generation
cs.set_param('ModelReferenceMinAlgLoopOccurrences', 'off');   % Minimize algebraic loop occurrences
cs.set_param('PropagateSignalLabelsOutOfModel', 'off');   % Propagate all signal labels out of the model
cs.set_param('SupportModelReferenceSimTargetCustomCode', 'off');   % Include custom code for referenced models

% Simulation Target
cs.set_param('SimCustomSourceCode', '');   % Source file
cs.set_param('SimCustomHeaderCode', 'int mydef;');   % Header file
cs.set_param('SimCustomInitializer', '');   % Initialize function
cs.set_param('SimCustomTerminator', '');   % Terminate function
cs.set_param('SimReservedNameArray', []);   % Reserved names
cs.set_param('SimUserSources', '');   % Source files
cs.set_param('SimUserIncludeDirs', '');   % Include directories
cs.set_param('SimUserLibraries', '');   % Libraries
cs.set_param('SimUserDefines', '');   % Defines
cs.set_param('SFSimEnableDebug', 'off');   % Allow setting breakpoints during simulation
cs.set_param('SFSimEcho', 'off');   % Echo expressions without semicolons
cs.set_param('SimCtrlC', 'off');   % Ensure responsiveness
cs.set_param('SimIntegrity', 'off');   % Ensure memory integrity
cs.set_param('SimParseCustomCode', 'off');   % Import custom code
cs.set_param('SimGenImportedTypeDefs', 'off');   % Generate typedefs for imported bus and enumeration types
cs.set_param('CompileTimeRecursionLimit', 50);   % Compile-time recursion limit for MATLAB functions
cs.set_param('EnableRuntimeRecursion', 'on');   % Enable run-time recursion for MATLAB functions
cs.set_param('MATLABDynamicMemAlloc', 'off');   % Dynamic memory allocation in MATLAB functions
cs.set_param('CustomCodeFunctionArrayLayout', []);   % Exception by function...
cs.set_param('DefaultCustomCodeFunctionArrayLayout', 'NotSpecified');   % Default function array layout
cs.set_param('GPUAcceleration', 'off');   % GPU acceleration
cs.set_param('SimTargetLang', 'C');   % Language

% Code Generation
cs.set_param('RemoveResetFunc', 'on');   % Remove reset function
cs.set_param('ExistingSharedCode', '');   % Existing shared code
cs.set_param('TLCOptions', '');   % TLC command line options
cs.set_param('GenCodeOnly', 'off');   % Generate code only
cs.set_param('RTWCompilerOptimization', 'Custom');   % Compiler optimization level
cs.set_param('GenerateMakefile', 'on');   % Generate makefile
cs.set_param('MakeCommand', 'make_rtw');   % Make command
cs.set_param('PackageGeneratedCodeAndArtifacts', 'off');   % Package code and artifacts
cs.set_param('TemplateMakefile', 'ert_unix.tmf');   % Template makefile
cs.set_param('PostCodeGenCommand', '');   % Post code generation command
cs.set_param('GenerateReport', 'on');   % Create code generation report
cs.set_param('RTWVerbose', 'on');   % Verbose build
cs.set_param('RetainRTWFile', 'on');   % Retain .rtw file
cs.set_param('ProfileTLC', 'off');   % Profile TLC
cs.set_param('TLCDebug', 'off');   % Start TLC debugger when generating code
cs.set_param('TLCCoverage', 'off');   % Start TLC coverage when generating code
cs.set_param('TLCAssert', 'off');   % Enable TLC assertion
cs.set_param('RTWUseSimCustomCode', 'off');   % Use the same custom code settings as Simulation Target
cs.set_param('CustomSourceCode', sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s','void * GETMMIFCN(MODEL) ( TSTRUCTNAME(MODEL) *rtm )','{','  return (void *)&(((rtm)->DataMapInfo).mmi);','}','void GETINFOFCN(MODEL) ( struct algoinfo* info )','{','   snprintf( info->text, ALGOINFOLEN, "%s", ALGOINFOSTR);','   info->len=ALGOINFOLEN;','}',''));   % Source file
cs.set_param('CustomHeaderCode', sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s','#ifndef SCDMACROS','#define SCDMACROS','#define UTSTRUCTNAME(NAME) RT_MODEL_##NAME##_T','#define TSTRUCTNAME(NAME) UTSTRUCTNAME(NAME)','#define UGETMMIFCN(NAME) NAME##_GetCAPImmi','#define GETMMIFCN(NAME) UGETMMIFCN(NAME)','#define UGETINFOFCN(NAME) NAME##_GetAlgoInfo','#define GETINFOFCN(NAME) UGETINFOFCN(NAME)','#endif ','#include "string.h"','#include "scddsalgoinfo.h"',''));   % Header file
cs.set_param('CustomInclude', '');   % Include directories
cs.set_param('CustomSource', '');   % Source files
cs.set_param('CustomLibrary', '');   % Libraries
cs.set_param('CustomDefine', '');   % Defines
cs.set_param('CustomBLASCallback', '');   % Custom BLAS library callback
cs.set_param('CustomLAPACKCallback', '');   % Custom LAPACK library callback
cs.set_param('CustomFFTCallback', '');   % Custom FFT library callback
cs.set_param('CustomInitializer', '');   % Initialize function
cs.set_param('CustomTerminator', '');   % Terminate function
cs.set_param('IncludeHyperlinkInReport', 'on');   % Code-to-model
cs.set_param('LaunchReport', 'on');   % Open report automatically
cs.set_param('PortableWordSizes', 'off');   % Enable portable word sizes
cs.set_param('CreateSILPILBlock', 'None');   % Create block
cs.set_param('CodeExecutionProfiling', 'off');   % Measure task execution time
cs.set_param('CodeProfilingInstrumentation', 'off');   % Measure function execution times
cs.set_param('CodeCoverageSettings', coder.coverage.CodeCoverageSettings([],'off','off','None'));   % Third-party tool
cs.set_param('SILDebugging', 'off');   % Enable source-level debugging for SIL
cs.set_param('GenerateTraceInfo', 'on');   % Model-to-code
cs.set_param('GenerateTraceReport', 'on');   % Eliminated / virtual blocks
cs.set_param('GenerateTraceReportSl', 'on');   % Traceable Simulink blocks
cs.set_param('GenerateTraceReportSf', 'on');   % Traceable Stateflow objects
cs.set_param('GenerateTraceReportEml', 'on');   % Traceable MATLAB functions
cs.set_param('GenerateWebview', 'off');   % Generate model Web view
cs.set_param('GenerateCodeMetricsReport', 'off');   % Generate static code metrics
cs.set_param('GenerateCodeReplacementReport', 'off');   % Summarize which blocks triggered code replacements
cs.set_param('ObjectivePriorities', {'Execution efficiency','Traceability','MISRA C:2012 guidelines'});   % Prioritized objectives
cs.set_param('RTWCustomCompilerOptimizations', '-O3');   % Custom compiler optimization flags
cs.set_param('CheckMdlBeforeBuild', 'Off');   % Check model before generating code
cs.set_param('GenerateComments', 'on');   % Include comments
cs.set_param('ForceParamTrailComments', 'on');   % Verbose comments for 'Model default' storage class
cs.set_param('CommentStyle', 'Auto');   % Comment style
cs.set_param('IgnoreCustomStorageClasses', 'off');   % Ignore custom storage classes
cs.set_param('IgnoreTestpoints', 'off');   % Ignore test point signals
cs.set_param('MaxIdLength', 80);   % Maximum identifier length
cs.set_param('ShowEliminatedStatement', 'on');   % Show eliminated blocks
cs.set_param('OperatorAnnotations', 'on');   % Operator annotations
cs.set_param('SimulinkDataObjDesc', 'on');   % Simulink data object descriptions
cs.set_param('SFDataObjDesc', 'on');   % Stateflow object descriptions
cs.set_param('MATLABFcnDesc', 'off');   % MATLAB user comments
cs.set_param('MangleLength', 1);   % Minimum mangle length
cs.set_param('SharedChecksumLength', 8);   % Shared checksum length
cs.set_param('CustomSymbolStrGlobalVar', '$R$N$M');   % Global variables
cs.set_param('CustomSymbolStrType', '$N$R$M_T');   % Global types
cs.set_param('CustomSymbolStrField', '$N$M');   % Field name of global types
cs.set_param('CustomSymbolStrFcn', '$R$N$M$F');   % Subsystem methods
cs.set_param('CustomSymbolStrFcnArg', 'rt$I$N$M');   % Subsystem method arguments
cs.set_param('CustomSymbolStrBlkIO', 'rtb_$N$M');   % Local block output variables
cs.set_param('CustomSymbolStrTmpVar', '$N$M');   % Local temporary variables
cs.set_param('CustomSymbolStrMacro', '$R$N$M');   % Constant macros
cs.set_param('CustomSymbolStrUtil', '$N$C');   % Shared utilities identifier format
cs.set_param('CustomSymbolStrEmxType', 'emxArray_$M$N');   % EMX array types identifier format
cs.set_param('CustomSymbolStrEmxFcn', 'emx$M$N');   % EMX array utility functions identifier format
cs.set_param('CustomUserTokenString', '');   % Custom token text
cs.set_param('EnableCustomComments', 'off');   % Custom comments (MPT objects only)
cs.set_param('DefineNamingRule', 'None');   % #define naming
cs.set_param('ParamNamingRule', 'None');   % Parameter naming
cs.set_param('SignalNamingRule', 'None');   % Signal naming
cs.set_param('InsertBlockDesc', 'on');   % Simulink block descriptions
cs.set_param('InsertPolySpaceComments', 'off');   % Insert Polyspace comments
cs.set_param('SimulinkBlockComments', 'on');   % Simulink block comments
cs.set_param('StateflowObjectComments', 'off');   % Stateflow object comments
cs.set_param('BlockCommentType', 'BlockPathComment');   % Trace to model using
cs.set_param('MATLABSourceComments', 'off');   % MATLAB source code as comments
cs.set_param('InternalIdentifier', 'Shortened');   % System-generated identifiers
cs.set_param('InlinedPrmAccess', 'Literals');   % Generate scalar inlined parameters as
cs.set_param('ReqsInCode', 'off');   % Requirements in block comments
cs.set_param('UseSimReservedNames', 'off');   % Use the same reserved names as Simulation Target
cs.set_param('ReservedNameArray', []);   % Reserved names
cs.set_param('EnumMemberNameClash', 'error');   % Duplicate enumeration member names
cs.set_param('TargetLibSuffix', '');   % Suffix applied to target library name
cs.set_param('TargetPreCompLibLocation', '');   % Precompiled library location
cs.set_param('TargetLangStandard', 'C99 (ISO)');   % Standard math library
cs.set_param('CodeReplacementLibrary', 'None');   % Code replacement library
cs.set_param('UtilityFuncGeneration', 'Auto');   % Shared code placement
cs.set_param('MultiwordTypeDef', 'System defined');   % Multiword type definitions
cs.set_param('DynamicStringBufferSize', 256);   % Buffer size of dynamically-sized string (bytes)
cs.set_param('GenerateFullHeader', 'on');   % Generate full file banner
cs.set_param('InferredTypesCompatibility', 'off');   % Create preprocessor directive in rtwtypes.h
cs.set_param('GenerateSampleERTMain', 'off');   % Generate an example main program
cs.set_param('IncludeMdlTerminateFcn', 'on');   % Terminate function required
cs.set_param('GRTInterface', 'off');   % Classic call interface
cs.set_param('CombineOutputUpdateFcns', 'on');   % Single output/update function
cs.set_param('CombineSignalStateStructs', 'off');   % Combine signal/state structures
cs.set_param('MatFileLogging', 'off');   % MAT-file logging
cs.set_param('SuppressErrorStatus', 'on');   % Remove error status field in real-time model data structure
cs.set_param('IncludeFileDelimiter', 'Auto');   % #include file delimiter
cs.set_param('ERTCustomFileBanners', 'on');   % Enable custom file banner
cs.set_param('SupportAbsoluteTime', 'on');   % Support absolute time
cs.set_param('PurelyIntegerCode', 'off');   % Support floating-point numbers
cs.set_param('SupportNonFinite', 'off');   % Support non-finite numbers
cs.set_param('SupportComplex', 'on');   % Support complex numbers
cs.set_param('SupportContinuousTime', 'off');   % Support continuous time
cs.set_param('SupportNonInlinedSFcns', 'off');   % Support non-inlined S-functions
cs.set_param('RemoveDisableFunc', 'off');   % Remove disable function
cs.set_param('SupportVariableSizeSignals', 'off');   % Support variable-size signals
cs.set_param('ParenthesesLevel', 'Nominal');   % Parentheses level
cs.set_param('CastingMode', 'Nominal');   % Casting modes
cs.set_param('ArrayLayout', 'Column-major');   % Array layout
cs.set_param('LUTObjectStructOrderExplicitValues', 'Size,Breakpoints,Table');   % LUT object struct order for explicit value specification
cs.set_param('LUTObjectStructOrderEvenSpacing', 'Size,Breakpoints,Table');   % LUT object struct order for even spacing specification
cs.set_param('ERTHeaderFileRootName', '$R$E');   % Header files
cs.set_param('ERTSourceFileRootName', '$R$E');   % Source files
cs.set_param('ERTFilePackagingFormat', 'Modular');   % File packaging format
cs.set_param('ERTDataFileRootName', '$R_data');   % Data files
cs.set_param('GlobalDataDefinition', 'Auto');   % Data definition
cs.set_param('GlobalDataReference', 'Auto');   % Data declaration
cs.set_param('ExtMode', 'off');   % External mode
cs.set_param('ExtModeTransport', 0);   % Transport layer
cs.set_param('ExtModeMexFile', 'ext_comm');   % MEX-file name
cs.set_param('ExtModeStaticAlloc', 'off');   % Static memory allocation
cs.set_param('MemSecPackage', '--- None ---');   % Memory sections package for model data and functions
cs.set_param('MemSecFuncSharedUtil', 'Default');   % Memory section for shared utility functions
cs.set_param('MemSecFuncInitTerm', 'Default');   % Memory section for initialize/terminate functions
cs.set_param('MemSecFuncExecute', 'Default');   % Memory section for execution functions
cs.set_param('MemSecDataParameters', 'Default');   % Memory section for parameters
cs.set_param('MemSecDataInternal', 'Default');   % Memory section for internal data
cs.set_param('MemSecDataIO', 'Default');   % Memory section for inputs/outputs
cs.set_param('MemSecDataConstants', 'Default');   % Memory section for constants
cs.set_param('EnableUserReplacementTypes', 'off');   % Replace data type names in the generated code
cs.set_param('ConvertIfToSwitch', 'on');   % Convert if-elseif-else patterns to switch-case statements
cs.set_param('ERTCustomFileTemplate', 'example_file_process.tlc');   % File customization template
cs.set_param('ERTDataHdrFileTemplate', 'ert_code_template.cgt');   % Header file template
cs.set_param('ERTDataSrcFileTemplate', 'ert_code_template.cgt');   % Source file template
cs.set_param('RateTransitionBlockCode', 'Inline');   % Rate Transition block code
cs.set_param('ERTHdrFileBannerTemplate', 'ert_code_template.cgt');   % Header file template
cs.set_param('ERTSrcFileBannerTemplate', 'ert_code_template.cgt');   % Source file template
cs.set_param('EnableDataOwnership', 'off');   % Use owner from data object for data definition placement
cs.set_param('ExtModeIntrfLevel', 'Level1');   % External mode interface level
cs.set_param('ExtModeMexArgs', '');   % MEX-file arguments
cs.set_param('ExtModeTesting', 'off');   % External mode testing
cs.set_param('GenerateASAP2', 'off');   % ASAP2 interface
cs.set_param('IndentSize', '2');   % Indent size
cs.set_param('IndentStyle', 'K&R');   % Indent style
cs.set_param('NewlineStyle', 'Default');   % Newline style
cs.set_param('MaxLineWidth', 80);   % Maximum line width
cs.set_param('MultiInstanceErrorCode', 'Error');   % Multi-instance code error diagnostic
cs.set_param('ParamTuneLevel', 10);   % Parameter tune level
cs.set_param('EnableSignedLeftShifts', 'on');   % Replace multiplications by powers of two with signed bitwise shifts
cs.set_param('EnableSignedRightShifts', 'on');   % Allow right shifts on signed integers
cs.set_param('PreserveExpressionOrder', 'off');   % Preserve operand order in expression
cs.set_param('PreserveExternInFcnDecls', 'on');   % Preserve extern keyword in function declarations
cs.set_param('PreserveIfCondition', 'off');   % Preserve condition expression in if statement
cs.set_param('RTWCAPIParams', 'on');   % Generate C API for parameters
cs.set_param('RTWCAPIRootIO', 'on');   % Generate C API for root-level I/O
cs.set_param('RTWCAPISignals', 'off');   % Generate C API for signals
cs.set_param('RTWCAPIStates', 'off');   % Generate C API for states
cs.set_param('RootIOFormat', 'Part of model data structure');   % Pass root-level I/O as
cs.set_param('SignalDisplayLevel', 10);   % Signal display level
cs.set_param('SuppressUnreachableDefaultCases', 'on');   % Suppress generation of default cases for Stateflow switch statements if unreachable
cs.set_param('BooleanTrueId', 'true');   % Boolean true identifier
cs.set_param('BooleanFalseId', 'false');   % Boolean false identifier
cs.set_param('MaxIdInt32', 'MAX_int32_T');   % 32-bit integer maximum identifier
cs.set_param('MinIdInt32', 'MIN_int32_T');   % 32-bit integer minimum identifier
cs.set_param('MaxIdUint32', 'MAX_uint32_T');   % 32-bit unsigned integer maximum identifier
cs.set_param('MaxIdInt16', 'MAX_int16_T');   % 16-bit integer maximum identifier
cs.set_param('MinIdInt16', 'MIN_int16_T');   % 16-bit integer minimum identifier
cs.set_param('MaxIdUint16', 'MAX_uint16_T');   % 16-bit unsigned integer maximum identifier
cs.set_param('MaxIdInt8', 'MAX_int8_T');   % 8-bit integer maximum identifier
cs.set_param('MinIdInt8', 'MIN_int8_T');   % 8-bit integer minimum identifier
cs.set_param('MaxIdUint8', 'MAX_uint8_T');   % 8-bit unsigned integer maximum identifier
cs.set_param('MaxIdInt64', 'MAX_int64_T');   % 64-bit integer maximum identifier
cs.set_param('MinIdInt64', 'MIN_int64_T');   % 64-bit integer minimum identifier
cs.set_param('MaxIdUint64', 'MAX_uint64_T');   % 64-bit unsigned integer maximum identifier
cs.set_param('TypeLimitIdReplacementHeaderFile', '');   % Type limit identifier replacement header file
cs.set_param('DSAsUniqueAccess', 'off');   % Implement each data store block as a unique access point

% Simulink Coverage
cs.set_param('CovModelRefEnable', 'off');   % Record coverage for referenced models
cs.set_param('RecordCoverage', 'off');   % Record coverage for this model
cs.set_param('CovEnable', 'off');   % Enable coverage analysis

% Custom component
try
  cs_componentCC = Simulink.CustomCC;
  cs.attachComponent(cs_componentCC);

catch ME
  warning('Simulink:ConfigSet:AttachComponentError', ME.message);
end
