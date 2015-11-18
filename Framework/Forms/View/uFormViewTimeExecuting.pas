unit uFormViewTimeExecuting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uDMClasses, uConstantTimeExecuting,
  Dialogs, uFormViewModel, uFormAddTimeExecuting, DB,

  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls,
  Menus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinsDefaultPainters,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxPropertiesStore, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGroupBox;

type
  TFormViewTimeExecuting = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddTimeExecuting: TFormAddTimeExecuting;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewTimeExecuting }

procedure TFormViewTimeExecuting.AfterConstruction;
begin
  inherited;
  FFormAddTimeExecuting := GetFormAddModel as TFormAddTimeExecuting;
end;

initialization

DMClasses.RegisterClass(TFormViewTimeExecuting);

end.