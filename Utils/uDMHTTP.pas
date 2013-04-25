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

unit uDMHTTP;

interface
uses
  IdBaseComponent, IdMultipartFormData, SysUtils,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Classes, forms;

type
  TDMHTTP = class(TIdHTTP)
  private
    FURL: string;
    FListFieldNameParams,
      FListFileNameParams,
      FListFieldValueParams,
      FListFileValueParams,
      FListFileContentTypeParams: TStringList;

    procedure SetURL(const Value: string);
    procedure SetListFieldNameParams(const Value: TStringList);
    procedure SetListFileContentTypeParams(const Value: TStringList);
    procedure SetListFileNameParams(const Value: TStringList);
    procedure SetListFileValueParams(const Value: TStringList);
    procedure SetInsertParamsFields(poData: TIdMultiPartFormDataStream);
    procedure SetInsertParamsFiles(poData: TIdMultiPartFormDataStream);
    procedure SetHashParamsFields(var psHashFields: string);
    procedure SetHashParamsFiles(var psHashFields: string);
    procedure AddHashField(var psHashFields: string; const psFieldName, psFieldValue: string);
  public
    procedure Clear;
    function AddHash(aNameFieldHash: string = 'HASH'): string;
    procedure AddFieldParams(aName, aValue: string; aClearList: Boolean = False); overload;
    procedure AddFieldParams(aName: string; aValue: Integer; aClearList: Boolean = False); overload;
    procedure AddFileParams(aName, aFileName, aContentType: string; aClearList: Boolean = False);
    property URL: string read FURL write SetURL;
    property ListFieldNameParams: TStringList read FListFieldNameParams write SetListFieldNameParams;
    property ListFileNameParams: TStringList read FListFileNameParams write SetListFileNameParams;
    property ListFileValueParams: TStringList read FListFileValueParams write SetListFileValueParams;
    property ListFileContentTypeParams: TStringList read FListFileContentTypeParams write SetListFileContentTypeParams;
    function SendPOST: string;

    function SendGet: string;
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);

    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Integer);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

  end;
implementation

uses uDMUtils, uDMUtilsVariant, MD5, uConstantUtils;

{ TDMHTTP }

procedure TDMHTTP.AddFieldParams(aName: string; aValue: Integer;
  aClearList: Boolean);
begin
  AddFieldParams(aName, TDMUtils.IntToStr2(aValue), aClearList);
end;

procedure TDMHTTP.AddFieldParams(aName, aValue: string;
  aClearList: Boolean);
begin
  if Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams) then
  begin
    if aClearList then
    begin
      FListFieldNameParams.Clear;
      FListFieldValueParams.Clear;
    end;
    FListFieldNameParams.Add(aName);
    FListFieldValueParams.Add(aValue);
  end;
end;

procedure TDMHTTP.AddFileParams(aName, aFileName,
  aContentType: string; aClearList: Boolean = False);
begin
  if Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams) then
  begin
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
end;

function TDMHTTP.AddHash(aNameFieldHash: string): string;
begin
  Result := '';
  SetHashParamsFields(Result);

  SetHashParamsFiles(Result);

  if not TdmUtils.IsEmpty(Result) then
  begin
    Result := MD5DigestToStr(MD5String(Result + '!' + cHashKey));
    AddFieldParams(aNameFieldHash, Result);
  end;
end;

procedure TDMHTTP.AddHashField(var psHashFields: string; const psFieldName,
  psFieldValue: string);
begin
  if not TDMUtils.LocateStr('HASH', psFieldName) then
  begin
    if not TDMUtils.IsEmpty(psHashFields) then
      psHashFields := psHashFields + '!';

    psHashFields := psHashFields + TDMUtilsVariant.FormatValue(psFieldValue);
  end;
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
  OnWork := IdHTTPWork;
  OnWorkBegin := IdHTTPWorkBegin;
  OnWorkEnd := IdHTTPWorkEnd;
  OnStatus := IdHTTPStatus;
  Clear;
end;

procedure TDMHTTP.BeforeDestruction;
begin
  TdmUtils.DestroyObject(FListFieldNameParams);
  TdmUtils.DestroyObject(FListFieldValueParams);
  TdmUtils.DestroyObject(FListFileNameParams);
  TdmUtils.DestroyObject(FListFileValueParams);
  TdmUtils.DestroyObject(FListFileContentTypeParams);
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
  FURL := '';
end;

procedure TDMHTTP.IdHTTPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Application.ProcessMessages;
end;

procedure TDMHTTP.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
  Application.ProcessMessages;
end;

procedure TDMHTTP.IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Integer);
begin
  Application.ProcessMessages;
end;

procedure TDMHTTP.IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  Application.ProcessMessages;
end;

procedure TDMHTTP.SetHashParamsFields(var psHashFields: string);
var
  nIndex: Integer;
begin
  if ((Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams)) and
    (FListFieldNameParams.Count = FListFieldValueParams.Count)) then
  begin
    for nIndex := 0 to FListFieldNameParams.Count - 1 do
    begin
      if (not TDMUtils.IsEmpty(FListFieldNameParams.Strings[nIndex])) then
        AddHashField(psHashFields, FListFieldNameParams.Strings[nIndex], FListFieldValueParams.Strings[nIndex]);
    end;
  end;
end;

procedure TDMHTTP.SetHashParamsFiles(var psHashFields: string);
var
  nIndex: Integer;
begin
  if ((Assigned(FListFileNameParams) and Assigned(FListFileValueParams) and (Assigned(FListFileContentTypeParams))) and
    (FListFileNameParams.Count = FListFileValueParams.Count) and (FListFileValueParams.Count = FListFileContentTypeParams.Count)) then
  begin
    for nIndex := 0 to FListFileNameParams.Count - 1 do
    begin
      if (not TDMUtils.IsEmpty(FListFileNameParams.Strings[nIndex])) then
        AddHashField(psHashFields, FListFileNameParams.Strings[nIndex], MD5DigestToStr(MD5File(FListFileValueParams.Strings[nIndex])));
    end;
  end;
end;

procedure TDMHTTP.SetInsertParamsFields(poData: TIdMultiPartFormDataStream);
var
  nIndex: Integer;
begin
  //{$REGION 'Insert params Fields'}
  if ((Assigned(FListFieldNameParams) and Assigned(FListFieldValueParams)) and
    (FListFieldNameParams.Count = FListFieldValueParams.Count)) then
  begin
    for nIndex := 0 to FListFieldNameParams.Count - 1 do
    begin
      if (not TdmUtils.IsEmpty(FListFieldNameParams.Strings[nIndex])) then
        poData.AddFormField(FListFieldNameParams.Strings[nIndex], FListFieldValueParams.Strings[nIndex]);
    end;
  end;
  //{$ENDREGION}
end;

procedure TDMHTTP.SetInsertParamsFiles(poData: TIdMultiPartFormDataStream);
var
  nIndex: Integer;
begin
  //{$REGION 'Insert params Files'}
  if ((Assigned(FListFileNameParams) and Assigned(FListFileValueParams) and (Assigned(FListFileContentTypeParams))) and
    (FListFileNameParams.Count = FListFileValueParams.Count) and (FListFileValueParams.Count = FListFileContentTypeParams.Count)) then
  begin
    for nIndex := 0 to FListFileNameParams.Count - 1 do
    begin
      if (not TdmUtils.IsEmpty(FListFileNameParams.Strings[nIndex])) then
        poData.AddFile(FListFileNameParams.Strings[nIndex], FListFileValueParams.Strings[nIndex], FListFileContentTypeParams.Strings[nIndex]);
    end;
  end;
  //{$ENDREGION}
end;

procedure TDMHTTP.SetListFieldNameParams(const Value: TStringList);
begin
  FListFieldNameParams := Value;
end;

procedure TDMHTTP.SetListFileContentTypeParams(
  const Value: TStringList);
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
  try
    Result := '';
    vIndex := 0;
    vSucess := False;
    while ((vIndex < 3) and (not vSucess)) do
    begin
      try
        vSucess := True;
        Result := Get(FURL);
      except
        on E: Exception do
        begin
          vSucess := False;
          Inc(vIndex);
        end;
      end;
    end;
  finally

  end;
end;

function TDMHTTP.SendPOST: string;
var
  aData: TIdMultiPartFormDataStream;
  vIndex: Integer;
  vSucess: Boolean;
begin
  Result := '';
  aData := nil;
  try
    try
      aData := TIdMultiPartFormDataStream.Create;

      SetInsertParamsFields(aData);
      SetInsertParamsFiles(aData);

      vIndex := 0;
      vSucess := False;
      while ((vIndex < 3) and (not vSucess)) do
      begin
        try
          vSucess := True;
          Result := Post(FURL, aData);
        except
          on E: Exception do
          begin
            vSucess := False;
            Inc(vIndex);
          end;
        end;
      end;

    except
      on E: Exception do
      begin
        Result := '';
        Assert(False, e.Message);
      end;
    end;
  finally
    TdmUtils.DestroyObject(aData);
  end;
end;

end.
