unit uObjectActionImage;

interface
uses
  uObjectAction, ExtCtrls, Windows, Classes, XMLDoc,
  Forms, Graphics, jpeg, uObjectDaoImage, SysUtils,
  uDMUtils, uConstantImage, uDMUtilsImage, uConstantSystem,
  MidasLib, XMLIntf, uDMHTTP, uDMSevenZip;

type
  TObjectActionImage = class(TObjectAction)
    procedure TimerOnTimer(Sender: TObject);
  private
    FTimeCaptura: TTimer;
    FDMSevenZip: TDMSevenZip;
  protected
  public                 
    FDMHTTP: TDMHTTP;
    procedure ClearData;
    procedure ClearImage;
    procedure Capture;
    procedure Load;
    procedure Active;
    procedure Disable;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function GetDirectoryImage: string;
    function GetNameImage: string;
//    function GetFileNameZIP: String;
    function SendImage: Boolean;
//    function Compact: Boolean; Overload;
    function getPassword: string;
//    function Compact(aFiles: TStringList): boolean; Overload;
    function GetObjectDao: TObjectDaoImage; reintroduce;
  end;
implementation

uses uDMUtilsMessage, uInterfaceXMLErro, uInterfaceXMLSucesso;


{ TObjectActionImage }

procedure TObjectActionImage.AfterConstruction;
begin
  inherited;
  FDMSevenZip := TDMSevenZip.Create;
  FDMHTTP     := TDMHTTP.Create(nil);

  FTimeCaptura  := TTimer.Create(nil);
  FTimeCaptura.OnTimer := TimerOnTimer;
  FTimeCaptura.Interval := cTimeCaptureImage;
  Disable;
end;

procedure TObjectActionImage.Active;
begin
  Load;
  FTimeCaptura.Enabled := True;
  Capture;
end;

procedure TObjectActionImage.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FTimeCaptura);
  TDMUtils.DestroyObject(FDMSevenZip);
  TDMUtils.DestroyObject(FDMHTTP);
  inherited;
end;

procedure TObjectActionImage.Capture;
var
  vNameImage: string;
begin
  if (TConstantSystem.GetUserActive <> 0) then
  begin
    GetObjectDao.Insert;
    GetObjectDao.CDSDadosCODIGO.AsInteger       := GetObjectDao.IncAutoIncrement;
    GetObjectDao.CDSDadosID_SECAO.AsInteger     := TConstantSystem.GetSectionActive;
    GetObjectDao.CDSDadosDATA.AsDateTime        := now;
    vNameImage := GetNameImage;
    TDMUtilsImage.CaptureScreen(vNameImage);
    GetObjectDao.CDSDadosID_PARTIDA.AsInteger   := TConstantSystem.GetGameActive;
    if FileExists(vNameImage) then
      GetObjectDao.Save
    else
    begin
      FObjectDao.Cancel;
      GetObjectDao.IncAutoIncrement(-1);
    end;
  end;
end;

procedure TObjectActionImage.ClearData;
begin
  TDMUtils.DeleteDir(GetDirectoryImage);
//  TDMUtils.DeleteFile2(GetFileNameZIP);
end;

procedure TObjectActionImage.ClearImage;
begin
  TDMUtils.DeleteFile2(GetNameImage);
end;

{function TObjectActionImage.Compact: Boolean;
var
  vList: TStringList;
begin
  Application.ProcessMessages;
  vList   := nil;
  Result  := False;
  try
    vList := TStringList.Create;
    GetObjectDao.CDSDados.First;
    while not GetObjectDao.CDSDados.Eof do
    begin
      if FileExists(GetNameImage) then
        vList.Add(GetNameImage);
      GetObjectDao.CDSDados.Next;
    end;
    if (vList.Count > 0) then
      Result := Compact(vList);
  finally
    TDMUtils.DestroyObject(vList);
  end;
end;

{function TObjectActionImage.Compact(aFiles: TStringList):
  boolean;
begin
  try
    TDMUtils.DeleteFile2(GetFileNameZIP);
    FDMSevenZip.SetZipName(GetFileNameZIP);
  //  FDMSevenZip.SevenZip.Password   := getPassword;
    FDMSevenZip.SevenZip.AddRootDir := PChar(GetDirectoryImage);
    Result := FDMSevenZip.AddFile(aFiles);
  except
      Result := False;
      raise Exception.Create('Erro ao compactar imagens!'+#13+#10+
        'Erro: '+e.Message);
      exit;
  end;
end;  }

procedure TObjectActionImage.Disable;
begin
  FTimeCaptura.Enabled := False;

end;

function TObjectActionImage.GetDirectoryImage: string;
begin
  Result := TDMUtils.GetDirectoryTemp+ TConstantSystem.GetUserActiveFormat + '\';
end;

{function TObjectActionImage.GetFileNameZIP: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'imagens\'+TConstantSystem.GetUserActiveFormat+'.zip';
end;}

function TObjectActionImage.GetNameImage: string;
begin
  Result := GetDirectoryImage + TDMUtils.FormatValue('000000',
    GetObjectDao.CDSDadosCODIGO.AsInteger)+'_'+TDMUtils.FormatDateTime2('ddmmyyyy_hhmmss', GetObjectDao.CDSDadosDATA.AsDateTime) + '.tmp';
end;

function TObjectActionImage.GetObjectDao: TObjectDaoImage;
begin
  Result := TObjectDaoImage(inherited GetObjectDao);
end;

function TObjectActionImage.getPassword: string;
begin
  Result := 'admin'+TConstantSystem.GetUserActiveFormat;
end;

procedure TObjectActionImage.Load;
var
  vListFiles: TStringList;
  vIndex, vID: Integer;
  vDate: String;
begin
  try
    if (TConstantSystem.GetUserActive <> 0) then
    begin
      vListFiles := TStringList.Create;
      TDMUtils.ListFileDir(GetDirectoryImage, vListFiles, []);
      if Assigned(vListFiles) then
      begin
        for vIndex := 0 to vListFiles.Count -1 do
        begin
          vID := TDMUtils.StrToInt2(Copy(ExtractFileName(vListFiles.Strings[vIndex]),1, 6));
          vDate := Copy(ExtractFileName(vListFiles.Strings[vIndex]),8, 15);
          GetObjectDao.Insert;
          GetObjectDao.CDSDadosCODIGO.AsInteger       := vID;
          GetObjectDao.NextID := vID;
          GetObjectDao.CDSDadosID_SECAO.AsInteger     := TConstantSystem.GetSectionActive;
          GetObjectDao.CDSDadosDATA.AsDateTime        := TDMUtils.StrToDateTime2('DDMMYYYY HHMMSS',vDate);
          GetObjectDao.CDSDadosID_PARTIDA.AsInteger   := TConstantSystem.GetGameActive;
          GetObjectDao.Save;
        end;
      end;
    end;
  except
    ClearData;
    raise Exception.Create('Erro ao buscar imagens!');
    exit;
  end;
end;

function TObjectActionImage.SendImage: Boolean;
var
  vReturn: String;
  vXMLSucesso: IXMLSucessoType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
begin  
  Result := False;      
  try
    try
      if (FTimeCaptura.Enabled and (TConstantSystem.GetSectionActive > 0)) then
      begin
        Disable;
        if (GetObjectDao.ExistData) then
        begin
          vReturn := '';
          GetObjectDao.CDSDados.DisableControls;
          GetObjectDao.CDSDados.First;
          Result := True;
          while not GetObjectDao.CDSDados.Eof do
          begin
            if FileExists(GetNameImage) then
            begin
              FDMHTTP.Clear;
              FDMHTTP.URL := TConstantSystem.GetSiteAPIImage;
              FDMHTTP.AddFieldParams('SESS_ID',TConstantSystem.GetSectionActive);
              FDMHTTP.AddFieldParams('NOME_ARQUIVO',TConstantSystem.GetUserActiveFormat);
              FDMHTTP.AddFileParams('ARQUIVO', GetNameImage, '.jpg');
              //FDMHTTP.AddHash;
              vReturn := FDMHTTP.SendPOST;

              if (not TDMUtils.IsEmpty(vReturn)) then
              begin
                vXML    := TDMUtils.GetXML(vReturn);

                if TDMUtils.LocateStr('<sucesso>', vReturn) then
                begin
                  vXMLSucesso := Getsucesso(vXML);
                  if (UpperCase(vXMLSucesso.CalculaHash) <> UpperCase(vXMLSucesso.Hash)) then
                  begin
                    Result := False;
                    raise Exception.Create('Erro ao enviar imagens: Hash invalido!'+#13+
                    'Enviado: '+ UpperCase(vXMLSucesso.CalculaHash)+#13+
                    'Recebido: '+ UpperCase(vXMLSucesso.Hash));
                  end
                  else
                  begin
                    raise Exception.Create('Imagens enviadas com sucesso!'+#13+
                                                  'Imagem: '+GetObjectDao.CDSDadosCODIGO.AsString+' - '+GetNameImage);

                    ClearImage;
                  end;
                end
                else
                begin
                  Result := False;
                  vXMLErro := GetErro(vXML);
                  if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
                  begin
                    raise Exception.Create('Imagens: Hash invalido!'+#13+
                      'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
                      'Recebido: '+ UpperCase(vXMLErro.Hash));
                  end
                  else
                  begin
                    raise Exception.Create('Imagens: '+TDMUtils.IntToStr2(vXMLErro.Codigo) +' - '+ vXMLErro.Mensagem);
                  end;
                end;
              end
              else
              begin
                Result := False;
                raise Exception.Create('Erro ao enviar imagens!');
              end;
            end;
            GetObjectDao.CDSDados.Next;
          end;
        end
        else
          Result := True;           
      end;
      if Result  then
        ClearData;
    except
        Result := False;
        raise Exception.Create('Erro ao enviar imagens!'+#13+#10+'Retorno: '+vReturn);
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
    Disable;
    if Result then
      Application.Terminate;
  end;
end;

procedure TObjectActionImage.TimerOnTimer(Sender: TObject);
begin
  Capture;
end;

initialization
  RegisterClass(TObjectActionImage);
  
end.

