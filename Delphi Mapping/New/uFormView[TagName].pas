unit uFormView[TagName];

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uConstant[TagName],
  Dialogs, uFormViewModel, uFormAdd[TagName], Data.DB, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormView[TagName] = class(TFormViewModel)
  public
    { Public declarations }
    FFormAdd[TagName]: TFormAdd[TagName];
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

{ TFormView[TagName] }

procedure TFormView[TagName].AfterConstruction;
begin
  inherited;
  FFormAdd[TagName] := GetFormAddModel as TFormAdd[TagName];
end;

initialization
  RegisterClass(TFormView[TagName]);

end.
