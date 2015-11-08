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

unit uDMUtilsDao;

interface

uses
  SysUtils, uConstantUtils, DB, DBClient, MidasLib, uDMUtils;

type
  TDMUtilsDao = class
  private

  public
    class procedure ActiveDataSet(poDataSet: TDataSet);
    class function IsActiveDataSet(poDataSet: TDataSet): Boolean;
    class function Editing(poDataSet: TDataSet): Boolean;
    class procedure Save(poDataSet: TDataSet);
    class function Insert(poDataSet: TDataSet): Boolean;
    class function Edit(poDataSet: TDataSet): Boolean;
    class function Delete(poDataSet: TDataSet): Boolean;
    class procedure Cancel(poDataSet: TDataSet);
    class procedure Clear(poDataSet: TDataSet);
    class procedure Validate(poDataSet: TDataSet);
    class procedure ValidateCampo(poField: TField);
    class function GetFieldID(poDataSet: TDataSet): TField;
  end;

implementation

uses uDMUtilsMessage, uDMException;

{ TDMUtilsDao }

class procedure TDMUtilsDao.ActiveDataSet(poDataSet: TDataSet);
begin
  if not Assigned(poDataSet) then
    Exit;

  if poDataSet.Active then
    poDataSet.Close;
  if TDMUtils.IsEmpty(poDataSet.FieldCount) then
    Exit;

  if poDataSet is TClientDataSet then
    TClientDataSet(poDataSet).CreateDataSet
  else
    poDataSet.Active := True;
end;

class procedure TDMUtilsDao.Cancel(poDataSet: TDataSet);
begin
  if Editing(poDataSet) then
    poDataSet.Cancel;
end;

class procedure TDMUtilsDao.Clear(poDataSet: TDataSet);
begin
  if TDMUtils.IsEmpty(poDataSet) then
    Exit;

  Cancel(poDataSet);
  { if (poDataSet is TClientDataSet) then
    TClientDataSet(poDataSet).EmptyDataSet; }
  TDMUtilsDao.ActiveDataSet(poDataSet);
end;

class function TDMUtilsDao.Delete(poDataSet: TDataSet): Boolean;
begin
  Cancel(poDataSet);
  Result := TDMUtils.ExistValue(poDataSet);
  if Result then
    poDataSet.Delete;
end;

class function TDMUtilsDao.Edit(poDataSet: TDataSet): Boolean;
begin
  if TDMUtils.ExistValue(poDataSet) and (not Editing(poDataSet)) then
    poDataSet.Edit;
  Result := Editing(poDataSet);
end;

class function TDMUtilsDao.Editing(poDataSet: TDataSet): Boolean;
begin
  Result := Assigned(poDataSet) and poDataSet.Active and
    (poDataSet.State in [dsInsert, dsEdit]);
end;

class function TDMUtilsDao.GetFieldID(poDataSet: TDataSet): TField;
var
  nIndex: Integer;
  oField: TField;
begin
  Result := nil;
  for nIndex := nCST_Zero to poDataSet.Fields.Count - nCST_One do
  begin
    oField := poDataSet.Fields[nIndex];
    if Assigned(oField) and (pfInKey in oField.ProviderFlags) and
      (oField is TIntegerField) or (oField is TFloatField) then
    begin
      Result := oField;
      Break;
    end;
  end;
end;

class function TDMUtilsDao.Insert(poDataSet: TDataSet): Boolean;
begin
  if TDMUtilsDao.IsActiveDataSet(poDataSet) and (not(Editing(poDataSet))) then
    poDataSet.Insert;
  Result := Editing(poDataSet);
end;

class function TDMUtilsDao.IsActiveDataSet(poDataSet: TDataSet): Boolean;
begin
  Result := (Assigned(poDataSet) and poDataSet.Active);
end;

class procedure TDMUtilsDao.Save(poDataSet: TDataSet);
begin
  if not Editing(poDataSet) then
    Exit;
  Validate(poDataSet);
  poDataSet.Post;
end;

class procedure TDMUtilsDao.Validate(poDataSet: TDataSet);
var
  vIndex: Integer;
begin
  if TDMUtils.IsEmpty(poDataSet) then
    Exit;

  for vIndex := 0 to poDataSet.Fields.Count - 1 do
  begin
    ValidateCampo(poDataSet.Fields[vIndex]);
  end;
end;

class procedure TDMUtilsDao.ValidateCampo(poField: TField);
begin
  if (not Assigned(poField)) or (not poField.Required) then
    Exit;

  if TDMUtils.IsEmpty(poField) then
  begin
    poField.FocusControl;
    raise eFieldRequerid.Create(Format(sMSG_FieldRequerid,
    [poField.DisplayLabel]));
  end;
end;

end.
