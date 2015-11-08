unit uObjectActionExistingType;

interface

uses
  uObjectAction, uObjectDaoExistingType, Classes, Forms, SysUtils,
  System.Contnrs,
  uObjectActionBlockTagInDB, uConstantExistingType, TypInfo,
  uObjectActionStructureDelphi, Dialogs,
  uObjectActionBlockTag, uDMList, uConstantUtils, uDMUtils;

type
  TCategoryExistingType = (tceNormal, tceDeclaredType);

  TObjectActionExistingType = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureOwner(oConfigBlockTag: TConfigBlockTag;
      oValue: TRecordParamValueSearch);
  protected
    procedure ConfigureBlockMapping; override;
  public
    FObjectDaoExistingType: TObjectDaoExistingType;
    procedure AfterConstruction; override;
  end;

implementation

uses uConstantCommand, uFactoryObject;

procedure TObjectActionExistingType.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oValue.Add(FObjectDaoExistingType.CDSDadosNAME.FieldName,
      sCST_DataOtherValue);
    oValue.Add(sCST_EmptyStr, '|ID_Operator_23|');

    // TDMUtils = type até ;
    oConfigBlockTag := ListConfigBlockTag.Add(oValue, '|ID_Operator_7|', False,
      Integer(tceDeclaredType));
    CaptureOwner(oConfigBlockTag, oValue);
  finally
    TDMUtils.DestroyObject(oValue);
  end;
end;

procedure TObjectActionExistingType.AfterConstruction;
begin
  inherited;
  FObjectDaoExistingType := GetObjectDao as TObjectDaoExistingType;
end;

procedure TObjectActionExistingType.CaptureOwner(oConfigBlockTag
  : TConfigBlockTag; oValue: TRecordParamValueSearch);
begin
  if not(Assigned(oConfigBlockTag) and Assigned(oValue)) then
    Exit;

  oValue.Clear;
  oValue.Add(sCST_EmptyStr, '|ID_WordDelphi_73|');
  oValue.Add(FObjectDaoExistingType.CDSDadosID_OWNER.FieldName,
    sCST_DataOtherValue);
  // tpye TObject
  oConfigBlockTag.ListObjectActionChildren.Add(oValue);

  oValue.Clear;
  oValue.Add(FObjectDaoExistingType.CDSDadosID_OWNER.FieldName,
    sCST_DataOtherValue);
  // TObject
  oConfigBlockTag.ListObjectActionChildren.Add(oValue);
end;

initialization

RegisterClass(TObjectActionExistingType);

end.
