unit uFormViewEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantEstado,
  Dialogs, uFormViewModel, uFormAddEstado, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewEstado = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddEstado: TFormAddEstado;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewEstado }

procedure TFormViewEstado.AfterConstruction;
begin
  inherited;
  FFormAddEstado := GetFormAddModel as TFormAddEstado;
end;

initialization

RegisterClass(TFormViewEstado);

end.
