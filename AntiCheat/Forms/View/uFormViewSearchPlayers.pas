unit uFormViewSearchPlayers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormViewSearchModel, cxGraphics, cxControls, cxLookAndFeels, uObjectActionPlayers,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, DB, cxDBData, Menus, cxClasses, cxPropertiesStore, ActnList,
  StdCtrls, cxButtons, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGroupBox,
  dxSkinsDefaultPainters, ExtCtrls;

type
  TFormViewSearchPlayers = class(TFormViewSearchModel)
    GridDBTableView_DadosLOGIN: TcxGridDBColumn;
    GridDBTableView_DadosCLA: TcxGridDBColumn;
    GridDBTableView_DadosDATA_INICIO: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_CloseExecute(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    FObjectActionPlayers: TObjectActionPlayers;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function GetObjectAction: TObjectActionPlayers; Reintroduce;
  end;

var
  FormViewSearchPlayers: TFormViewSearchPlayers;

implementation

uses uDMUtils;

{$R *.dfm}

{ TFormViewSearchModel1 }

procedure TFormViewSearchPlayers.ac_CloseExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFormViewSearchPlayers.AfterConstruction;
begin
  inherited;
  FObjectActionPlayers := GetObjectAction;
  FObjectActionPlayers.Active;
  FObjectActionPlayers.Refresh;
end;

procedure TFormViewSearchPlayers.BeforeDestruction;
begin
  inherited;
end;


procedure TFormViewSearchPlayers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FormViewSearchPlayers := nil;
end;

function TFormViewSearchPlayers.GetObjectAction: TObjectActionPlayers;
begin
  Result := TObjectActionPlayers(inherited GetObjectAction);
end;


end.
