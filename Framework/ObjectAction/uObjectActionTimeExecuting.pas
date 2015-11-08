{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectActionTimeExecuting;

interface

uses
  uObjectAction, Classes, Forms, SysUtils, uConstantTimeExecuting,
  TypInfo,
  uConstantUtils, uDMUtils, uObjectDaoTimeExecuting;

type
  TClassObject = class of TObject;

  TObjectActionTimeExecuting = Class(TObjectAction)
  private
    FActiveCalcTimeExecuting: Boolean;
  protected
    procedure SetActiveCalcTimeExecuting(const Value: Boolean); Virtual;
    function GetActiveCalcTimeExecuting: Boolean; Virtual;
  public
    FObjectDaoTimeExecuting: TObjectDaoTimeExecuting;
    procedure AfterConstruction; override;

    function BeginExecuting(poClass: TObject; const psFunction: string)
      : Integer; Overload;
    function BeginExecuting(poClass: TClassObject; const psFunction: string)
      : Integer; Overload;
    function BeginExecuting(const psUnit, psClass, psFunction: string)
      : Integer; Overload;
    procedure EndExecuting(const pnIDExecuting: Integer);
  published
    property ActiveCalcTimeExecuting: Boolean read GetActiveCalcTimeExecuting
      write SetActiveCalcTimeExecuting default False;
  end;

var
  FObjectActionTimeExecuting: TObjectActionTimeExecuting;

implementation

procedure TObjectActionTimeExecuting.AfterConstruction;
begin
  inherited;
  FObjectDaoTimeExecuting := GetObjectDao as TObjectDaoTimeExecuting;
  ActiveCalcTimeExecuting := True;
end;

function TObjectActionTimeExecuting.BeginExecuting(const psUnit, psClass,
  psFunction: string): Integer;
var
  nIDOwner: Integer;
  nNivel: Integer;
begin
  result := -1;
  if not ActiveCalcTimeExecuting then
    Exit;
  FObjectDaoTimeExecuting.CDSDados.Filtered := False;
  FObjectDaoTimeExecuting.CDSDados.Filter := '(DATE_END IS NULL)';
  FObjectDaoTimeExecuting.CDSDados.Filtered := True;
  try
    FObjectDaoTimeExecuting.CDSDados.Last;
    nIDOwner := FObjectDaoTimeExecuting.CDSDadosID_TIME_EXECUTING.AsInteger;
    nNivel := FObjectDaoTimeExecuting.CDSDadosID_NIVEL.AsInteger;
  finally
    FObjectDaoTimeExecuting.CDSDados.Filtered := False;
  end;
  Inc(nNivel);
  Add;
  FObjectDaoTimeExecuting.CDSDadosID_UNIT.AsString := psUnit;
  FObjectDaoTimeExecuting.CDSDadosID_CLASS.AsString := psClass;
  FObjectDaoTimeExecuting.CDSDadosID_FUNCTION.AsString := psFunction;
  FObjectDaoTimeExecuting.CDSDadosDATE_BEGIN.AsDateTime := now;
  FObjectDaoTimeExecuting.CDSDadosID_OWNER.AsInteger := nIDOwner;
  FObjectDaoTimeExecuting.CDSDadosID_NIVEL.AsInteger := nNivel;
  Save;
  result := FObjectDaoTimeExecuting.CDSDadosID_TIME_EXECUTING.AsInteger;
end;

function TObjectActionTimeExecuting.BeginExecuting(poClass: TObject;
  const psFunction: string): Integer;
begin
  result := -1;
end;

function TObjectActionTimeExecuting.BeginExecuting(poClass: TClassObject;
  const psFunction: string): Integer;
begin
  result := -1;
end;

procedure TObjectActionTimeExecuting.EndExecuting(const pnIDExecuting: Integer);
begin
  if not ActiveCalcTimeExecuting then
    Exit;

  if not FObjectDaoTimeExecuting.CDSDados.Locate
    (FObjectDaoTimeExecuting.CDSDadosID_TIME_EXECUTING.FieldName,
    pnIDExecuting, []) then
    Exit;

  Edit;
  FObjectDaoTimeExecuting.CDSDadosDATE_END.AsDateTime := now;
  Save;
end;

function TObjectActionTimeExecuting.GetActiveCalcTimeExecuting: Boolean;
begin
  result := FActiveCalcTimeExecuting;
end;

procedure TObjectActionTimeExecuting.SetActiveCalcTimeExecuting
  (const Value: Boolean);
begin
  FActiveCalcTimeExecuting := Value;
end;

initialization

RegisterClass(TObjectActionTimeExecuting);

end.
