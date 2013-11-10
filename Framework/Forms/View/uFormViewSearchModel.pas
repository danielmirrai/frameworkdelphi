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

unit uFormViewSearchModel;

interface

uses
  Classes, Controls, Forms,
  uFormViewSearchModelCustom, System.SysUtils,
  uObjectAction, Data.DB, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormViewSearchModel = class(TFormViewSearchModelCustom)
    procedure ac_CloseExecute(Sender: TObject);
    procedure ac_SelectExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    FObjectAction: TObjectAction;
    FCreateObjectAction: Boolean;
    procedure DefineDataSource; override;
    function GetNameObjectAction: string; virtual;
  public
    { Public declarations }
    procedure Refresh; overload;
    function GetObjectAction: TObjectAction; virtual;
    constructor Create(poOwner: TComponent;
      poObjectAction: TObjectAction = nil); reintroduce;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  FormViewSearchModel: TFormViewSearchModel;

implementation

{$R *.dfm}

uses uDMUtils, uFactoryObject;

{ TFormViewSearchModel }

procedure TFormViewSearchModel.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFormViewSearchModel.ac_SelectExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFormViewSearchModel.AfterConstruction;
begin
  inherited;
end;

procedure TFormViewSearchModel.BeforeDestruction;
begin
  if FCreateObjectAction then
    TDMUtils.DestroyObject(FObjectAction)
  else
    FObjectAction := nil;
  inherited;
end;

constructor TFormViewSearchModel.Create(poOwner: TComponent;
  poObjectAction: TObjectAction);
begin
  inherited Create(poOwner);
  FObjectAction := poObjectAction;
  FCreateObjectAction := not Assigned(FObjectAction);
  FObjectAction := GetObjectAction;
end;

procedure TFormViewSearchModel.DefineDataSource;
begin
  inherited;
  dsDados.DataSet := FObjectAction.GetObjectDao.CDSDados;
end;

function TFormViewSearchModel.GetNameObjectAction: string;
begin
  Result := StringReplace(Self.ClassName, 'FormViewSearch', 'ObjectAction',
    [rfReplaceAll]);
end;

function TFormViewSearchModel.GetObjectAction: TObjectAction;
begin
  if ((not Assigned(FObjectAction)) and (FCreateObjectAction)) then
    FObjectAction := TFactoryObject.CreateComponent(GetNameObjectAction, Self)
      as TObjectAction;

  Result := FObjectAction;
end;

procedure TFormViewSearchModel.Refresh;
begin
  inherited;
  FObjectAction.Refresh;
end;

initialization

RegisterClass(TFormViewSearchModel);

end.
