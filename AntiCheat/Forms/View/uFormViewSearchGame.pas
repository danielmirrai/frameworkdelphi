unit uFormViewSearchGame;

interface

uses
  dxStatusBar, uObjectActionCustom,
  dxRibbonStatusBar, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormViewSearchModel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinscxPCPainter, cxDataStorage,
  DB, cxDBData, cxClasses, cxPropertiesStore, ActnList,
  uObjectActionGame, StdCtrls, cxButtons, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGroupBox,
  cxImage, cxLabel, cxStyles, cxCustomData, cxFilter, cxData, cxNavigator, Menus,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  dxSkinsDefaultPainters, ExtCtrls, Buttons;

type
  TFormViewSearchGame = class(TFormViewSearchModel)
    GridDBTableView_DadosCODIGO: TcxGridDBColumn;
    GridDBTableView_DadosID_PARTIDA: TcxGridDBColumn;
    GridDBTableView_DadosDESCRICAO: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_CloseExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SelectItem; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function GetObjectAction: TObjectActionGame; Reintroduce;
    { Public declarations }
  end;
          
          
var
  FFormViewSearchGame: TFormViewSearchGame;
  
implementation

uses uDMUtils, uObjectDaoGame;

{$R *.dfm}


{ TFormViewSearchGame }

procedure TFormViewSearchGame.ac_CloseExecute(Sender: TObject);
begin
  //
end;

procedure TFormViewSearchGame.AfterConstruction;
begin
  inherited;
  GetObjectAction.GetListGame;
  ac_Select.Enabled := DSDados.DataSet.RecordCount > 0;
end;

procedure TFormViewSearchGame.BeforeDestruction;
begin
  inherited;

end;
procedure TFormViewSearchGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin       
//  inherited;
  Action := caFree;
  FFormViewSearchGame := nil;
end;

function TFormViewSearchGame.GetObjectAction: TObjectActionGame;
begin
  Result := TObjectActionGame(inherited GetObjectAction);
end;

procedure TFormViewSearchGame.SelectItem;
begin
  inherited;
  if GetObjectAction.SetGameActive(GetObjectAction.GetObjectDao.CDSDadosID_PARTIDA.AsInteger) then
  begin
    tag := mrOk;
    close;
  end;
end;

initialization
  RegisterClass(TFormViewSearchGame);

end.
