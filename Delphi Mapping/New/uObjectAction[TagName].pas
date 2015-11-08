unit uObjectAction[TagName];

interface

uses
  uObjectAction, uObjectDao[TagName], Classes, Forms, SysUtils, uConstant[TagName], System.TypInfo,
  uConstantUtils, uDMUtils;

type
  TObjectAction[TagName] = Class(TObjectAction)
  private
  public
    FObjectDao[TagName]: TObjectDao[TagName];
    procedure AfterConstruction; override;
  end;
  
implementation

procedure TObjectAction[TagName].AfterConstruction;
begin
  inherited;
  FObjectDao[TagName] := GetObjectDao as TObjectDao[TagName];
end;

initialization
  RegisterClass(TObjectAction[TagName]);

end.
