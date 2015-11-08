{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectActionCompilerDirective;

interface

uses
  uObjectAction, uDMList, uObjectDaoCompilerDirective, Classes, Forms, SysUtils,
  uConstantCompilerDirective, TypInfo,
  uConstantUtils, uDMUtils, uObjectActionCommand;

type
  TCompilerDirective = class(TItemCommand)
  public
    function GetCommand: string; Override;
  end;

  TListCompilerDirective = class(TListCommand)
  public
    /// <summary>
    /// Adiciona a lista todas as diretivas de compilação do delphi
    /// </summary>
    procedure ImportAll; Override;
  end;

  TCompilerDirectiveAlign_fields = class(TCompilerDirective)
  end;

  TCompilerDirectiveAlign_fieldsAAddition = class
    (TCompilerDirectiveAlign_fields)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveAlign_fieldsASubtraction = class
    (TCompilerDirectiveAlign_fields)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveAlign_fieldsA1 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsA2 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsA4 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsA8 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsA16 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_ON = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_OFF = class
    (TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_1 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_2 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_4 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_8 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveAlign_fieldsALIGN_16 = class(TCompilerDirectiveAlign_fields)
  end;

  TCompilerDirectiveApplication_type = class(TCompilerDirective)
  end;

  TCompilerDirectiveApplication_typeAPPTYPE_GUI = class
    (TCompilerDirectiveApplication_type)
  end;

  TCompilerDirectiveApplication_typeAPPTYPE_CONSOLE = class
    (TCompilerDirectiveApplication_type)
  end;

  TCompilerDirectiveAssert_Directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveAssert_DirectiveCAddition = class
    (TCompilerDirectiveAssert_Directive)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveAssert_DirectiveCSubtraction = class
    (TCompilerDirectiveAssert_Directive)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveAssert_DirectiveASSERTIONS_ON = class
    (TCompilerDirectiveAssert_Directive)
  end;

  TCompilerDirectiveAssert_DirectiveASSERTIONS_OFF = class
    (TCompilerDirectiveAssert_Directive)
  end;

  TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluation = class
    (TCompilerDirective)
  end;

  TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBAddition = class
    (TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluation)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBSubtraction =
    class(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluation)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBOOLEVAL_ON =
    class(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluation)
  end;

  TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBOOLEVAL_OFF =
    class(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluation)
  end;

  TCompilerDirectiveCode_align = class(TCompilerDirective)
  end;

  TCompilerDirectiveCode_alignCODEALIGN_n = class(TCompilerDirectiveCode_align)
  end;

  TCompilerDirectiveConditional_compilation = class(TCompilerDirective)
  end;

  TCompilerDirectiveConditional_compilationIFDEF = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationIFNDEF = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationIF = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationELSEIF = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationELSE = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationENDIF = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationIFEND = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveConditional_compilationIFOPT = class
    (TCompilerDirectiveConditional_compilation)
  end;

  TCompilerDirectiveDebug_information = class(TCompilerDirective)
  end;

  TCompilerDirectiveDebug_informationDAddition = class
    (TCompilerDirectiveDebug_information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveDebug_informationDSubtraction = class
    (TCompilerDirectiveDebug_information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveDebug_informationDEBUGINFO_ON = class
    (TCompilerDirectiveDebug_information)
  end;

  TCompilerDirectiveDebug_informationDEBUGINFO_OFF = class
    (TCompilerDirectiveDebug_information)
  end;

  TCompilerDirectiveDEFINE_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveDEFINE_directiveDEFINE_DMSymbol = class
    (TCompilerDirectiveDEFINE_directive)
  end;

  TCompilerDirectiveDENYPACKAGEUNIT_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveDENYPACKAGEUNIT_directiveDENYPACKAGEUNIT_ON = class
    (TCompilerDirectiveDENYPACKAGEUNIT_directive)
  end;

  TCompilerDirectiveDENYPACKAGEUNIT_directiveDENYPACKAGEUNIT_OFF = class
    (TCompilerDirectiveDENYPACKAGEUNIT_directive)
  end;

  TCompilerDirectiveDescription = class(TCompilerDirective)
  end;

  TCompilerDirectiveDescriptionDESCRIPTION_DMStrSymbol = class
    (TCompilerDirectiveDescription)
  end;

  TCompilerDirectiveDESIGNONLY_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveDESIGNONLY_directiveDESIGNONLY_ON = class
    (TCompilerDirectiveDESIGNONLY_directive)
  end;

  TCompilerDirectiveDESIGNONLY_directiveDESIGNONLY_OFF = class
    (TCompilerDirectiveDESIGNONLY_directive)
  end;

  TCompilerDirectiveELSE = class(TCompilerDirective)
  end;

  TCompilerDirectiveELSEIF = class(TCompilerDirective)
  end;

  TCompilerDirectiveENDIF = class(TCompilerDirective)
  end;

  TCompilerDirectiveExecutable_extension = class(TCompilerDirective)
  end;

  TCompilerDirectiveExecutable_extensionE_extension = class
    (TCompilerDirectiveExecutable_extension)
  end;

  TCompilerDirectiveExecutable_extensionEXTENSION_extension = class
    (TCompilerDirectiveExecutable_extension)
  end;

  TCompilerDirectiveExport_symbols = class(TCompilerDirective)
  end;

  TCompilerDirectiveExport_symbolsObjExportAll_On = class
    (TCompilerDirectiveExport_symbols)
  end;

  TCompilerDirectiveExport_symbolsObjExportAll_Off = class
    (TCompilerDirectiveExport_symbols)
  end;

  TCompilerDirectiveExtended_syntax = class(TCompilerDirective)
  end;

  TCompilerDirectiveExtended_syntaxXAddition = class
    (TCompilerDirectiveExtended_syntax)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveExtended_syntaxXSubtraction = class
    (TCompilerDirectiveExtended_syntax)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveExtended_syntaxEXTENDEDSYNTAX_ON = class
    (TCompilerDirectiveExtended_syntax)
  end;

  TCompilerDirectiveExtended_syntaxEXTENDEDSYNTAX_OFF = class
    (TCompilerDirectiveExtended_syntax)
  end;

  TCompilerDirectiveExtended_type_compatibility = class(TCompilerDirective)
  end;

  TCompilerDirectiveExtended_type_compatibilityEXTENDEDCOMPATIBILITY_ON = class
    (TCompilerDirectiveExtended_type_compatibility)
  end;

  TCompilerDirectiveExtended_type_compatibilityEXTENDEDCOMPATIBILITY_OFF = class
    (TCompilerDirectiveExtended_type_compatibility)
  end;

  TCompilerDirectiveFloating_point_precision_control = class(TCompilerDirective)
  end;

  TCompilerDirectiveFloating_point_precision_controlEXCESSPRECISION_ON = class
    (TCompilerDirectiveFloating_point_precision_control)
  end;

  TCompilerDirectiveFloating_point_precision_controlEXCESSPRECISION_OFF = class
    (TCompilerDirectiveFloating_point_precision_control)
  end;

  TCompilerDirectiveHIGHCHARUNICODE_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveHIGHCHARUNICODE_directiveHIGHCHARUNICODE_ON = class
    (TCompilerDirectiveHIGHCHARUNICODE_directive)
  end;

  TCompilerDirectiveHIGHCHARUNICODE_directiveHIGHCHARUNICODE_OFF = class
    (TCompilerDirectiveHIGHCHARUNICODE_directive)
  end;

  TCompilerDirectiveHints = class(TCompilerDirective)
  end;

  TCompilerDirectiveHintsHINTS_ON = class(TCompilerDirectiveHints)
  end;

  TCompilerDirectiveHintsHINTS_OFF = class(TCompilerDirectiveHints)
  end;

  TCompilerDirectiveHPPEMIT_DMStrSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveIFDEF_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveIF_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveIFEND = class(TCompilerDirective)
  end;

  TCompilerDirectiveIFNDEF_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveIFOPT_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveIMAGEBASE_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveImplicit_Build = class(TCompilerDirective)
  end;

  TCompilerDirectiveImplicit_BuildIMPLICITBUILD_ON = class
    (TCompilerDirectiveImplicit_Build)
  end;

  TCompilerDirectiveImplicit_BuildIMPLICITBUILD_OFF = class
    (TCompilerDirectiveImplicit_Build)
  end;

  TCompilerDirectiveImported_data = class(TCompilerDirective)
  end;

  TCompilerDirectiveImported_dataGAddition = class
    (TCompilerDirectiveImported_data)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveImported_dataGSubtraction = class
    (TCompilerDirectiveImported_data)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveImported_dataIMPORTEDDATA_ON = class
    (TCompilerDirectiveImported_data)
  end;

  TCompilerDirectiveImported_dataIMPORTEDDATA_OFF = class
    (TCompilerDirectiveImported_data)
  end;

  TCompilerDirectiveInclude_file = class(TCompilerDirective)
  end;

  TCompilerDirectiveInclude_fileI_DMStrSymbol = class
    (TCompilerDirectiveInclude_file)
  end;

  TCompilerDirectiveInclude_fileINCLUDE_DMStrSymbol = class
    (TCompilerDirectiveInclude_file)
  end;

  TCompilerDirectiveEXTERNALSYM_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveInput_output_checking = class(TCompilerDirective)
  end;

  TCompilerDirectiveInput_output_checkingIAddition = class
    (TCompilerDirectiveInput_output_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveInput_output_checkingISubtraction = class
    (TCompilerDirectiveInput_output_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveInput_output_checkingIOCHECKS_ON = class
    (TCompilerDirectiveInput_output_checking)
  end;

  TCompilerDirectiveInput_output_checkingIOCHECKS_OFF = class
    (TCompilerDirectiveInput_output_checking)
  end;

  TCompilerDirectiveCompiler_Directive_for_libraries = class(TCompilerDirective)
  end;

  TCompilerDirectiveCompiler_Directive_for_librariesshared_objects = class
    (TCompilerDirectiveCompiler_Directive_for_libraries)
  end;

  TCompilerDirectiveCompiler_Directive_for_librariesLIBPREFIX_DMStrSymbol =
    class(TCompilerDirectiveCompiler_Directive_for_libraries)
  end;

  TCompilerDirectiveCompiler_Directive_for_librariesLIBSUFFIX_DMStrSymbol =
    class(TCompilerDirectiveCompiler_Directive_for_libraries)
  end;

  TCompilerDirectiveCompiler_Directive_for_librariesLIBVERSION_DMStrSymbol =
    class(TCompilerDirectiveCompiler_Directive_for_libraries)
  end;

  TCompilerDirectiveLEGACYIFEND = class(TCompilerDirective)
  end;

  TCompilerDirectiveLink_object_file = class(TCompilerDirective)
  end;

  TCompilerDirectiveLink_object_fileL_filename = class
    (TCompilerDirectiveLink_object_file)
  end;

  TCompilerDirectiveLink_object_fileLINK_filename = class
    (TCompilerDirectiveLink_object_file)
  end;

  TCompilerDirectiveLocal_symbol_information = class(TCompilerDirective)
  end;

  TCompilerDirectiveLocal_symbol_informationLAddition = class
    (TCompilerDirectiveLocal_symbol_information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveLocal_symbol_informationLSubtraction = class
    (TCompilerDirectiveLocal_symbol_information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveLocal_symbol_informationLOCALSYMBOLS_ON = class
    (TCompilerDirectiveLocal_symbol_information)
  end;

  TCompilerDirectiveLocal_symbol_informationLOCALSYMBOLS_OFF = class
    (TCompilerDirectiveLocal_symbol_information)
  end;

  TCompilerDirectiveLong_strings = class(TCompilerDirective)
  end;

  TCompilerDirectiveLong_stringsHAddition = class
    (TCompilerDirectiveLong_strings)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveLong_stringsHSubtraction = class
    (TCompilerDirectiveLong_strings)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveLong_stringsLONGSTRINGS_ON = class
    (TCompilerDirectiveLong_strings)
  end;

  TCompilerDirectiveLong_stringsLONGSTRINGS_OFF = class
    (TCompilerDirectiveLong_strings)
  end;

  TCompilerDirectiveMemory_allocation_sizes = class(TCompilerDirective)
  end;

  TCompilerDirectiveMemory_allocation_sizesM_DMSymbol = class
    (TCompilerDirectiveMemory_allocation_sizes)
  end;

  TCompilerDirectiveMemory_allocation_sizesMINSTACKSIZE_DMSymbol = class
    (TCompilerDirectiveMemory_allocation_sizes)
  end;

  TCompilerDirectiveMemory_allocation_sizesMAXSTACKSIZE_DMSymbol = class
    (TCompilerDirectiveMemory_allocation_sizes)
  end;

  TCompilerDirectiveMESSAGE_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveMESSAGE_HINT_DMStrSymbol = class
    (TCompilerDirectiveMESSAGE_directive)
  end;

  TCompilerDirectiveMESSAGE_WARN_DMStrSymbol = class
    (TCompilerDirectiveMESSAGE_directive)
  end;

  TCompilerDirectiveMESSAGE_ERROR_DMStrSymbol = class
    (TCompilerDirectiveMESSAGE_directive)
  end;

  TCompilerDirectiveMESSAGE_FATAL_DMStrSymbol = class
    (TCompilerDirectiveMESSAGE_directive)
  end;

  TCompilerDirectiveMESSAGE_directiveMESSAGE_DMStrSymbol = class
    (TCompilerDirectiveMESSAGE_directive)
  end;

  TCompilerDirectiveMETHODINFO_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveMETHODINFO_directiveMETHODINFO_ON = class
    (TCompilerDirectiveMETHODINFO_directive)
  end;

  TCompilerDirectiveMETHODINFO_directiveMETHODINFO_OFF = class
    (TCompilerDirectiveMETHODINFO_directive)
  end;

  TCompilerDirectiveMinimum_enumeration_size = class(TCompilerDirective)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeZ1 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeZ2 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeZ4 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_1 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_2 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_4 = class
    (TCompilerDirectiveMinimum_enumeration_size)
  end;

  TCompilerDirectiveNODEFINE_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveNODEFINE_directiveNODEFINE_DMSymbol = class
    (TCompilerDirectiveNODEFINE_directive)
  end;

  TCompilerDirectiveNOINCLUDE_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveOBJTYPENAME_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveOpen_String_Parameters = class(TCompilerDirective)
  end;

  TCompilerDirectiveOpen_String_ParametersPAddition = class
    (TCompilerDirectiveOpen_String_Parameters)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOpen_String_ParametersPSubtraction = class
    (TCompilerDirectiveOpen_String_Parameters)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOpen_String_ParametersOPENSTRINGS_ON = class
    (TCompilerDirectiveOpen_String_Parameters)
  end;

  TCompilerDirectiveOpen_String_ParametersOPENSTRINGS_OFF = class
    (TCompilerDirectiveOpen_String_Parameters)
  end;

  TCompilerDirectiveOptimization = class(TCompilerDirective)
  end;

  TCompilerDirectiveOptimizationOAddition = class
    (TCompilerDirectiveOptimization)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOptimizationOSubtraction = class
    (TCompilerDirectiveOptimization)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOptimizationOPTIMIZATION_ON = class
    (TCompilerDirectiveOptimization)
  end;

  TCompilerDirectiveOptimizationOPTIMIZATION_OFF = class
    (TCompilerDirectiveOptimization)
  end;

  TCompilerDirectiveOverflow_checking = class(TCompilerDirective)
  end;

  TCompilerDirectiveOverflow_checkingQAddition = class
    (TCompilerDirectiveOverflow_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOverflow_checkingQSubtraction = class
    (TCompilerDirectiveOverflow_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveOverflow_checkingOVERFLOWCHECKS_ON = class
    (TCompilerDirectiveOverflow_checking)
  end;

  TCompilerDirectiveOverflow_checkingOVERFLOWCHECKS_OFF = class
    (TCompilerDirectiveOverflow_checking)
  end;

  TCompilerDirectiveportable_executable = class(TCompilerDirective)
  end;

  TCompilerDirectiveportable_executableSetPEFlags_DMSymbol = class
    (TCompilerDirectiveportable_executable)
  end;

  TCompilerDirectiveportable_executableSetPEOptFlags_DMSymbol = class
    (TCompilerDirectiveportable_executable)
  end;

  TCompilerDirectivePentiumSubtractionsafe_FDIV_operations = class
    (TCompilerDirective)
  end;

  TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUAddition = class
    (TCompilerDirectivePentiumSubtractionsafe_FDIV_operations)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUSubtraction = class
    (TCompilerDirectivePentiumSubtractionsafe_FDIV_operations)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsSAFEDIVIDE_ON = class
    (TCompilerDirectivePentiumSubtractionsafe_FDIV_operations)
  end;

  TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsSAFEDIVIDE_OFF = class
    (TCompilerDirectivePentiumSubtractionsafe_FDIV_operations)
  end;

  TCompilerDirectivePointer_Math = class(TCompilerDirective)
  end;

  TCompilerDirectivePointer_MathPOINTERMATH_ON = class
    (TCompilerDirectivePointer_Math)
  end;

  TCompilerDirectivePointer_MathPOINTERMATH_OFF = class
    (TCompilerDirectivePointer_Math)
  end;

  TCompilerDirectiveRange_checking = class(TCompilerDirective)
  end;

  TCompilerDirectiveRange_checkingRAddition = class
    (TCompilerDirectiveRange_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveRange_checkingRSubtraction = class
    (TCompilerDirectiveRange_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveRange_checkingRANGECHECKS_ON = class
    (TCompilerDirectiveRange_checking)
  end;

  TCompilerDirectiveRange_checkingRANGECHECKS_OFF = class
    (TCompilerDirectiveRange_checking)
  end;

  TCompilerDirectiveReal48_compatibility = class(TCompilerDirective)
  end;

  TCompilerDirectiveReal48_compatibilityREALCOMPATIBILITY_ON = class
    (TCompilerDirectiveReal48_compatibility)
  end;

  TCompilerDirectiveReal48_compatibilityREALCOMPATIBILITY_OFF = class
    (TCompilerDirectiveReal48_compatibility)
  end;

  TCompilerDirectiveRegions = class(TCompilerDirective)
  end;

  TCompilerDirectiveRegionsREGION_DMStrSymbol = class(TCompilerDirectiveRegions)
  end;

  TCompilerDirectiveRegionsENDREGION = class(TCompilerDirectiveRegions)
  end;

  TCompilerDirectiveResource_file = class(TCompilerDirective)
  end;

  TCompilerDirectiveResource_fileR_DMStrSymbol = class
    (TCompilerDirectiveResource_file)
  end;

  TCompilerDirectiveResource_fileRESOURCE_DMStrSymbol = class
    (TCompilerDirectiveResource_file)
  end;

  TCompilerDirectiveRTTI_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveRTTI_directiveRTTI_DMSymbol = class
    (TCompilerDirectiveRTTI_directive)
  end;

  TCompilerDirectiveRUNONLY_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveRUNONLY_directiveRUNONLY_ON = class
    (TCompilerDirectiveRUNONLY_directive)
  end;

  TCompilerDirectiveRUNONLY_directiveRUNONLY_OFF = class
    (TCompilerDirectiveRUNONLY_directive)
  end;

  TCompilerDirectiveRunSubtractionTime_Type_Information = class
    (TCompilerDirective)
  end;

  TCompilerDirectiveRunSubtractionTime_Type_InformationMAddition = class
    (TCompilerDirectiveRunSubtractionTime_Type_Information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveRunSubtractionTime_Type_InformationMSubtraction = class
    (TCompilerDirectiveRunSubtractionTime_Type_Information)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveRunSubtractionTime_Type_InformationTYPEINFO_ON = class
    (TCompilerDirectiveRunSubtractionTime_Type_Information)
  end;

  TCompilerDirectiveRunSubtractionTime_Type_InformationTYPEINFO_OFF = class
    (TCompilerDirectiveRunSubtractionTime_Type_Information)
  end;

  TCompilerDirectivecoped_Enums = class(TCompilerDirective)
  end;

  TCompilerDirectivecoped_EnumsSCOPEDENUMS_ON = class
    (TCompilerDirectivecoped_Enums)
  end;

  TCompilerDirectivecoped_Enumsor = class(TCompilerDirectivecoped_Enums)
  end;

  TCompilerDirectivecoped_EnumsSCOPEDENUMS_OFF = class
    (TCompilerDirectivecoped_Enums)
  end;

  TCompilerDirectivetack_frames = class(TCompilerDirective)
  end;

  TCompilerDirectivetack_framesWAddition = class(TCompilerDirectivetack_frames)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectivetack_framesWSubtraction = class
    (TCompilerDirectivetack_frames)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectivetack_framesSTACKFRAMES_ON = class
    (TCompilerDirectivetack_frames)
  end;

  TCompilerDirectivetack_framesSTACKFRAMES_OFF = class
    (TCompilerDirectivetack_frames)
  end;

  TCompilerDirectivetrong_link_types = class(TCompilerDirective)
  end;

  TCompilerDirectivetrong_link_typesSTRONGLINKTYPES_ON = class
    (TCompilerDirectivetrong_link_types)
  end;

  TCompilerDirectivetrong_link_typesSTRONGLINKTYPES_OFF = class
    (TCompilerDirectivetrong_link_types)
  end;

  TCompilerDirectiveymbol_declaration = class(TCompilerDirective)
  end;

  TCompilerDirectiveymbol_declarationcrossSubtractionreference_information =
    class(TCompilerDirectiveymbol_declaration)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveymbol_declarationYAddition = class
    (TCompilerDirectiveymbol_declaration)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveymbol_declarationYSubtraction = class
    (TCompilerDirectiveymbol_declaration)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveymbol_declarationor = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveymbol_declarationYD = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveymbol_declarationREFERENCEINFO_ON = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveymbol_declarationDEFINITIONINFO_OFF = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveymbol_declarationREFERENCEINFO_OFF = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveymbol_declarationor_DEFINITIONINFO_ON = class
    (TCompilerDirectiveymbol_declaration)
  end;

  TCompilerDirectiveTypeSubtractionchecked_pointers = class(TCompilerDirective)
  end;

  TCompilerDirectiveTypeSubtractionchecked_pointersTAddition = class
    (TCompilerDirectiveTypeSubtractionchecked_pointers)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveTypeSubtractionchecked_pointersTSubtraction = class
    (TCompilerDirectiveTypeSubtractionchecked_pointers)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveTypeSubtractionchecked_pointersTYPEDADDRESS_ON = class
    (TCompilerDirectiveTypeSubtractionchecked_pointers)
  end;

  TCompilerDirectiveTypeSubtractionchecked_pointersTYPEDADDRESS_OFF = class
    (TCompilerDirectiveTypeSubtractionchecked_pointers)
  end;

  TCompilerDirectiveUNDEF_DMSymbol = class(TCompilerDirective)
  end;

  TCompilerDirectiveVarSubtractionstring_checking = class(TCompilerDirective)
  end;

  TCompilerDirectiveVarSubtractionstring_checkingVAddition = class
    (TCompilerDirectiveVarSubtractionstring_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveVarSubtractionstring_checkingVSubtraction = class
    (TCompilerDirectiveVarSubtractionstring_checking)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveVarSubtractionstring_checkingVARSTRINGCHECKS_ON = class
    (TCompilerDirectiveVarSubtractionstring_checking)
  end;

  TCompilerDirectiveVarSubtractionstring_checkingVARSTRINGCHECKS_OFF = class
    (TCompilerDirectiveVarSubtractionstring_checking)
  end;

  TCompilerDirectiveWarning_messages = class(TCompilerDirective)
  end;

  TCompilerDirectiveWarning_messagesWARN_DMSymbol = class
    (TCompilerDirectiveWarning_messages)
  end;

  TCompilerDirectiveWarnings = class(TCompilerDirective)
  end;

  TCompilerDirectiveWarningsWARNINGS_ON = class(TCompilerDirectiveWarnings)
  end;

  TCompilerDirectiveWarningsWARNINGS_OFF = class(TCompilerDirectiveWarnings)
  end;

  TCompilerDirectiveWeak_packaging = class(TCompilerDirective)
  end;

  TCompilerDirectiveWeak_packagingWEAKPACKAGEUNIT_ON = class
    (TCompilerDirectiveWeak_packaging)
  end;

  TCompilerDirectiveWeak_packagingWEAKPACKAGEUNIT_OFF = class
    (TCompilerDirectiveWeak_packaging)
  end;

  TCompilerDirectiveWEAKLINKRTTI_directive = class(TCompilerDirective)
  end;

  TCompilerDirectiveWEAKLINKRTTI_directiveWEAKLINKRTTI_ON = class
    (TCompilerDirectiveWEAKLINKRTTI_directive)
  end;

  TCompilerDirectiveWEAKLINKRTTI_directiveWEAKLINKRTTI_OFF = class
    (TCompilerDirectiveWEAKLINKRTTI_directive)
  end;

  TCompilerDirectiveWriteable_typed_constants = class(TCompilerDirective)
  end;

  TCompilerDirectiveWriteable_typed_constantsJAddition = class
    (TCompilerDirectiveWriteable_typed_constants)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveWriteable_typed_constantsJSubtraction = class
    (TCompilerDirectiveWriteable_typed_constants)
  public
    function GetCommand: string; Override;
  end;

  TCompilerDirectiveWriteable_typed_constantsWRITEABLECONST_ON = class
    (TCompilerDirectiveWriteable_typed_constants)
  end;

  TCompilerDirectiveWriteable_typed_constantsWRITEABLECONST_OFF = class
    (TCompilerDirectiveWriteable_typed_constants)
  end;

  TCompilerDirectiveZeroSubtractionbased_strings = class(TCompilerDirective)
  end;

  TCompilerDirectiveZeroSubtractionbased_stringsZEROBASEDSTRINGS_ON = class
    (TCompilerDirectiveZeroSubtractionbased_strings)
  end;

  TCompilerDirectiveZeroSubtractionbased_stringsZEROBASEDSTRINGS_OFF = class
    (TCompilerDirectiveZeroSubtractionbased_strings)
  end;

  /// <summary>
  /// Controle ação de todas as diretivas do delphi
  /// </summary>
  TObjectActionCompilerDirective = Class(TObjectActionCommand)
  protected
    function GetListCommand: TListCommand; Override;
  public
    FObjectDaoCompilerDirective: TObjectDaoCompilerDirective;

    procedure AfterConstruction; override;
  end;

implementation

procedure TObjectActionCompilerDirective.AfterConstruction;
begin

  inherited;
  FObjectDaoCompilerDirective := GetObjectDao as TObjectDaoCompilerDirective;
end;

{ TListCompilerDirective }

procedure TListCompilerDirective.ImportAll;
begin
  inherited;
  Add(TCompilerDirectiveAlign_fieldsAAddition);
  Add(TCompilerDirectiveAlign_fieldsASubtraction);
  Add(TCompilerDirectiveAlign_fieldsA1);
  Add(TCompilerDirectiveAlign_fieldsA2);
  Add(TCompilerDirectiveAlign_fieldsA4);
  Add(TCompilerDirectiveAlign_fieldsA8);
  Add(TCompilerDirectiveAlign_fieldsA16);
  Add(TCompilerDirectiveAlign_fieldsALIGN_ON);
  Add(TCompilerDirectiveAlign_fieldsALIGN_OFF);
  Add(TCompilerDirectiveAlign_fieldsALIGN_1);
  Add(TCompilerDirectiveAlign_fieldsALIGN_2);
  Add(TCompilerDirectiveAlign_fieldsALIGN_4);
  Add(TCompilerDirectiveAlign_fieldsALIGN_8);
  Add(TCompilerDirectiveAlign_fieldsALIGN_16);
  Add(TCompilerDirectiveApplication_typeAPPTYPE_GUI);
  Add(TCompilerDirectiveApplication_typeAPPTYPE_CONSOLE);
  Add(TCompilerDirectiveAssert_DirectiveCAddition);
  Add(TCompilerDirectiveAssert_DirectiveCSubtraction);
  Add(TCompilerDirectiveAssert_DirectiveASSERTIONS_ON);
  Add(TCompilerDirectiveAssert_DirectiveASSERTIONS_OFF);
  Add(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBAddition);
  Add(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBSubtraction);
  Add(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBOOLEVAL_ON);
  Add(TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBOOLEVAL_OFF);
  Add(TCompilerDirectiveCode_alignCODEALIGN_n);
  Add(TCompilerDirectiveConditional_compilationIFDEF);
  Add(TCompilerDirectiveConditional_compilationIFNDEF);
  Add(TCompilerDirectiveConditional_compilationIF);
  Add(TCompilerDirectiveConditional_compilationELSEIF);
  Add(TCompilerDirectiveConditional_compilationELSE);
  Add(TCompilerDirectiveConditional_compilationENDIF);
  Add(TCompilerDirectiveConditional_compilationIFEND);
  Add(TCompilerDirectiveConditional_compilationIFOPT);
  Add(TCompilerDirectiveDebug_informationDAddition);
  Add(TCompilerDirectiveDebug_informationDSubtraction);
  Add(TCompilerDirectiveDebug_informationDEBUGINFO_ON);
  Add(TCompilerDirectiveDebug_informationDEBUGINFO_OFF);
  Add(TCompilerDirectiveDEFINE_directiveDEFINE_DMSymbol);
  Add(TCompilerDirectiveDENYPACKAGEUNIT_directiveDENYPACKAGEUNIT_ON);
  Add(TCompilerDirectiveDENYPACKAGEUNIT_directiveDENYPACKAGEUNIT_OFF);
  Add(TCompilerDirectiveDescriptionDESCRIPTION_DMStrSymbol);
  Add(TCompilerDirectiveDESIGNONLY_directiveDESIGNONLY_ON);
  Add(TCompilerDirectiveDESIGNONLY_directiveDESIGNONLY_OFF);
  Add(TCompilerDirectiveELSE);
  Add(TCompilerDirectiveELSEIF);
  Add(TCompilerDirectiveENDIF);
  Add(TCompilerDirectiveExecutable_extensionE_extension);
  Add(TCompilerDirectiveExecutable_extensionEXTENSION_extension);
  Add(TCompilerDirectiveExport_symbolsObjExportAll_On);
  Add(TCompilerDirectiveExport_symbolsObjExportAll_Off);
  Add(TCompilerDirectiveExtended_syntaxXAddition);
  Add(TCompilerDirectiveExtended_syntaxXSubtraction);
  Add(TCompilerDirectiveExtended_syntaxEXTENDEDSYNTAX_ON);
  Add(TCompilerDirectiveExtended_syntaxEXTENDEDSYNTAX_OFF);
  Add(TCompilerDirectiveExtended_type_compatibilityEXTENDEDCOMPATIBILITY_ON);
  Add(TCompilerDirectiveExtended_type_compatibilityEXTENDEDCOMPATIBILITY_OFF);
  Add(TCompilerDirectiveFloating_point_precision_controlEXCESSPRECISION_ON);
  Add(TCompilerDirectiveFloating_point_precision_controlEXCESSPRECISION_OFF);
  Add(TCompilerDirectiveHIGHCHARUNICODE_directiveHIGHCHARUNICODE_ON);
  Add(TCompilerDirectiveHIGHCHARUNICODE_directiveHIGHCHARUNICODE_OFF);
  Add(TCompilerDirectiveHintsHINTS_ON);
  Add(TCompilerDirectiveHintsHINTS_OFF);
  Add(TCompilerDirectiveHPPEMIT_DMStrSymbol);
  Add(TCompilerDirectiveIFDEF_DMSymbol);
  Add(TCompilerDirectiveIF_DMSymbol);
  Add(TCompilerDirectiveIFEND);
  Add(TCompilerDirectiveIFNDEF_DMSymbol);
  Add(TCompilerDirectiveIFOPT_DMSymbol);
  Add(TCompilerDirectiveIMAGEBASE_DMSymbol);
  Add(TCompilerDirectiveImplicit_BuildIMPLICITBUILD_ON);
  Add(TCompilerDirectiveImplicit_BuildIMPLICITBUILD_OFF);
  Add(TCompilerDirectiveImported_dataGAddition);
  Add(TCompilerDirectiveImported_dataGSubtraction);
  Add(TCompilerDirectiveImported_dataIMPORTEDDATA_ON);
  Add(TCompilerDirectiveImported_dataIMPORTEDDATA_OFF);
  Add(TCompilerDirectiveInclude_fileI_DMStrSymbol);
  Add(TCompilerDirectiveInclude_fileINCLUDE_DMStrSymbol);
  Add(TCompilerDirectiveEXTERNALSYM_DMSymbol);
  Add(TCompilerDirectiveInput_output_checkingIAddition);
  Add(TCompilerDirectiveInput_output_checkingISubtraction);
  Add(TCompilerDirectiveInput_output_checkingIOCHECKS_ON);
  Add(TCompilerDirectiveInput_output_checkingIOCHECKS_OFF);
  Add(TCompilerDirectiveCompiler_Directive_for_librariesshared_objects);
  Add(TCompilerDirectiveCompiler_Directive_for_librariesLIBPREFIX_DMStrSymbol);
  Add(TCompilerDirectiveCompiler_Directive_for_librariesLIBSUFFIX_DMStrSymbol);
  Add(TCompilerDirectiveCompiler_Directive_for_librariesLIBVERSION_DMStrSymbol);
  Add(TCompilerDirectiveLEGACYIFEND);
  Add(TCompilerDirectiveLink_object_fileL_filename);
  Add(TCompilerDirectiveLink_object_fileLINK_filename);
  Add(TCompilerDirectiveLocal_symbol_informationLAddition);
  Add(TCompilerDirectiveLocal_symbol_informationLSubtraction);
  Add(TCompilerDirectiveLocal_symbol_informationLOCALSYMBOLS_ON);
  Add(TCompilerDirectiveLocal_symbol_informationLOCALSYMBOLS_OFF);
  Add(TCompilerDirectiveLong_stringsHAddition);
  Add(TCompilerDirectiveLong_stringsHSubtraction);
  Add(TCompilerDirectiveLong_stringsLONGSTRINGS_ON);
  Add(TCompilerDirectiveLong_stringsLONGSTRINGS_OFF);
  Add(TCompilerDirectiveMemory_allocation_sizesM_DMSymbol);
  Add(TCompilerDirectiveMemory_allocation_sizesMINSTACKSIZE_DMSymbol);
  Add(TCompilerDirectiveMemory_allocation_sizesMAXSTACKSIZE_DMSymbol);
  Add(TCompilerDirectiveMESSAGE_HINT_DMStrSymbol);
  Add(TCompilerDirectiveMESSAGE_WARN_DMStrSymbol);
  Add(TCompilerDirectiveMESSAGE_ERROR_DMStrSymbol);
  Add(TCompilerDirectiveMESSAGE_FATAL_DMStrSymbol);
  Add(TCompilerDirectiveMESSAGE_directiveMESSAGE_DMStrSymbol);

  Add(TCompilerDirectiveMETHODINFO_directiveMETHODINFO_ON);
  Add(TCompilerDirectiveMETHODINFO_directiveMETHODINFO_OFF);
  Add(TCompilerDirectiveMinimum_enumeration_sizeZ1);
  Add(TCompilerDirectiveMinimum_enumeration_sizeZ2);
  Add(TCompilerDirectiveMinimum_enumeration_sizeZ4);
  Add(TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_1);
  Add(TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_2);
  Add(TCompilerDirectiveMinimum_enumeration_sizeMINENUMSIZE_4);
  Add(TCompilerDirectiveNODEFINE_directiveNODEFINE_DMSymbol);
  Add(TCompilerDirectiveNOINCLUDE_DMSymbol);
  Add(TCompilerDirectiveOBJTYPENAME_DMSymbol);
  Add(TCompilerDirectiveOpen_String_ParametersPAddition);
  Add(TCompilerDirectiveOpen_String_ParametersPSubtraction);
  Add(TCompilerDirectiveOpen_String_ParametersOPENSTRINGS_ON);
  Add(TCompilerDirectiveOpen_String_ParametersOPENSTRINGS_OFF);
  Add(TCompilerDirectiveOptimizationOAddition);
  Add(TCompilerDirectiveOptimizationOSubtraction);
  Add(TCompilerDirectiveOptimizationOPTIMIZATION_ON);
  Add(TCompilerDirectiveOptimizationOPTIMIZATION_OFF);
  Add(TCompilerDirectiveOverflow_checkingQAddition);
  Add(TCompilerDirectiveOverflow_checkingQSubtraction);
  Add(TCompilerDirectiveOverflow_checkingOVERFLOWCHECKS_ON);
  Add(TCompilerDirectiveOverflow_checkingOVERFLOWCHECKS_OFF);
  Add(TCompilerDirectiveportable_executableSetPEFlags_DMSymbol);
  Add(TCompilerDirectiveportable_executableSetPEOptFlags_DMSymbol);
  Add(TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUAddition);
  Add(TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUSubtraction);
  Add(TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsSAFEDIVIDE_ON);
  Add(TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsSAFEDIVIDE_OFF);
  Add(TCompilerDirectivePointer_MathPOINTERMATH_ON);
  Add(TCompilerDirectivePointer_MathPOINTERMATH_OFF);
  Add(TCompilerDirectiveRange_checkingRAddition);
  Add(TCompilerDirectiveRange_checkingRSubtraction);
  Add(TCompilerDirectiveRange_checkingRANGECHECKS_ON);
  Add(TCompilerDirectiveRange_checkingRANGECHECKS_OFF);
  Add(TCompilerDirectiveReal48_compatibilityREALCOMPATIBILITY_ON);
  Add(TCompilerDirectiveReal48_compatibilityREALCOMPATIBILITY_OFF);
  Add(TCompilerDirectiveRegionsREGION_DMStrSymbol);
  Add(TCompilerDirectiveRegionsENDREGION);
  Add(TCompilerDirectiveResource_fileR_DMStrSymbol);
  Add(TCompilerDirectiveResource_fileRESOURCE_DMStrSymbol);
  Add(TCompilerDirectiveRTTI_directiveRTTI_DMSymbol);
  Add(TCompilerDirectiveRUNONLY_directiveRUNONLY_ON);
  Add(TCompilerDirectiveRUNONLY_directiveRUNONLY_OFF);
  Add(TCompilerDirectiveRunSubtractionTime_Type_InformationMAddition);
  Add(TCompilerDirectiveRunSubtractionTime_Type_InformationMSubtraction);
  Add(TCompilerDirectiveRunSubtractionTime_Type_InformationTYPEINFO_ON);
  Add(TCompilerDirectiveRunSubtractionTime_Type_InformationTYPEINFO_OFF);
  Add(TCompilerDirectivecoped_EnumsSCOPEDENUMS_ON);
  Add(TCompilerDirectivecoped_Enumsor);
  Add(TCompilerDirectivecoped_EnumsSCOPEDENUMS_OFF);
  Add(TCompilerDirectivetack_framesWAddition);
  Add(TCompilerDirectivetack_framesWSubtraction);
  Add(TCompilerDirectivetack_framesSTACKFRAMES_ON);
  Add(TCompilerDirectivetack_framesSTACKFRAMES_OFF);
  Add(TCompilerDirectivetrong_link_typesSTRONGLINKTYPES_ON);
  Add(TCompilerDirectivetrong_link_typesSTRONGLINKTYPES_OFF);
  Add(TCompilerDirectiveymbol_declarationcrossSubtractionreference_information);
  Add(TCompilerDirectiveymbol_declarationcrossSubtractionreference_information);
  Add(TCompilerDirectiveymbol_declarationYAddition);
  Add(TCompilerDirectiveymbol_declarationYSubtraction);
  Add(TCompilerDirectiveymbol_declarationor);
  Add(TCompilerDirectiveymbol_declarationYD);
  Add(TCompilerDirectiveymbol_declaration);
  Add(TCompilerDirectiveymbol_declarationREFERENCEINFO_ON);
  Add(TCompilerDirectiveymbol_declarationDEFINITIONINFO_OFF);
  Add(TCompilerDirectiveymbol_declarationREFERENCEINFO_OFF);
  Add(TCompilerDirectiveymbol_declarationor_DEFINITIONINFO_ON);
  Add(TCompilerDirectiveTypeSubtractionchecked_pointersTAddition);
  Add(TCompilerDirectiveTypeSubtractionchecked_pointersTSubtraction);
  Add(TCompilerDirectiveTypeSubtractionchecked_pointersTYPEDADDRESS_ON);
  Add(TCompilerDirectiveTypeSubtractionchecked_pointersTYPEDADDRESS_OFF);
  Add(TCompilerDirectiveUNDEF_DMSymbol);
  Add(TCompilerDirectiveVarSubtractionstring_checkingVAddition);
  Add(TCompilerDirectiveVarSubtractionstring_checkingVSubtraction);
  Add(TCompilerDirectiveVarSubtractionstring_checkingVARSTRINGCHECKS_ON);
  Add(TCompilerDirectiveVarSubtractionstring_checkingVARSTRINGCHECKS_OFF);
  Add(TCompilerDirectiveWarning_messagesWARN_DMSymbol);
  Add(TCompilerDirectiveWarningsWARNINGS_ON);
  Add(TCompilerDirectiveWarningsWARNINGS_OFF);
  Add(TCompilerDirectiveWeak_packagingWEAKPACKAGEUNIT_ON);
  Add(TCompilerDirectiveWeak_packagingWEAKPACKAGEUNIT_OFF);
  Add(TCompilerDirectiveWEAKLINKRTTI_directiveWEAKLINKRTTI_ON);
  Add(TCompilerDirectiveWEAKLINKRTTI_directiveWEAKLINKRTTI_OFF);
  Add(TCompilerDirectiveWriteable_typed_constantsJAddition);
  Add(TCompilerDirectiveWriteable_typed_constantsJSubtraction);
  Add(TCompilerDirectiveWriteable_typed_constantsWRITEABLECONST_ON);
  Add(TCompilerDirectiveWriteable_typed_constantsWRITEABLECONST_OFF);
  Add(TCompilerDirectiveZeroSubtractionbased_stringsZEROBASEDSTRINGS_ON);
  Add(TCompilerDirectiveZeroSubtractionbased_stringsZEROBASEDSTRINGS_OFF);
end;

function TCompilerDirectiveAlign_fieldsAAddition.GetCommand: String;
begin
  Result := '{$A+}';
end;

function TCompilerDirectiveAlign_fieldsASubtraction.GetCommand: String;
begin
  Result := '{$A-}';
end;

function TCompilerDirectiveAssert_DirectiveCAddition.GetCommand: String;
begin
  Result := '{$C+}';
end;

function TCompilerDirectiveAssert_DirectiveCSubtraction.GetCommand: String;
begin
  Result := '{$C-}';
end;

function TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBAddition.
  GetCommand: String;
begin
  Result := '{$B+}';
end;

function TCompilerDirectiveBoolean_shortSubtractioncircuit_evaluationBSubtraction.
  GetCommand: String;
begin
  Result := '{$B-}';
end;

function TCompilerDirectiveDebug_informationDAddition.GetCommand: String;
begin
  Result := '{$D+}';
end;

function TCompilerDirectiveDebug_informationDSubtraction.GetCommand: String;
begin
  Result := '{$D-}';
end;

function TCompilerDirectiveExtended_syntaxXAddition.GetCommand: String;
begin
  Result := '{$X+}';
end;

function TCompilerDirectiveExtended_syntaxXSubtraction.GetCommand: String;
begin
  Result := '{$X-}';
end;

function TCompilerDirectiveImported_dataGAddition.GetCommand: String;
begin
  Result := '{$G+}';
end;

function TCompilerDirectiveImported_dataGSubtraction.GetCommand: String;
begin
  Result := '{$G-}';
end;

function TCompilerDirectiveInput_output_checkingIAddition.GetCommand: String;
begin
  Result := '{$I+}';
end;

function TCompilerDirectiveInput_output_checkingISubtraction.GetCommand: String;
begin
  Result := '{$I-}';
end;

function TCompilerDirectiveLocal_symbol_informationLAddition.GetCommand: String;
begin
  Result := '{$L+}';
end;

function TCompilerDirectiveLocal_symbol_informationLSubtraction.
  GetCommand: String;
begin
  Result := '{$L-}';
end;

function TCompilerDirectiveLong_stringsHAddition.GetCommand: String;
begin
  Result := '{$H+}';
end;

function TCompilerDirectiveLong_stringsHSubtraction.GetCommand: String;
begin
  Result := '{$H-}';
end;

function TCompilerDirectiveOpen_String_ParametersPAddition.GetCommand: String;
begin
  Result := '{$P+}';
end;

function TCompilerDirectiveOpen_String_ParametersPSubtraction.
  GetCommand: String;
begin
  Result := '{$P-}';
end;

function TCompilerDirectiveOptimizationOAddition.GetCommand: String;
begin
  Result := '{$O+}';
end;

function TCompilerDirectiveOptimizationOSubtraction.GetCommand: String;
begin
  Result := '{$O-}';
end;

function TCompilerDirectiveOverflow_checkingQAddition.GetCommand: String;
begin
  Result := '{$Q+}';
end;

function TCompilerDirectiveOverflow_checkingQSubtraction.GetCommand: String;
begin
  Result := '{$Q-}';
end;

function TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUAddition.
  GetCommand: String;
begin
  Result := '{$U+}';
end;

function TCompilerDirectivePentiumSubtractionsafe_FDIV_operationsUSubtraction.
  GetCommand: String;
begin
  Result := '{$U-}';
end;

function TCompilerDirectiveRange_checkingRAddition.GetCommand: String;
begin
  Result := '{$R+}';
end;

function TCompilerDirectiveRange_checkingRSubtraction.GetCommand: String;
begin
  Result := '{$R-}';
end;

function TCompilerDirectiveRunSubtractionTime_Type_InformationMAddition.
  GetCommand: String;
begin
  Result := '{$M+}';
end;

function TCompilerDirectiveRunSubtractionTime_Type_InformationMSubtraction.
  GetCommand: String;
begin
  Result := '{$M-}';
end;

function TCompilerDirectivetack_framesWAddition.GetCommand: String;
begin
  Result := '{$W+}';
end;

function TCompilerDirectivetack_framesWSubtraction.GetCommand: String;
begin
  Result := '{$W-}';
end;

function TCompilerDirectiveymbol_declarationcrossSubtractionreference_information.
  GetCommand: String;
begin
  Result := '{$cross-reference information}';
end;

function TCompilerDirectiveymbol_declarationYAddition.GetCommand: String;
begin
  Result := '{$Y+}';
end;

function TCompilerDirectiveymbol_declarationYSubtraction.GetCommand: String;
begin
  Result := '{$Y-}';
end;

function TCompilerDirectiveTypeSubtractionchecked_pointersTAddition.
  GetCommand: String;
begin
  Result := '{$T+}';
end;

function TCompilerDirectiveTypeSubtractionchecked_pointersTSubtraction.
  GetCommand: String;
begin
  Result := '{$T-}';
end;

function TCompilerDirectiveVarSubtractionstring_checkingVAddition.
  GetCommand: String;
begin
  Result := '{$V+}';
end;

function TCompilerDirectiveVarSubtractionstring_checkingVSubtraction.
  GetCommand: String;
begin
  Result := '{$V-}';
end;

function TCompilerDirectiveWriteable_typed_constantsJAddition.
  GetCommand: String;
begin
  Result := '{$J+}';
end;

function TCompilerDirectiveWriteable_typed_constantsJSubtraction.
  GetCommand: String;
begin
  Result := '{$J-}';
end;

{ TCompilerDirectivewitch }

{ TCompilerDirective }

function TCompilerDirective.GetCommand: string;
begin
  Result := '{$' + Inherited GetCommand + '}';
end;

function TObjectActionCompilerDirective.GetListCommand: TListCommand;
begin
  Result := TListCompilerDirective.Create(Self);
end;

initialization

RegisterClass(TObjectActionCompilerDirective);

end.
