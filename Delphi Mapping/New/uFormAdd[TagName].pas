unit uFormAdd[TagName];

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms, uConstant[TagName],
  Dialogs, uFormAddModel, uObjectAction[TagName], Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, System.Actions,
  Vcl.ActnList, Vcl.Mask, Vcl.DBCtrls, System.Classes;

type
  TFormAdd[TagName] = Class(TFormAddModel)
  public
    { Public declarations }
    FObjectAction[TagName]: TObjectAction[TagName];
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDao[TagName];

{ TFormAdd[TagName] }

procedure TFormAdd[TagName].AfterConstruction;
begin
  inherited;
  FObjectAction[TagName] := (GetObjectAction as TObjectAction[TagName]);
end;

initialization
  RegisterClass(TFormAdd[TagName]);

end.
