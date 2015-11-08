unit uFormViewTimeExecuting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantTimeExecuting,
  Dialogs, uFormViewModel, uFormAddTimeExecuting, DB,

  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls,
  Menus;

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

RegisterClass(TFormViewTimeExecuting);

end.
