unit uObjectActionFields;

interface

uses
  uObjectAction, uObjectDaoFields, Classes, Forms, SysUtils, uConstantFields, 
  uDMRTTI, uConstantUtils, uDMUtils;

type
  TObjectActionFields = Class(TObjectAction)
  public
    FObjectDaoFields: TObjectDaoFields;
    procedure AfterConstruction; override;
  end;
  
implementation

procedure TObjectActionFields.AfterConstruction;
begin
  inherited;
  FObjectDaoFields := GetObjectDao as TObjectDaoFields;
end;

initialization
  DMRTTI.RegisterClass(TObjectActionFields);

end.
