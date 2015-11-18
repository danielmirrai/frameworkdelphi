unit uDMClasses;

interface

uses Classes, Windows, uDMUtils;

type
  TClassOfPersistent = class of TPersistent;
  TListClassOfPersistent = array of TClassOfPersistent;

  TInstaceOfObject = TObject;
  TListInstaceOfObject = array of TInstaceOfObject;

  TDMClasses = class(TObject)
    FListTypeClass: TListClassOfPersistent;
    FLock: TRTLCriticalSection;
  protected
    procedure SetListTypeClass(const Value: TListClassOfPersistent);
    procedure SetLock(const Value: TRTLCriticalSection);
  public
    procedure LockList;
    procedure UnLockList;
    procedure RegisterClass(const poClass: TClassOfPersistent);
    procedure UnRegisterClass(const poClass: TClassOfPersistent);
    constructor Create;
    destructor Destroy; Override;
    property ListTypeClass: TListClassOfPersistent read FListTypeClass write SetListTypeClass;
    property Lock: TRTLCriticalSection read FLock write SetLock;
  end;


  function DMClasses: TDMClasses;

implementation
{ TDMClasses }
var
  vDMClasses: TDMClasses;

function DMClasses: TDMClasses;
begin
  if not Assigned(vDMClasses) then
    vDMClasses := TDMClasses.Create;
  Result := vDMClasses;
end;

constructor TDMClasses.Create;
begin
  InitializeCriticalSection(FLock);
  SetLength(FListTypeClass, 0);

  inherited;
end;

destructor TDMClasses.Destroy;
begin
  DeleteCriticalSection(FLock);
  inherited;
end;

procedure TDMClasses.LockList;
begin
  EnterCriticalSection(FLock);
end;

procedure TDMClasses.RegisterClass(const poClass: TClassOfPersistent);
begin
 { LockList;
  try
   } Classes.RegisterClass(poClass);
   { SetLength(FListTypeClass, Length(FListTypeClass) + 1);
    FListTypeClass[Length(FListTypeClass) - 1] := poClass;
  finally
    UnLockList;
  end;  }
end;

procedure TDMClasses.SetListTypeClass(const Value: TListClassOfPersistent);
begin
  FListTypeClass := Value;
end;

procedure TDMClasses.SetLock(const Value: TRTLCriticalSection);
begin
  FLock := Value;
end;

procedure TDMClasses.UnLockList;
begin
  LeaveCriticalSection(FLock);
end;

procedure TDMClasses.UnRegisterClass(const poClass: TClassOfPersistent);
{var
  I: Integer;}
begin
  {LockList;
  try
   } Classes.unRegisterClass(poClass);
    {for i := 0 to Length(FListTypeClass) - 1 do
    begin
      if FListTypeClass[i] = poClass then
      begin
        FListTypeClass[I] := nil;
        Break;
      end;
    end;
  finally
    UnLockList;
  end;    }
end;

initialization
  vDMClasses := nil;
  
finalization
  TDMUtils.DestroyObject(vDMClasses);
end.
