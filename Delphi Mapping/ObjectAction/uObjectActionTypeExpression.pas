unit uObjectActionTypeExpression;

interface

uses
  uObjectAction, uObjectDaoTypeExpression, Classes, Forms, SysUtils,
  uConstantTypeExpression, TypInfo,
  uConstantUtils, uDMUtils, uObjectActionStructureDelphi;

type
  TObjectActionTypeExpression = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoTypeExpression: TObjectDaoTypeExpression;
    procedure AfterConstruction; override;
  end;

implementation

procedure TObjectActionTypeExpression.AfterConstruction;
begin
  inherited;
  FObjectDaoTypeExpression := GetObjectDao as TObjectDaoTypeExpression;
end;

procedure TObjectActionTypeExpression.ConfigureBlockMapping;
begin
  inherited;

end;

initialization

RegisterClass(TObjectActionTypeExpression);

end.
