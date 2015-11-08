unit uFormViewPais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantPais,
  Dialogs, uFormViewModel, uFormAddPais, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewPais = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddPais: TFormAddPais;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewPais }

procedure TFormViewPais.AfterConstruction;
begin
  inherited;
  FFormAddPais := GetFormAddModel as TFormAddPais;
end;

initialization

RegisterClass(TFormViewPais);

end.
