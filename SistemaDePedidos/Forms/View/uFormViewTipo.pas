unit uFormViewTipo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantTipo,
  Dialogs, uFormViewModel, uFormAddTipo, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewTipo = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddTipo: TFormAddTipo;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewTipo }

procedure TFormViewTipo.AfterConstruction;
begin
  inherited;
  FFormAddTipo := GetFormAddModel as TFormAddTipo;
end;

initialization

RegisterClass(TFormViewTipo);

end.
