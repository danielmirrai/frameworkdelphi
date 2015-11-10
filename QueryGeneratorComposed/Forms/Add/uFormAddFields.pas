unit uFormAddFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms, uConstantFields,
  Dialogs, uFormAddModel, uObjectActionFields, StdCtrls, ExtCtrls, DB, 
  Mask, DBCtrls, Classes, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, Menus, cxPropertiesStore, ActnList, cxButtons,
  uDMRTTI, cxGroupBox;

type
  TFormAddFields = Class(TFormAddModel)
  public
    { Public declarations }
    FObjectActionFields: TObjectActionFields;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoFields;

{ TFormAddFields }

procedure TFormAddFields.AfterConstruction;
begin
  inherited;
  FObjectActionFields := (GetObjectAction as TObjectActionFields);
end;

initialization
  DMRTTI.RegisterClass(TFormAddFields);

end.
