unit uFormAddTimeExecuting;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantTimeExecuting,
  Dialogs, uFormAddModel, uObjectActionTimeExecuting, StdCtrls, Mask,
  DBCtrls, DB, Classes, ActnList, ExtCtrls,
  uObjectAction, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  Menus, cxTextEdit, cxDBEdit, cxButtons, cxGroupBox;

type
  TFormAddTimeExecuting = Class(TFormAddModel)
    Label1: TLabel;
    DBEdit1: TcxDBTextEdit;
    Label2: TLabel;
    DBEdit2: TcxDBTextEdit;
    Label3: TLabel;
    DBEdit3: TcxDBTextEdit;
    Label4: TLabel;
    DBEdit4: TcxDBTextEdit;
    Label5: TLabel;
    DBEdit5: TcxDBTextEdit;
    Label6: TLabel;
    DBEdit6: TcxDBTextEdit;
    Label7: TLabel;
    DBEdit7: TcxDBTextEdit;
    Label8: TLabel;
    DBEdit8: TcxDBTextEdit;
    Label9: TLabel;
    DBEdit9: TcxDBTextEdit;
  public
    { Public declarations }
    FObjectActionTimeExecuting: TObjectActionTimeExecuting;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoTimeExecuting;

{ TFormAddTimeExecuting }

procedure TFormAddTimeExecuting.AfterConstruction;
begin
  inherited;
  FObjectActionTimeExecuting := (GetObjectAction as TObjectActionTimeExecuting);
end;

initialization

RegisterClass(TFormAddTimeExecuting);

end.
