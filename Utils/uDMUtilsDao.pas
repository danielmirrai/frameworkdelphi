{***********************************************************}
{                                                           }
{                Developed by Daniel Mirrai                 }
{                                                           }
{                Senior Delphi Programmer                   }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{                   www.danielmirrai.com                    }
{***********************************************************}

unit uDMUtilsDao;

interface
uses
  SysUtils, uConstantUtils, DB, DBClient, MidasLib, uDMUtils;

type
  TDMUtilsDao = class
  private

  public
    class function Editing(aDataSet: TDataSet): Boolean;
    class function Save(aDataSet: TDataSet): Boolean;
    class function Insert(aDataSet: TDataSet): Boolean; virtual;
    class function Edit(aDataSet: TDataSet): Boolean; virtual;
    class function ExistData(aDataSet: TDataSet): Boolean;
    class procedure Cancel(aDataSet: TDataSet); virtual;
    class procedure Clear(aDataSet: TClientDataSet); virtual;
    class function Validate(aDataSet: TDataSet): Boolean; virtual;
    class function ValidateField(aField: TField): Boolean;

  end;
implementation

uses uDMUtilsMessage;

{ TDMUtilsDao }

class procedure TDMUtilsDao.Cancel(aDataSet: TDataSet);
begin
  if Editing(aDataSet) then
    aDataSet.Cancel;
end;

class procedure TDMUtilsDao.Clear(aDataSet: TClientDataSet);
begin
  Cancel(aDataSet);
  aDataSet.EmptyDataSet;
end;

class function TDMUtilsDao.Edit(aDataSet: TDataSet): Boolean;
begin
  if ExistData(aDataSet) and (not (Editing(aDataSet))) then
    aDataSet.Edit;
  Result := Editing(aDataSet);
end;

class function TDMUtilsDao.Editing(aDataSet: TDataSet): Boolean;
begin
  Result := aDataSet.State in [dsInsert, dsEdit];
end;

class function TDMUtilsDao.ExistData(aDataSet: TDataSet): Boolean;
begin
  Result := (aDataSet.RecordCount > nCST_Zero);
end;

class function TDMUtilsDao.Insert(aDataSet: TDataSet): Boolean;
begin
  if not (Editing(aDataSet)) then
    aDataSet.Insert;
  Result := Editing(aDataSet);
end;

class function TDMUtilsDao.Save(aDataSet: TDataSet): Boolean;
begin
  Result := False;
  if (Editing(aDataSet)) then
  begin
    if Validate(aDataSet) then
    begin
      aDataSet.Post;
      Result := True;
    end;
  end;
end;

class function TDMUtilsDao.Validate(aDataSet: TDataSet): Boolean;
var
  vIndex: Integer;
begin
  Result := True;
  for vIndex := 0 to aDataSet.Fields.Count - 1 do
  begin
    Result := ValidateField(aDataSet.Fields[vIndex]);
    if not Result then
      Abort;
  end;
end;

class function TDMUtilsDao.ValidateField(aField: TField): Boolean;
begin
  Result := True;
  if aField.Required then
  begin
    try
      Result := not TDMUtils.isEmpty(aField);
      if not Result then
      begin
        case aField.Tag of
          1: TDMUtilsMessage.ShowMessageError(sCST_The + sCST_Space + aField.DisplayLabel + sCST_IsRequired);
          2: TDMUtilsMessage.ShowMessageError(sCST_An + sCST_Space + aField.DisplayLabel + sCST_IsRequired);
        else
          TDMUtilsMessage.ShowMessageError(aField.DisplayLabel + sCST_IsRequired);
        end;
        aField.FocusControl;
      end;
    except

      TDMUtils.MyException(sCST_ErroValidateField);
      exit;
    end;
  end;
end;

end.
