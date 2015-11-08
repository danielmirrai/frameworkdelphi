unit uTraducaoDevExpressBR;

interface
uses cxClasses,cxGridStrs,cxFilterControlStrs, cxEditConsts,cxLibraryStrs;

Procedure SetResorcePortugues;

implementation
Procedure SetResorcePortugues;
begin
  cxSetResourceString(@cxSFilterBoolOperatorAnd,'AND');
  cxSetResourceString(@cxSFilterBoolOperatorOr,'OR');
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd,'NOT AND');
  cxSetResourceString(@cxSFilterBoolOperatorNotOr,'NOT OR');
  //
  cxSetResourceString(@cxSFilterRootButtonCaption,'Filtro');
  cxSetResourceString(@cxSFilterAddCondition,'inclui &Condição');
  cxSetResourceString(@cxSFilterAddGroup, 'Inclui &Group0');
  cxSetResourceString(@cxSFilterRemoveRow, '&Remove linha');
  cxSetResourceString(@cxSFilterClearAll, 'Apaga &Todos');
  cxSetResourceString(@cxSFilterFooterAddCondition, 'Precione o botão p/ nova condição');

  cxSetResourceString(@cxSFilterGroupCaption, 'aplica-se às seguintes condições');
  cxSetResourceString(@cxSFilterRootGroupCaption, '');
  cxSetResourceString(@cxSFilterControlNullString, '');

  cxSetResourceString(@cxSFilterErrorBuilding, 'Can''t build filter from source');

  //FilterDialog
  cxSetResourceString(@cxSFilterDialogCaption, 'Configurar Filtro');
  cxSetResourceString(@cxSFilterDialogInvalidValue, 'Valor invalido');
  cxSetResourceString(@cxSFilterDialogUse, 'Usar');
  cxSetResourceString(@cxSFilterDialogSingleCharacter, 'to represent any single character');
  cxSetResourceString(@cxSFilterDialogCharactersSeries, 'to represent any series of characters');

  cxSetResourceString(@cxSFilterDialogOperationAnd, 'AND');
  cxSetResourceString(@cxSFilterDialogOperationOr, 'OR');
  cxSetResourceString(@cxSFilterDialogRows, 'Criar filtro para:');

  // FilterControlDialog
  cxSetResourceString(@cxSFilterControlDialogCaption, 'Construtor de filtro');
  cxSetResourceString(@cxSFilterControlDialogNewFile, 'untitled.flt');
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption, 'Open an existing filter');
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption, 'Save the active filter to file');
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption, '&Savar como...');
  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption, '&Abrir...');
  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption, '&Aplicar');
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption, 'OK');
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption, 'Cancelar');
  cxSetResourceString(@cxSFilterControlDialogFileExt, 'flt');
  cxSetResourceString(@cxSFilterControlDialogFileFilter, 'Filters(*.flt)|*.flt');

  // cxGrid
  cxSetResourceString(@scxGridRecursiveLevels, 'You cannot create recursive levels');

//  cxSetResourceString(@scxGridDeletingConfirmationCaption, 'Confirme');
  cxSetResourceString(@scxGridDeletingFocusedConfirmationText, 'Delete registro?');
  cxSetResourceString(@scxGridDeletingSelectedConfirmationText, 'Detele todos os registros selecionados?');

  cxSetResourceString(@scxGridNewItemRowInfoText, 'Click aqui para adicionar uma Coluna nova');

  cxSetResourceString(@scxGridFilterIsEmpty, '');

  cxSetResourceString(@scxGridCustomizationFormCaption, 'Configuraçao');
  cxSetResourceString(@scxGridCustomizationFormColumnsPageCaption, 'Colunas');
  cxSetResourceString(@scxGridGroupByBoxCaption, 'Arraste o cabeçalho da coluna aqui para agrupar por ela');
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption, 'Configure...');

  cxSetResourceString(@scxGridCustomizationFormBandsPageCaption, 'Faixas');

  cxSetResourceString(@scxGridConverterIntermediaryMissing,'Faltando um componente!'#13#10'Por favor adicione um componente de %s ao formulário');
  cxSetResourceString(@scxGridConverterNotExistGrid, 'Grade não existe');
  cxSetResourceString(@scxGridConverterNotExistComponent, 'Componente não existe');
  cxSetResourceString(@scxImportErrorCaption, 'Erro ao importar');

  cxSetResourceString(@scxNotExistGridView, 'Visualização da grade não existe');
  cxSetResourceString(@scxNotExistGridLevel, 'O nível ativo da grade não existe');
  cxSetResourceString(@scxCantCreateExportOutputFile, 'Não posso criar arquivo de exportação');

  cxSetResourceString(@cxSEditRepositoryExtLookupComboBoxItem,
'ExtLookupComboBox|Representa um lookup ultra-avançado que usa o QuantumGrid como base');

{  cxSEditInvalidRepositoryItem = 'The repository item is not acceptable';
  cxSEditNumericValueConvertError = 'Could not convert to numeric value';
  cxSEditPopupCircularReferencingError = 'Circular referencing is not allowed';
  cxSEditPostError = 'An error occured during posting edit value';
  cxSEditTimeConvertError = 'Could not convert to time';
  cxSEditValidateErrorText = 'Invalid input value. Use escape key to abandon
changes';
  cxSEditValueOutOfBounds = 'Value out of bounds';
 }
  // TODO
  cxSetResourceString(@cxSEditCheckBoxChecked,'Verdadeiro');
  cxSetResourceString(@cxSEditCheckBoxGrayed,'');
  cxSetResourceString(@cxSEditCheckBoxUnchecked,'Falso');
  cxSetResourceString(@cxSRadioGroupDefaultCaption,'');

  cxSetResourceString(@cxSTextTrue,'Verdadeiro');
  cxSetResourceString(@cxSTextFalse,'Falso');

  // blob
  cxSetResourceString(@cxSBlobButtonOK         ,'&OK');
  cxSetResourceString(@cxSBlobButtonCancel     ,'&Cancelar');
  cxSetResourceString(@cxSBlobButtonClose      ,'&Close');
  cxSetResourceString(@cxSBlobMemo             ,'(MEMO)');
  cxSetResourceString(@cxSBlobMemoEmpty        ,'(memo)');
  cxSetResourceString(@cxSBlobPicture          ,'(PICTURE)');
  cxSetResourceString(@cxSBlobPictureEmpty     ,'(picture)');

  // popup menu items
  cxSetResourceString(@cxSMenuItemCaptionCut   ,'Cu&t');
  cxSetResourceString(@cxSMenuItemCaptionCopy  ,'&Copiar');
  cxSetResourceString(@cxSMenuItemCaptionPaste ,'&Colar');
  cxSetResourceString(@cxSMenuItemCaptionDelete,'&Apagar');
  cxSetResourceString(@cxSMenuItemCaptionLoad  ,'&Abrir...');
  cxSetResourceString(@cxSMenuItemCaptionSave  ,'Salvar como...');

  // date
  cxSetResourceString(@cxSDatePopupToday, 'Hoje');
  cxSetResourceString(@cxSDatePopupClear, 'Apagar');
  cxSetResourceString(@cxSDateError     , 'Data Inválida');
  // smart input consts
  cxSetResourceString(@cxSDateToday     , 'Hoje');
  cxSetResourceString(@cxSDateYesterday , 'Ontem');
  cxSetResourceString(@cxSDateTomorrow  , 'Amanhã');
  cxSetResourceString(@cxSDateSunday    , 'Domingo');
  cxSetResourceString(@cxSDateMonday    , 'Segunda');
  cxSetResourceString(@cxSDateTuesday   , 'Terça');
  cxSetResourceString(@cxSDateWednesday , 'Quarta');
  cxSetResourceString(@cxSDateThursday  , 'Quinta');
  cxSetResourceString(@cxSDateFriday    , 'Sexta');
  cxSetResourceString(@cxSDateSaturday  , 'Sábado');
  cxSetResourceString(@cxSDateFirst     , 'Primeiro');
  cxSetResourceString(@cxSDateSecond    , 'segundos');
  cxSetResourceString(@cxSDateThird     , 'Terceiro');
  cxSetResourceString(@cxSDateFourth    , 'Quarto');
  cxSetResourceString(@cxSDateFifth     , 'Quinto');
  cxSetResourceString(@cxSDateSixth     , 'Sexto');
  cxSetResourceString(@cxSDateSeventh   , 'Sétimo');
  cxSetResourceString(@cxSDateBOM       , 'bom');
  cxSetResourceString(@cxSDateEOM       , 'eom');
  cxSetResourceString(@cxSDateNow       , 'Agora');

{  // calculator
  cxSetResourceString(@scxSCalcError                      = 'Error';

  // edit repository
  cxSetResourceString(@scxSEditRepositoryBlobItem         =
'BlobEdit|Represents the BLOB editor';
  cxSetResourceString(@scxSEditRepositoryButtonItem       =
'ButtonEdit|Represents an edit control with embedded buttons';
  cxSetResourceString(@scxSEditRepositoryCalcItem         =
'CalcEdit|Represents an edit control with a dropdown calculator window';
  cxSetResourceString(@scxSEditRepositoryCheckBoxItem     =
'CheckBox|Represents a check box control that allows selecting an option';
  cxSetResourceString(@scxSEditRepositoryComboBoxItem     =
'ComboBox|Represents the combo box editor';
  cxSetResourceString(@scxSEditRepositoryCurrencyItem     =
'CurrencyEdit|Represents an editor enabling editing currency data';
  cxSetResourceString(@scxSEditRepositoryDateItem         =
'DateEdit|Represents an edit control with a dropdown calendar';
  cxSetResourceString(@scxSEditRepositoryHyperLinkItem    =
'HyperLink|Represents a text editor with hyperlink functionality';
  cxSetResourceString(@scxSEditRepositoryImageComboBoxItem =
'ImageComboBox|Represents an editor displaying the list of images and text
strings within the dropdown window';
  cxSetResourceString(@scxSEditRepositoryImageItem        = 'Image|Represents
an image editor';
  cxSetResourceString(@scxSEditRepositoryLookupComboBoxItem =
'LookupComboBox|Represents a lookup combo box control';
  cxSetResourceString(@scxSEditRepositoryMaskItem         =
'MaskEdit|Represents a generic masked edit control.';
  cxSetResourceString(@scxSEditRepositoryMemoItem         = 'Memo|Represents an
edit control that allows editing memo data';
  cxSetResourceString(@scxSEditRepositoryMRUItem          = 'MRUEdit|Represents
a text editor displaying the list of most recently used items (MRU) within a
dropdown window';
  cxSetResourceString(@scxSEditRepositoryPopupItem        =
'PopupEdit|Represents an edit control with a dropdown list';
  cxSetResourceString(@scxSEditRepositorySpinItem         =
'SpinEdit|Represents a spin editor';
  cxSetResourceString(@scxSEditRepositoryRadioGroupItem   =
'RadioGroup|Represents a group of radio buttons';
  cxSetResourceString(@scxSEditRepositoryTextItem         =
'TextEdit|Represents a single line text editor';
  cxSetResourceString(@scxSEditRepositoryTimeItem         =
'TimeEdit|Represents an editor displaying time values';

  cxSetResourceString(@scxRegExprLine = 'Line';
  cxSetResourceString(@scxRegExprChar = 'Char';
  cxSetResourceString(@scxRegExprNotAssignedSourceStream = 'The source stream
is not assigned';
  cxSetResourceString(@scxRegExprEmptySourceStream = 'The source stream is
empty';
  cxSetResourceString(@scxRegExprCantUsePlusQuantifier = 'The ''+'' quantifier
cannot be applied here';
  cxSetResourceString(@scxRegExprCantUseStarQuantifier = 'The ''*'' quantifier
cannot be applied here';
  cxSetResourceString(@scxRegExprCantCreateEmptyAlt = 'The alternative should
not be empty';
  cxSetResourceString(@scxRegExprCantCreateEmptyBlock = 'The block should not
be empty';
  cxSetResourceString(@scxRegExprIllegalSymbol = 'Illegal ''%s''';
  cxSetResourceString(@scxRegExprIllegalQuantifier = 'Illegal quantifier
''%s''';
  cxSetResourceString(@scxRegExprNotSupportQuantifier = 'The parameter
quantifiers are not supported';
  cxSetResourceString(@scxRegExprIllegalIntegerValue = 'Illegal integer value';
  cxSetResourceString(@scxRegExprTooBigReferenceNumber = 'Too big reference
number';
  cxSetResourceString(@scxRegExprCantCreateEmptyEnum = 'Can''t create empty
enumeration';
  cxSetResourceString(@scxRegExprSubrangeOrder = 'The starting character of the
subrange must be less than the finishing one';
  cxSetResourceString(@scxRegExprHexNumberExpected0 = 'Hexadecimal number
expected';
  cxSetResourceString(@scxRegExprHexNumberExpected = 'Hexadecimal number
expected but ''%s'' found';
  cxSetResourceString(@scxRegExprMissing = 'Missing ''%s''';
  cxSetResourceString(@scxRegExprUnnecessary = 'Unnecessary ''%s''';
  cxSetResourceString(@scxRegExprIncorrectSpace = 'The space character is not
allowed after ''\''';
  cxSetResourceString(@scxRegExprNotCompiled = 'Regular expression is not
compiled';
  cxSetResourceString(@scxRegExprIncorrectParameterQuantifier = 'Incorrect
parameter quantifier';
  cxSetResourceString(@scxRegExprCantUseParameterQuantifier = 'The parameter
quantifier cannot be applied here';

  cxSetResourceString(@scxMaskEditRegExprError = 'Regular expression errors:';
  cxSetResourceString(@scxMaskEditInvalidEditValue = 'The edit value is
invalid';
  cxSetResourceString(@scxMaskEditNoMask = 'None';
  cxSetResourceString(@scxMaskEditIllegalFileFormat = 'Illegal file format';
  cxSetResourceString(@scxMaskEditEmptyMaskCollectionFile = 'The mask
collection file is empty';
  cxSetResourceString(@scxMaskEditMaskCollectionFiles = 'Mask collection
files';}
end;

end.

