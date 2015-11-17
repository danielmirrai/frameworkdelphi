unit uFormViewReferenceFK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uConstantReferenceFK,
  Dialogs, uFormViewModel, uFormAddReferenceFK, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinsDefaultPainters, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, Menus,
  cxPropertiesStore, cxGridCustomPopupMenu, cxGridPopupMenu, ActnList,
  StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  uDMRTTI, cxGroupBox, cxTextEdit, cxLabel;

type
  TFormViewReferenceFK = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddReferenceFK: TFormAddReferenceFK;
    procedure AfterConstruction; override;
  end;

implementation

uses uDMUtils;
{$R *.dfm}

{ TFormViewReferenceFK }

procedure TFormViewReferenceFK.AfterConstruction;
begin
  inherited;
  FFormAddReferenceFK := GetFormAddModel as TFormAddReferenceFK;
end;

initialization
  DMRTTI.RegisterClass(TFormViewReferenceFK);

end.
