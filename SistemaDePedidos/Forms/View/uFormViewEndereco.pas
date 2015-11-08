unit uFormViewEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantEndereco,
  Dialogs, uFormViewModel, uFormAddEndereco, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewEndereco = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddEndereco: TFormAddEndereco;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewEndereco }

procedure TFormViewEndereco.AfterConstruction;
begin
  inherited;
  FFormAddEndereco := GetFormAddModel as TFormAddEndereco;
end;

initialization

RegisterClass(TFormViewEndereco);

end.
