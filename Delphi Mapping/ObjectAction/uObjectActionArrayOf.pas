unit uObjectActionArrayOf;

interface

uses
  uObjectAction, uObjectDaoArrayOf, Classes, Forms, SysUtils, uConstantArrayOf,
  uObjectActionBlockTagInDB, TypInfo, uDMList, uObjectActionStructureDelphi,
  uObjectActionBlockTag, uConstantUtils, uDMUtils;

type
  TObjectActionArrayOf = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoArrayOf: TObjectDaoArrayOf;
    procedure AfterConstruction; override;
  end;

implementation

procedure TObjectActionArrayOf.AfterConstruction;
begin
  inherited;
  FObjectDaoArrayOf := GetObjectDao as TObjectDaoArrayOf;
end;

procedure TObjectActionArrayOf.ConfigureBlockMapping;
begin
  inherited;

end;

initialization

RegisterClass(TObjectActionArrayOf);

end.
