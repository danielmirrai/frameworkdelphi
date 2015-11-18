unit uObjectActionReferenceFK;

interface

uses
  uObjectAction, uObjectDaoReferenceFK, Classes, Forms, SysUtils, uConstantReferenceFK,
  uObjectActionFields, uDMClasses, uConstantUtils, uDMUtils;

type
  TObjectActionReferenceFK = Class(TObjectAction)
  public
    FObjectDaoReferenceFK: TObjectDaoReferenceFK;
    FObjectActionFields: TObjectActionFields;    
    procedure AfterConstruction; Override;
  end;
  
implementation

procedure TObjectActionReferenceFK.AfterConstruction;
begin
  inherited;
  FObjectDaoReferenceFK := GetObjectDao as TObjectDaoReferenceFK;
  FObjectActionFields := ListObjectActionChildren.Add(TObjectActionFields) as TObjectActionFields;
end;


initialization
  DMClasses.RegisterClass(TObjectActionReferenceFK);

end.