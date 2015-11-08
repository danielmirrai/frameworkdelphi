unit uObjectActionRecord;

interface

uses
  uObjectAction, uObjectDaoRecord, Classes, Forms, SysUtils, uConstantRecord,
  uObjectActionBlockTagInDB, TypInfo, uDMList, uObjectActionStructureDelphi,
  uObjectActionBlockTag, uConstantUtils, uDMUtils;

type
  TObjectActionRecord = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureName(poConfigBlockTag: TConfigBlockTag);
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoRecord: TObjectDaoRecord;
    procedure AfterConstruction; override;
  end;

implementation

uses uConstantCommand;

procedure TObjectActionRecord.AfterConstruction;
begin
  inherited;
  FObjectDaoRecord := GetObjectDao as TObjectDaoRecord;
end;

procedure TObjectActionRecord.CaptureName(poConfigBlockTag: TConfigBlockTag);
begin
  if Assigned(poConfigBlockTag) then
    // TObject
    poConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
      '|ID_Data_' + sCST_OtherValue + '|');
end;

procedure TObjectActionRecord.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
begin
  // até = Record
  oConfigBlockTag := ListConfigBlockTag.Add(sCST_EmptyStr,
    '|ID_Operator_23|,|ID_WordDelphi_3|');
  CaptureName(oConfigBlockTag);
end;

initialization

RegisterClass(TObjectActionRecord);

end.
