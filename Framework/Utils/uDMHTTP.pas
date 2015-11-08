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

unit uDMHTTP;

interface

uses
  SysUtils, uConstantUtils,
  IdBaseComponent, IdMultipartFormData, IdComponent, IdTCPConnection,
  IdTCPClient,
  IdHTTP, Classes, forms, uDMList;

type
  TDMHTTP = class(TIdHTTP)
  private
    FURL: string;
    FListFieldNameParams, FListFileNameParams, FListFieldValueParams,
      FListFileValueParams, FListFileContentTypeParams: TStringList;

    procedure SetURL(const Value: string);
    procedure SetListFieldNameParams(const Value: TStringList);
    procedure SetListFileContentTypeParams(const Value: TStringList);
    procedure SetListFileNameParams(const Value: TStringList);
    procedure SetListFileValueParams(const Value: TStringList);
    procedure SetInsertParamsFields(poData: TIdMultiPartFormDataStream);
    procedure SetInsertParamsFiles(poData: TIdMultiPartFormDataStream);
    procedure SetHashParamsFields(var psHashFields: string);
    procedure SetHashParamsFiles(var psHashFields: string);
    procedure AddHashField(var psHashFields: string;
      const psFieldName, psFieldValue: string);
  public
    procedure Clear;
    function AddHash(aNameFieldHash: string = 'HASH'): string;
    procedure AddFieldParams(aName, aValue: string;
      aClearList: Boolean = False); overload;
    procedure AddFieldParams(aName: string; aValue: Integer;
      aClearList: Boolean = False); overload;
    procedure AddFileParams(aName, aFileName, aContentType: string;
      aClearList: Boolean = False);
    property URL: string read FURL write SetURL;
    property ListFieldNameParams: TStringList read FListFieldNameParams
      write SetListFieldNameParams;
    property ListFileNameParams: TStringList read FListFileNameParams
      write SetListFileNameParams;
    property ListFileValueParams: TStringList read FListFileValueParams
      write SetListFileValueParams;
    property ListFileContentTypeParams: TStringList
      read FListFileContentTypeParams write SetListFileContentTypeParams;
    function SendPOST: string;

    function SendGet: string;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

  end;

implementation

uses uDMUtils, MD5;

{ TDMHTTP }

procedure TDMHTTP.AddFieldParams(aName: string; aValue: Integer;
  aClearList: Boolean);
begin
  AddFieldParams(aName, TDMUtils.IntToStr2(aValue), aClearList);
end;

procedure TDMHTTP.AddFieldParams(aName, aValue: string; aClearList: Boolean);
begin
  if not(Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams))
  then
    Exit;

  if aClearList then
  begin
    FListFieldNameParams.Clear;
    FListFieldValueParams.Clear;
  end;
  FListFieldNameParams.Add(aName);
  FListFieldValueParams.Add(aValue);
end;

procedure TDMHTTP.AddFileParams(aName, aFileName, aContentType: string;
  aClearList: Boolean = False);
begin
  if not(Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams))
  then
    Exit;

  if aClearList then
  begin
    FListFileNameParams.Clear;
    FListFileValueParams.Clear;
    FListFileContentTypeParams.Clear;
  end;

  FListFileNameParams.Add(aName);
  FListFileValueParams.Add(aFileName);
  FListFileContentTypeParams.Add(aContentType);
end;

function TDMHTTP.AddHash(aNameFieldHash: string): string;
begin
  Result := sCST_EmptyStr;
  SetHashParamsFields(Result);

  SetHashParamsFiles(Result);

  if TDMUtils.IsEmpty(Result) then
    Exit;

  Result := MD5DigestToStr(MD5String(Result + '!' + cHashKey));
  AddFieldParams(aNameFieldHash, Result);
end;

procedure TDMHTTP.AddHashField(var psHashFields: string;
  const psFieldName, psFieldValue: string);
begin
  if TDMUtils.LocateStr('HASH', psFieldName) then
    Exit;

  if not TDMUtils.IsEmpty(psHashFields) then
    psHashFields := psHashFields + '!';

  psHashFields := psHashFields + psFieldValue;
end;

procedure TDMHTTP.AfterConstruction;
begin
  inherited;
  FListFieldNameParams := TStringList.Create;
  FListFieldValueParams := TStringList.Create;
  FListFileNameParams := TStringList.Create;
  FListFileValueParams := TStringList.Create;
  FListFileContentTypeParams := TStringList.Create;
  HTTPOptions := [hoForceEncodeParams];
  Clear;
end;

procedure TDMHTTP.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FListFieldNameParams);
  TDMUtils.DestroyObject(FListFieldValueParams);
  TDMUtils.DestroyObject(FListFileNameParams);
  TDMUtils.DestroyObject(FListFileValueParams);
  TDMUtils.DestroyObject(FListFileContentTypeParams);
  inherited;
end;

procedure TDMHTTP.Clear;
begin
  if Assigned(FListFieldNameParams) then
    FListFieldNameParams.Clear;

  if Assigned(FListFieldValueParams) then
    FListFieldValueParams.Clear;

  if Assigned(FListFileNameParams) then
    FListFileNameParams.Clear;

  if Assigned(FListFileValueParams) then
    FListFileValueParams.Clear;

  if Assigned(FListFileContentTypeParams) then
    FListFileContentTypeParams.Clear;
  FURL := sCST_EmptyStr;
end;

procedure TDMHTTP.SetHashParamsFields(var psHashFields: string);
var
  nIndex: Integer;
begin
  if not(((Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams))
    and (FListFieldNameParams.Count = FListFieldValueParams.Count))) then
    Exit;

  for nIndex := 0 to FListFieldNameParams.Count - 1 do
  begin
    if (not TDMUtils.IsEmpty(FListFieldNameParams.Strings[nIndex])) then
      AddHashField(psHashFields, FListFieldNameParams.Strings[nIndex],
        FListFieldValueParams.Strings[nIndex]);
  end;
end;

procedure TDMHTTP.SetHashParamsFiles(var psHashFields: string);
var
  nIndex: Integer;
begin
  if not(((Assigned(FListFileNameParams) and Assigned(FListFileValueParams) and
    (Assigned(FListFileContentTypeParams))) and
    (FListFileNameParams.Count = FListFileValueParams.Count) and
    (FListFileValueParams.Count = FListFileContentTypeParams.Count))) then
    Exit;

  for nIndex := 0 to FListFileNameParams.Count - 1 do
  begin
    if (not TDMUtils.IsEmpty(FListFileNameParams.Strings[nIndex])) then
      AddHashField(psHashFields, FListFileNameParams.Strings[nIndex],
        MD5DigestToStr(MD5File(FListFileValueParams.Strings[nIndex])));
  end;
end;

procedure TDMHTTP.SetInsertParamsFields(poData: TIdMultiPartFormDataStream);
var
  nIndex: Integer;
begin
  if not(((Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams))
    and (FListFieldNameParams.Count = FListFieldValueParams.Count))) then
    Exit;

  for nIndex := 0 to FListFieldNameParams.Count - 1 do
  begin
    if (not TDMUtils.IsEmpty(FListFieldNameParams.Strings[nIndex])) then
      poData.AddFormField(FListFieldNameParams.Strings[nIndex],
        FListFieldValueParams.Strings[nIndex]);
  end;
end;

procedure TDMHTTP.SetInsertParamsFiles(poData: TIdMultiPartFormDataStream);
var
  nIndex: Integer;
begin
  if not(((Assigned(FListFileNameParams) and Assigned(FListFileValueParams) and
    (Assigned(FListFileContentTypeParams))) and
    (FListFileNameParams.Count = FListFileValueParams.Count) and
    (FListFileValueParams.Count = FListFileContentTypeParams.Count))) then
    Exit;

  for nIndex := 0 to FListFileNameParams.Count - 1 do
  begin
    if (not TDMUtils.IsEmpty(FListFileNameParams.Strings[nIndex])) then
      poData.AddFile(FListFileNameParams.Strings[nIndex],
        FListFileValueParams.Strings[nIndex],
        FListFileContentTypeParams.Strings[nIndex]);
  end;
end;

procedure TDMHTTP.SetListFieldNameParams(const Value: TStringList);
begin
  FListFieldNameParams := Value;
end;

procedure TDMHTTP.SetListFileContentTypeParams(const Value: TStringList);
begin
  FListFileContentTypeParams := Value;
end;

procedure TDMHTTP.SetListFileNameParams(const Value: TStringList);
begin
  FListFileNameParams := Value;
end;

procedure TDMHTTP.SetListFileValueParams(const Value: TStringList);
begin
  FListFileValueParams := Value;
end;

procedure TDMHTTP.SetURL(const Value: string);
begin
  FURL := Value;
end;

function TDMHTTP.SendGet: string;
var
  vIndex: Integer;
  vSucess: Boolean;
begin
  Result := sCST_EmptyStr;
  vIndex := nCST_Zero;
  vSucess := False;
  while ((vIndex < 3) and (not vSucess)) do
  begin
    try
      vSucess := True;
      Result := Get(FURL);
    except
      vSucess := False;
      Inc(vIndex);
    end;
  end;
end;

function TDMHTTP.SendPOST: string;
var
  aData: TIdMultiPartFormDataStream;
  vIndex: Integer;
  vSucess: Boolean;
begin
  Result := sCST_EmptyStr;
  aData := nil;
  try
    try
      aData := TIdMultiPartFormDataStream.Create;

      SetInsertParamsFields(aData);
      SetInsertParamsFiles(aData);

      vIndex := nCST_Zero;
      vSucess := False;
      while ((vIndex < 3) and (not vSucess)) do
      begin
        try
          vSucess := True;
          Result := Post(FURL, aData);
        except
          vSucess := False;
          Inc(vIndex);
        end;
      end;
    except
      Result := sCST_EmptyStr;
      TDMUtils.MyException('Send data http');
    end;
  finally
    TDMUtils.DestroyObject(aData);
  end;
end;

end.
