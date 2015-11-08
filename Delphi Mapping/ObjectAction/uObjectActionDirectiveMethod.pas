unit uObjectActionDirectiveMethod;

interface

uses
  uObjectAction, uObjectDaoDirectiveMethod, Classes, Forms, SysUtils,
  uConstantDirectiveMethod, TypInfo, uObjectActionStructureDelphi,
  uObjectActionBlockTagInDB, uObjectActionBlockTag, DB, DBClient,
  uObjectActionDirective, uConstantUtils, uDMList, uDMUtils;

type

  TObjectActionDirectiveMethod = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoDirectiveMethod: TObjectDaoDirectiveMethod;
    FObjectActionDirective: TObjectActionDirective;
    procedure AfterConstruction; override;
    procedure AddData(const poListData: TStringList;
      const pnIDCategory: Integer; const poTagBeginBlock,
      pbTagEndBlock: TValueTag); reintroduce;
  end;

implementation

procedure TObjectActionDirectiveMethod.AddData(const poListData: TStringList;
  const pnIDCategory: Integer; const poTagBeginBlock, pbTagEndBlock: TValueTag);
var
  sIDDirective: string;
begin
  sIDDirective := TDMUtils.GetValueList(poListData, 0);

  if TDMUtils.IsEmpty(sIDDirective) then
    Exit;
  if FObjectActionDirective.FObjectDaoDirective.CDSDados.Locate
    (FObjectActionDirective.FObjectDaoDirective.CDSDadosCOMMAND.FieldName,
    sIDDirective, [loCaseInsensitive]) then
    FindAddOrEdit([FObjectDaoDirectiveMethod.CDSDadosID_DIRECTIVE.FieldName],
      [FObjectActionDirective.FObjectDaoDirective.CDSDadosID_COMMAND.
      AsInteger], True);
end;

procedure TObjectActionDirectiveMethod.AfterConstruction;
begin
  inherited;
  FObjectDaoDirectiveMethod := GetObjectDao as TObjectDaoDirectiveMethod;
  FObjectActionDirective := ListObjectActionChildren.Add(TObjectActionDirective,
    Self) as TObjectActionDirective;
end;

procedure TObjectActionDirectiveMethod.ConfigureBlockMapping;
begin
  inherited;

end;

initialization

RegisterClass(TObjectActionDirectiveMethod);

end.
