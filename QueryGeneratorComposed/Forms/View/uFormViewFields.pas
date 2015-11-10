unit uFormViewFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uConstantFields,
  Dialogs, uFormViewModel, uFormAddFields, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinsDefaultPainters, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, Menus,
  cxPropertiesStore, cxGridCustomPopupMenu, cxGridPopupMenu, ActnList,
  StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  uDMRTTI, cxGroupBox;

type
  TFormViewFields = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddFields: TFormAddFields;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

{ TFormViewFields }

procedure TFormViewFields.AfterConstruction;
begin
  inherited;
  FFormAddFields := GetFormAddModel as TFormAddFields;
end;

initialization
  DMRTTI.RegisterClass(TFormViewFields);

end.
