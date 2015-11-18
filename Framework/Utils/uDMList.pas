{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }

unit uDMList;

interface

uses Classes, Contnrs, uConstantUtils;

type
  TListOfStringList = class;

  TListOfStringList = class(TObjectList)
  private
    FBackup: TListOfStringList;
  protected
    function GetBackup: TListOfStringList; Virtual;
    function GetItems(Index: Integer): TStringList; Virtual;
    procedure SetItems(Index: Integer; const Value: TStringList); Virtual;
    procedure SetBackup(const Value: TListOfStringList); Virtual;
  public
    function Add: TStringList; overload;
    function Add(aList: TStringList): TStringList; overload;
    function Add(aText: string): TStringList; overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure NewBackup(const pbClearOldValue: Boolean = True);
    procedure RevertBackup(const pbClearOldValue: Boolean = False); virtual;
    procedure Assign(Source: TObject); Reintroduce; Overload; virtual;
    procedure Assign(Source: TObject; const pbClearOldValue: Boolean); Reintroduce; overload; virtual;
    function GetMD5: string; Virtual;

    property Items[Index: Integer]: TStringList read GetItems write SetItems;

    property Backup: TListOfStringList read GetBackup write SetBackup;
  end;

implementation

uses MD5, uDMUtils, uFactoryObject, SysUtils;
{ TListOfStringList }

function TListOfStringList.Add: TStringList;
var
  vNew: TStringList;
begin
  vNew := TStringList.Create;
  Result := Add(vNew);
end;

function TListOfStringList.Add(aList: TStringList): TStringList;
begin
  inherited Add(aList);
  Result := aList;
end;

function TListOfStringList.Add(aText: string): TStringList;
var
  vNewList: TStringList;
begin
  vNewList := TStringList.Create;
  try
    vNewList.Text := aText;
  except
    FreeAndNil(vNewList);
    raise;
  end;
  Result := Add(vNewList);
end;

procedure TListOfStringList.Assign(Source: TObject);
begin
  Assign(Source, True);
end;

procedure TListOfStringList.Assign(Source: TObject; const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oItem: TListOfStringList;
  oStringListTemp: TStringList;
begin
  if not(Assigned(Source) and (Source is TListOfStringList)) then
    Exit;

  oItem := TListOfStringList(Source);
  if (oItem.Count <> Self.Count) then
  begin
    if pbClearOldValue then
      Self.Clear;
    for nIndex := 0 to oItem.count - 1 do
    begin
      Self.Add(oItem.Items[nIndex].Text);
    end;
  end
  else
  begin
    for nIndex := 0 to oItem.count - 1 do
    begin
      if Assigned(Self.Items[nIndex]) then
      begin
        oStringListTemp := Self.Items[nIndex];
        TDMUtils.AssignStringList(oStringListTemp, oItem.Items[nIndex], pbClearOldValue);
        Self.Items[nIndex] := oStringListTemp;
      end;
    end;
  end;
end;

constructor TListOfStringList.Create;
begin
  inherited Create;
  FBackup := nil;
end;

destructor TListOfStringList.Destroy;
begin
  TDMUtils.DestroyObject(FBackup);
  inherited Destroy;
end;

function TListOfStringList.GetBackup: TListOfStringList;
begin
  Result := FBackup;
end;

function TListOfStringList.GetItems(Index: Integer): TStringList;
begin
   Result := TStringList(inherited Items[index]);
end;

function TListOfStringList.GetMD5: string;
var
  nIndex: Integer;
begin
  Result := '';
  for nIndex := 0 to self.Count - 1 do
  begin
    if assigned(self.Items[nIndex]) then
      Result := Result + MD5String2(self.Items[nIndex]);
  end;
  Result := MD5String2(Result);
end;

procedure TListOfStringList.NewBackup(const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oList: TStringList;
begin
  if not assigned(FBackup) then
    FBackup := TListOfStringList.Create;
  for nIndex := 0 to self.Count - 1 do
  begin
    oList := self.Items[nIndex];
    if assigned(oList) then
      FBackup.Add(oList.Text);
  end;
  if pbClearOldValue then
    self.Clear;
end;

procedure TListOfStringList.RevertBackup(const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oList: TStringList;
begin
  if (pbClearOldValue) then
    self.Clear;
  if not assigned(FBackup) then
    Exit;

  for nIndex := 0 to FBackup.Count - 1 do
  begin
    oList := FBackup.Items[nIndex];
    if assigned(oList) then
      self.Add(oList.Text);
  end;
  TDMUtils.DestroyObject(FBackup);
end;

procedure TListOfStringList.SetBackup(const Value: TListOfStringList);
begin
  FBackup := Value;
end;

procedure TListOfStringList.SetItems(Index: Integer; const Value: TStringList);
begin
  inherited Items[Index] := Value;
end;

end.
