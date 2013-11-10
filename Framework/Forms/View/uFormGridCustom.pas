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

unit uFormGridCustom;

interface

uses
  Classes, Controls, Forms,
  uFormModel,
  DB, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TFormGridCustom = class(TFormModel)
    dsDados: TDataSource;
    Grid: TDBGrid;
    procedure ac_CloseExecute(Sender: TObject);
  private

  protected
    { Private declarations }
    procedure DefineDataSource; virtual; abstract;
    procedure CreateColuns; virtual;
    procedure DefinePropertiesStore; override;
    procedure FooterGrid;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewModelCustom }

procedure TFormGridCustom.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFormGridCustom.AfterConstruction;
begin
  inherited;
  DefineDataSource;
end;

procedure TFormGridCustom.BeforeDestruction;
begin
  inherited;
end;

procedure TFormGridCustom.CreateColuns;
begin
  Grid.Columns.RebuildColumns;
  DefinePropertiesStore;
end;

procedure TFormGridCustom.DefinePropertiesStore; {
  var
  vIndex: Integer;
  vComponent: TcxPropertiesStoreComponent;
  vView: TcxGridDBTableView; }
begin
  {
    cxPropertiesStore.Components.BeginUpdate;
    vView := GridDBTableView_Dados;

    //  vView Grid.Levels.GridView.
    for vIndex := 0 to vView.ColumnCount - 1 do
    begin
    vComponent := TcxPropertiesStoreComponent(cxPropertiesStore.Components.Add);
    vComponent.Component := vView.Columns[vIndex];
    vComponent.Properties.Add('Width');
    vComponent.Properties.Add('Visible');
    vComponent.Properties.Add('SortIndex');
    vComponent.Properties.Add('SortOrder');
    vComponent.Properties.Add('GroupIndex');
    end;
    cxPropertiesStore.Components.EndUpdate;
    FooterGrid; }
  inherited;
end;

procedure TFormGridCustom.FooterGrid;
begin
  // vItem := GridDBTableView_Dados.DataController.Summary.FooterSummaryItems[0];
end;

initialization

RegisterClass(TFormGridCustom);

end.
