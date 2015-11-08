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
unit uObjectActionData;

interface

uses
  uObjectAction, uObjectDaoData, Classes, Forms, SysUtils, uConstantData,
  TypInfo, uDMList,
  uConstantUtils, uDMUtils, uObjectActionCommand, uConstantCommand;

type
  TData = class(TItemCommand)
  public
    function GetNotSpecificCommand: string; Override;
  end;

  TListData = Class(TListCommand)
  public
    procedure ImportAll; Override;
  end;

  /// <summary>
  /// Constrole ação dos dados que não são comandos do delphi
  /// </summary>
  TObjectActionData = Class(TObjectActionCommand)
  protected
    function GetListCommand: TListCommand; Override;
  public
    FObjectDaoData: TObjectDaoData;
    function GetIDType: Integer; Override;
    procedure AfterConstruction; override;
  end;

implementation

procedure TObjectActionData.AfterConstruction;
begin
  inherited;
  FObjectDaoData := GetObjectDao as TObjectDaoData;
end;

{ TListData }

procedure TListData.ImportAll;
begin
  inherited;
  Add(TData);
end;

function TObjectActionData.GetIDType: Integer;
begin
  Result := 5;
end;

{ TData }

function TData.GetNotSpecificCommand: string;
begin
  Result := '|ID_' + sCST_OtherValue + '|';
end;

function TObjectActionData.GetListCommand: TListCommand;
begin
  Result := TListData.Create(Self);
end;

initialization

RegisterClass(TObjectActionData);

end.
