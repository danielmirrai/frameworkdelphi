unit uFormAddReferenceFK;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms, uConstantReferenceFK,
  Dialogs, uFormAddModel, uObjectActionReferenceFK, ExtCtrls, 
  cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinsDefaultPainters, Menus, DB,
  uDMClasses, cxPropertiesStore, Classes, ActnList, StdCtrls, cxButtons, cxGroupBox;

type
  TFormAddReferenceFK = Class(TFormAddModel)
  public
    { Public declarations }
    FObjectActionReferenceFK: TObjectActionReferenceFK;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoReferenceFK;

{ TFormAddReferenceFK }

procedure TFormAddReferenceFK.AfterConstruction;
begin
  inherited;
  FObjectActionReferenceFK := (GetObjectAction as TObjectActionReferenceFK);
end;

initialization
  DMClasses.RegisterClass(TFormAddReferenceFK);

end.