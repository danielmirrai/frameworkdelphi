unit uFormViewPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantPessoa,
  Dialogs, uFormViewModel, uFormAddPessoa, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewPessoa = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddPessoa: TFormAddPessoa;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewPessoa }

procedure TFormViewPessoa.AfterConstruction;
begin
  inherited;
  FFormAddPessoa := GetFormAddModel as TFormAddPessoa;
end;

initialization

RegisterClass(TFormViewPessoa);

end.
