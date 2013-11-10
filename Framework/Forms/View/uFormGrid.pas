{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi Sênior }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Fones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }

unit uFormGrid;

interface

uses
  Classes, Controls, Forms,
  uFormGridCustom, Data.DB, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormGrid = class(TFormGridCustom)
    procedure ac_CloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormGrid.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

initialization

RegisterClass(TFormGrid);

end.
