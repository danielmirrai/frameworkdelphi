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

unit uDMException;

interface

uses
  System.SysUtils;

type
  eDMExcepetion = class(Exception);
  eListDataError = class(Exception);
  eNotExistsClassAction = class(eDMExcepetion);
  eFieldRequerid = class(eDMExcepetion);
  eFileNotExist = class(eDMExcepetion);
  eDataError = class(eDMExcepetion);

  TDMException = class
    class function GetMessageException: String;
    class procedure TreatException; Overload;
    class procedure TreatException(const psMessage: string); Overload;
    class function Aborting: Boolean;

  end;

const
  sMSG_NotExistsClassAction = 'Not exists class action %s';
  sMSG_DataError = 'Registro não é valido.';
  sMSG_ListDataError = 'Lista de dados não é valida.';
  sMSG_FieldRequerid = 'O "%s" deve ser preenchido.';
  sMSG_FileNotExist = 'Não foi encontrado o arquivo "%s".';

implementation

{ TDMException }

uses uConstantUtils, uDMUtilsMessage, uDMUtils;

class function TDMException.Aborting: Boolean;
begin
  Result := (ExceptObject <> nil) and (ExceptObject is EAbort);
end;

class function TDMException.GetMessageException: String;
begin
  Result := sCST_EmptyStr;
  if (ExceptObject <> nil) and (ExceptObject is Exception) then
    Result := Exception(ExceptObject).Message
end;

class procedure TDMException.TreatException;
begin
  TreatException(GetMessageException);
end;

class procedure TDMException.TreatException(const psMessage: string);
begin
  if TDMUtils.ExistValue(psMessage) then
    TDMUtilsMessage.ShowMessageOk(psMessage);
  abort;
end;

end.
