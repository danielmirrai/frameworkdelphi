unit uObjectActionDispinterface;

interface

uses
  uObjectAction, uObjectDaoDispinterface, Classes, Forms, SysUtils,
  uObjectActionBlockTagInDB, uObjectActionBlockTag, uConstantDispinterface,
  TypInfo,
  uConstantUtils, uDMUtils, uDMList, uObjectActionMethod,
  uObjectActionStructureDelphi;

type
  TCategoryDispinterface = (tcipName, tcipOwner);

  TObjectActionDispinterface = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureName(poConfigBlockTag: TConfigBlockTag);
    procedure CaptureOwner(poConfigBlockTag: TConfigBlockTag);
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoDispinterface: TObjectDaoDispinterface;

    FObjectActionMethod: TObjectActionMethod;
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;

implementation

uses uConstantCommand;

procedure TObjectActionDispinterface.AfterConstruction;
begin
  inherited;
  FObjectDaoDispinterface := GetObjectDao as TObjectDaoDispinterface;

  FObjectActionMethod := ListObjectActionChildren.Add(TObjectActionMethod, Self)
    as TObjectActionMethod;
end;

procedure TObjectActionDispinterface.CaptureName(poConfigBlockTag
  : TConfigBlockTag);
begin
  if Assigned(poConfigBlockTag) then
    // IObject
    poConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
      '|ID_Data_' + sCST_OtherValue + '|');
end;

procedure TObjectActionDispinterface.CaptureOwner(poConfigBlockTag
  : TConfigBlockTag);
var
  oConfigItemTag: TConfigItemTag;
begin
  if not Assigned(poConfigBlockTag) then
    Exit;
  // ( até )
  oConfigItemTag := poConfigBlockTag.ListObjectActionChildren.Add
    ('|ID_Operator_5|', sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_6|',
    Integer(tcipOwner), False);
  // IInterfaceTeste
  oConfigItemTag.SubBlock.ListObjectActionChildren.Add(sCST_EmptyStr,
    '|ID_Data_' + sCST_OtherValue + '|', '|ID_Operator_29|');
end;

procedure TObjectActionDispinterface.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
begin
  // até = DispInterface
  oConfigBlockTag := ListConfigBlockTag.Add(sCST_EmptyStr,
    '|ID_Operator_23|,|ID_WordDelphi_36|', False, Integer(tcipName));
  CaptureName(oConfigBlockTag);

  // = DispInterface até ;
  oConfigBlockTag := ListConfigBlockTag.Add
    ('|ID_Operator_23|,|ID_WordDelphi_36|', '|ID_Operator_7|');
  CaptureOwner(oConfigBlockTag);
end;

destructor TObjectActionDispinterface.Destroy;
begin
  FObjectDaoDispinterface := nil;
  FObjectActionMethod := nil;
  inherited;
end;

initialization

RegisterClass(TObjectActionDispinterface);

end.
