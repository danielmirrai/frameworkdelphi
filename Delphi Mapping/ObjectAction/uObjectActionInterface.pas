unit uObjectActionInterface;

interface

uses
  uObjectAction, uObjectDaoInterface, Classes, Forms, SysUtils,
  uObjectActionBlockTagInDB, uConstantInterface, uDMList, TypInfo,
  uObjectActionMethod,
  uObjectActionBlockTag, uConstantUtils, uDMUtils, uObjectActionStructureDelphi;

type
  TCategoryInterface = (tciName, tciOwner);

  TObjectActionInterface = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureName(poConfigBlockTag: TConfigBlockTag);
    procedure CaptureOwner(poConfigBlockTag: TConfigBlockTag);
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoInterface: TObjectDaoInterface;

    FObjectActionMethod: TObjectActionMethod;
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;

implementation

uses uConstantCommand;

procedure TObjectActionInterface.AfterConstruction;
begin
  inherited;
  FObjectDaoInterface := GetObjectDao as TObjectDaoInterface;

  FObjectActionMethod := ListObjectActionChildren.Add(TObjectActionMethod, Self)
    as TObjectActionMethod;
end;

procedure TObjectActionInterface.CaptureName(poConfigBlockTag: TConfigBlockTag);
begin
  if Assigned(poConfigBlockTag) then
    // IObject
    poConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
      '|ID_Data_' + sCST_OtherValue + '|');
end;

procedure TObjectActionInterface.CaptureOwner(poConfigBlockTag
  : TConfigBlockTag);
var
  oConfigItemTag: TConfigItemTag;
begin
  if not Assigned(poConfigBlockTag) then
    Exit;
  // ( até )
  oConfigItemTag := poConfigBlockTag.ListObjectActionChildren.Add
    ('|ID_Operator_5|', sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_6|',
    Integer(tciOwner), False);
  // IInterfaceTeste
  oConfigItemTag.SubBlock.ListObjectActionChildren.Add(sCST_EmptyStr,
    '|ID_Data_' + sCST_OtherValue + '|', '|ID_Operator_29|');
end;

procedure TObjectActionInterface.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
begin
  // até = Interface
  oConfigBlockTag := ListConfigBlockTag.Add(sCST_EmptyStr,
    '|ID_Operator_23|,|ID_WordDelphi_2|', True, Integer(tciName));
  CaptureName(oConfigBlockTag);

  // = Interface até ;
  oConfigBlockTag := ListConfigBlockTag.Add
    ('|ID_Operator_23|,|ID_WordDelphi_2|', '|ID_Operator_7|', True);
  CaptureOwner(oConfigBlockTag);
end;

destructor TObjectActionInterface.Destroy;
begin
  FObjectActionMethod := nil;
  FObjectDaoInterface := nil;
  inherited;
end;

initialization

RegisterClass(TObjectActionInterface);

end.
