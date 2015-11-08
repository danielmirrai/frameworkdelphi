unit uFormHoraConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TFormHoraConfig = class(TForm)
    chklstchk: TCheckListBox;
    dtp1: TDateTimePicker;
    CDSTime: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHoraConfig: TFormHoraConfig;

implementation

{$R *.dfm}

end.
