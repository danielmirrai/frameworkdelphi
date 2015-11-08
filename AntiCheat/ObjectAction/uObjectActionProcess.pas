{***********************************************************}
{                                                           }
{             Desenvolvido por Daniel Mirrai                }
{                                                           }
{              Programador Delphi Sênior                    }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Fones: +55 (51) 9413-3725 / 3111-2388            }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{***********************************************************}

unit uObjectActionProcess;

interface
uses uObjectAction, Classes, SysUtils, XMLDoc,
  XMLIntf,Messages, Variants, Graphics, Controls, Forms, uDMValidateProcess,
  Dialogs, TLHelp32,uObjectDaoProcess, uDMHTTP, uInterfaceXMLProcess, uDMUtils, uConstantSystem,
  Windows,  MidasLib, uDMUtilsMessage, ExtCtrls, uDMFileInfoUtils;

type
  TObjectActionProcess = class(TObjectAction)
    procedure TimerOnTimer(Sender: TObject);
  private
    FTimeCaptura: TTimer;
    FDMFileInfoUtils: TDMFileInfoUtils;
    FDMValidateProcess: TDMValidateProcess;
  protected
  public 
    FDMHTTP: TDMHTTP;
    function SendProcess: Boolean;
    procedure GetListProcessWindows(aClearProcess: Boolean = False);
    function TerminateAllProcess: Boolean;
    function TerminateProcess2(aFileName: string): Integer;
    function EnumProcess(hHwnd: HWND; aLista: TStringList): Boolean; stdcall;
    function GetObjectDao: TObjectDaoProcess; Reintroduce;
    procedure GetListProcessXML(aListXML: IXMLPROCESSOSType; aFinalize: Boolean=False); overload;
    procedure GetListProcessXML(aFinalize: Boolean=False; aXML: String = ''); overload;
    procedure GetListProcessXML(aFileName: String; aFinalize: Boolean=False); overload;
    function SetListProcessXML(aFileName: string = ''): String;
    procedure Disable;
    procedure Active;

    function GameExecuting: Boolean;
    function IsRunningProcess(exeFileName: string): Boolean;
    function ExistProcess(aProcess: string): Boolean; Overload;
    function ExistProcess(const aDMFileInfoUtils: TDMFileInfoUtils): Boolean; Overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;
implementation

uses uConstantProcess, uInterfaceXMLErro, uInterfaceXMLSucesso, MD5;


{ TObjectActionProcess }

procedure TObjectActionProcess.Active;
begin
  FTimeCaptura.Enabled := True;
end;

procedure TObjectActionProcess.AfterConstruction;
begin
  inherited;
  FDMFileInfoUtils    := TDMFileInfoUtils.Create;
  FDMValidateProcess  := TDMValidateProcess.Create;

  FDMHTTP := TDMHTTP.Create(nil);

  FTimeCaptura          := TTimer.Create(nil);
  FTimeCaptura.OnTimer  := TimerOnTimer;
  FTimeCaptura.Interval := cTimeCaptureProcess;
  Disable;

  GameExecuting;
end;

function TObjectActionProcess.GameExecuting: Boolean;
var
  vDMFileInfoUtils: TDMFileInfoUtils;
begin
  vDMFileInfoUtils := TDMFileInfoUtils.Create;
  try
    vDMFileInfoUtils.CompanyName      := 'Nexon';
    vDMFileInfoUtils.FileDescription  := 'Combat Arms';
    vDMFileInfoUtils.OriginalFilename := 'Engine.EXE';
    vDMFileInfoUtils.ProductName      := 'Combat Arms';
    vDMFileInfoUtils.ProductVersion   := '';
    vDMFileInfoUtils.Comments         := '';
    vDMFileInfoUtils.Attribute        := '';
    vDMFileInfoUtils.FileName         := 'Engine.exe';
    vDMFileInfoUtils.NameValidate     := 'Engine.exe';
    vDMFileInfoUtils.MD5              := '01399FD0C20947C7AA7E51F354939413';
    Result := ExistProcess(vDMFileInfoUtils);
  finally
    TDMUtils.DestroyObject(vDMFileInfoUtils);
  end;

  if Result then
  begin
    TDMUtils.MyException('O Anticheat deve ser ativado antes do jogo ser inicializado!'+#13+
                                  'Feche o jogo e tente novamente', True);
    Application.Terminate;
    exit;
  end;

  vDMFileInfoUtils := TDMFileInfoUtils.Create;
  try
    vDMFileInfoUtils.Clear;
    vDMFileInfoUtils.CompanyName      := 'Razer Synapse';
    vDMFileInfoUtils.FileDescription  := 'Razer Synapse';
    vDMFileInfoUtils.InternalName     := 'Razer Synapse';
    vDMFileInfoUtils.OriginalFilename := 'RzSynapse.exe';
    vDMFileInfoUtils.ProductName      := 'Razer Synapse';
    vDMFileInfoUtils.NameValidate     := 'RzSynapse.exe';
    Result := ExistProcess(vDMFileInfoUtils);

  finally
    TDMUtils.DestroyObject(vDMFileInfoUtils);
  end;

  if Result then
  begin
    TDMUtils.MyException('O Razer Synapse deve ser fechado.', True);
    Application.Terminate;
    exit;
  end;
  if not (TDMUtils.FileExists2('Zip.dll') or
    (MD5File2('Zip.dll')= '5577132E3B6ADFF7D3AE4B8243848DD41')) then
  begin
    TDMUtils.MyException('Dll Zip não existe', True);
    Application.Terminate;
    exit;
  end;
  LoadLibrary('AntiDLL.dll');
end;

procedure TObjectActionProcess.GetListProcessWindows(aClearProcess: Boolean = False);
var
  vNameProcess, vDiretorio: String;
  vModuleSnap: THandle;
  vModuleEntry32 : TModuleEntry32;
  vSize, vProcessId : Integer;
  bFoundProcessValidate, ContinueLoop: Boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;

  procedure DefineModule;
  begin
    try
      vProcessId := TDMUtils.CardinalToInt(FProcessEntry32.th32ProcessID);
      vModuleSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, vProcessId);
      if (vModuleSnap = Cardinal(-1)) then
        exit;
      vModuleEntry32.dwSize := SizeOf(TModuleEntry32);

      if (Module32First(vModuleSnap, vModuleEntry32)) then
      repeat
        vDiretorio := String(vModuleEntry32.szExePath);
        vSize := vModuleEntry32.modBaseSize;
        if (UpperCase(ExtractFileName(vDiretorio)) =
           UpperCase(ExtractFileName(vNameProcess))) then
        begin
          exit;
        end;
      until (not Module32Next(vModuleSnap, vModuleEntry32));
    finally
      CloseHandle(vModuleSnap);
    end;
  end;
begin
  try
    try
      GetObjectDao.CDSDados.DisableControls;
      if aClearProcess then
        GetObjectDao.CDSDados.EmptyDataSet;

      FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
      FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
      ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
      while Integer(ContinueLoop) <> 0 do
      begin
        vNameProcess := FProcessEntry32.szExeFile;
        vDiretorio := '';
        DefineModule;
        if GetObjectDao.CDSDados.Locate(GetObjectDao.CDSDadosNOME_PROCESSO.FieldName, vNameProcess, []) then
          GetObjectDao.CDSDados.Edit
        else
          GetObjectDao.CDSDados.Insert;
        GetObjectDao.CDSDadosFINALIZAR.AsBoolean            := False;

        FDMFileInfoUtils.SetFileInfo(vDiretorio);
        FDMFileInfoUtils.NameValidate := vNameProcess;
        GetObjectDao.CDSDadosMD5.AsString                   := FDMFileInfoUtils.MD5;
        GetObjectDao.CDSDadosDESCRICAO.AsString             := FDMFileInfoUtils.FileDescription;
        GetObjectDao.CDSDadosMEMORIA_RAM_UTILIZADA.AsInteger:= 0;
        GetObjectDao.CDSDadosNOME_USUARIO_AMBIENTE.AsString := '';
        GetObjectDao.CDSDadosCPU_UTILIZADO.AsInteger        := 0;
        GetObjectDao.CDSDadosEMPRESA.AsString               := FDMFileInfoUtils.CompanyName;
        GetObjectDao.CDSDadosVERSAO_ARQUIVO.AsString        := FDMFileInfoUtils.FileVersion;
        GetObjectDao.CDSDadosNOME_INTERNO.AsString          := FDMFileInfoUtils.InternalName;
        GetObjectDao.CDSDadosCOPYRIGHT.AsString             := FDMFileInfoUtils.LegalCopyright;
        GetObjectDao.CDSDadosNOME_ORIGINAL.AsString         := FDMFileInfoUtils.OriginalFilename;
        GetObjectDao.CDSDadosPRODUTO.AsString               := FDMFileInfoUtils.ProductName;
        GetObjectDao.CDSDadosVERSAO_PRODUTO.AsString        := FDMFileInfoUtils.ProductVersion;
        GetObjectDao.CDSDadosCOMENTARIOS.AsString           := FDMFileInfoUtils.Comments;
        GetObjectDao.CDSDadosATRIBUTOS.AsString             := FDMFileInfoUtils.Attribute;
        GetObjectDao.CDSDadosTIPO.AsString                  := FDMFileInfoUtils.TypeFile;
        GetObjectDao.CDSDadosOS.AsString                    := FDMFileInfoUtils.OS;
        GetObjectDao.CDSDadosID_SECAO.AsInteger             := TConstantSystem.getSectionActive;
        GetObjectDao.CDSDadosDIRETORIO.AsString             := FDMFileInfoUtils.FileName;
        GetObjectDao.CDSDadosNOME_PROCESSO.AsString         := FDMValidateProcess.GetNameProcess(FDMFileInfoUtils, bFoundProcessValidate);
        GetObjectDao.CDSDados.Post;
        ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
      end;
      CloseHandle(FSnapshotHandle);
    except
        TDMUtils.MyException('Erro ao gravar processos!', True);
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

procedure TObjectActionProcess.GetListProcessXML(aFinalize: Boolean=False; aXML: String = '');
var
  vDocXML: IXMLDocument;
  vListXML: IXMLPROCESSOSType;
begin
  try
    vDocXML.LoadFromXML(aXML);
    vListXML := GetPROCESSOS(vDocXML);
    GetListProcessXML(vListXML, aFinalize);
  finally
    vListXML  := nil;
    vDocXML   := nil;
  end;
end;

procedure TObjectActionProcess.GetListProcessXML(aListXML: IXMLPROCESSOSType; aFinalize: Boolean=False);
var
  vXML: IXMLPROCESSOType;
  vIndex: Integer;
begin
  try
    GetObjectDao.CDSDados.DisableControls;
    GetObjectDao.CDSDados.EmptyDataSet;
    for vIndex := 0 to aListXML.Count -1 do
    begin
      vXML := aListXML.PROCESSO[vIndex];
      GetObjectDao.CDSDados.Insert;
      GetObjectDao.CDSDadosMEMORIA_RAM_UTILIZADA.AsInteger  := vXML.Get_MEMORIA_RAM_UTILIZADA;
      GetObjectDao.CDSDadosFINALIZAR.AsBoolean              := aFinalize;
      GetObjectDao.CDSDadosDESCRICAO.AsString               := vXML.Get_DESCRICAO;
      GetObjectDao.CDSDadosNOME_PROCESSO.AsString           := vXML.Get_NOME;
      GetObjectDao.CDSDadosCPU_UTILIZADO.AsInteger          := vXML.Get_CPU_UTILIZADO;
      GetObjectDao.CDSDadosNOME_USUARIO_AMBIENTE.AsString   := vXML.Get_NOME_USUARIO_SISTEMA;
      GetObjectDao.CDSDadosEMPRESA.AsString                 := vXML.Get_EMPRESA;
      GetObjectDao.CDSDadosVERSAO_ARQUIVO.AsString          := vXML.Get_VERSAO_ARQUIVO;
      GetObjectDao.CDSDadosNOME_INTERNO.AsString            := vXML.Get_NOME_INTERNO;
      GetObjectDao.CDSDadosCOPYRIGHT.AsString               := vXML.Get_COPYRIGHT;
      GetObjectDao.CDSDadosNOME_ORIGINAL.AsString           := vXML.Get_NOME_ORIGINAL;
      GetObjectDao.CDSDadosPRODUTO.AsString                 := vXML.Get_PRODUTO;
      GetObjectDao.CDSDadosVERSAO_PRODUTO.AsString          := vXML.Get_VERSAO_PRODUTO;
      GetObjectDao.CDSDadosCOMENTARIOS.AsString             := vXML.Get_COMENTARIOS;
      GetObjectDao.CDSDadosATRIBUTOS.AsString               := vXML.Get_ATRIBUTOS;
      GetObjectDao.CDSDadosTIPO.AsString                    := vXML.Get_TIPO;
      GetObjectDao.CDSDadosOS.AsString                      := vXML.Get_OS;
      GetObjectDao.CDSDadosDIRETORIO.AsString               := vXML.Get_Diretorio;
      GetObjectDao.CDSDadosMD5.AsString                     := vXML.Get_MD5;
      GetObjectDao.CDSDados.Post;
      vXML := nil;
    end;
    GetObjectDao.CDSDados.First;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

procedure TObjectActionProcess.BeforeDestruction;
begin
  SendProcess;
  TDMUtils.DestroyObject(FDMValidateProcess);
  TDMUtils.DestroyObject(FTimeCaptura);
  TDMUtils.DestroyObject(FDMHTTP);
  TDMUtils.DestroyObject(FDMFileInfoUtils);
  inherited;
end;

procedure TObjectActionProcess.Disable;
begin
  FTimeCaptura.Enabled := False;
end;

function TObjectActionProcess.EnumProcess(hHwnd: HWND;
  aLista: TStringList): Boolean;
var
  pPid : DWORD;
  title, ClassName : string;
begin
  //if the returned value in null the
  //callback has failed, so set to false and exit.
  if (hHwnd=NULL) then
  begin
    Result := False;
  end
  else
  begin
    //additional functions to get more
    //information about a process.
    //get the Process Identification number.
    GetWindowThreadProcessId(hHwnd,pPid);
    //set a memory area to receive
    //the process class name
    SetLength(ClassName, 255);
    //get the class name and reset the
    //memory area to the size of the name
    SetLength(ClassName,
              GetClassName(hHwnd,
                           PChar(className),
                           Length(className)));
    SetLength(title, 255);
    //get the process title; usually displayed
    //on the top bar in visible process
    SetLength(title, GetWindowText(hHwnd, PChar(title), Length(title)));
    //Display the process information
    //by adding it to a list box
    aLista.Add
      ('Class Name = ' + className +
       '; Title = ' + title +
       '; HWND = '+ IntToStr(hHwnd) +
       '; Pid = ' + IntToStr(pPid));
    Result := True;
  end;
end;

function TObjectActionProcess.ExistProcess(const aDMFileInfoUtils: TDMFileInfoUtils): Boolean;
var
  vCompareDMFileInfoUtils: TDMFileInfoUtils;
begin
  Result := False;
  GetListProcessWindows;
  vCompareDMFileInfoUtils := TDMFileInfoUtils.Create;
  try
    GetObjectDao.CDSDados.DisableControls;
    while not GetObjectDao.CDSDados.Eof do
    begin
      vCompareDMFileInfoUtils.Clear;
      vCompareDMFileInfoUtils.SetFileInfo(GetObjectDao.CDSDadosDIRETORIO.AsString);
      if TDMValidateProcess.ProcessEquals(aDMFileInfoUtils, vCompareDMFileInfoUtils) then
      begin
        Result := True;
        exit;
      end;
      GetObjectDao.CDSDados.Next;
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
    TDMUtils.DestroyObject(vCompareDMFileInfoUtils);

    if not Result then
      Result := IsRunningProcess(aDMFileInfoUtils.FileName);
  end;
end;

function TObjectActionProcess.ExistProcess(aProcess: string): Boolean;
begin
  Result := False;
  GetListProcessWindows;
  aProcess := UpperCase(Trim(aProcess));
  try
    GetObjectDao.CDSDados.DisableControls;
    while not GetObjectDao.CDSDados.Eof do
    begin
      if (aProcess = UpperCase(Trim(GetObjectDao.CDSDadosNOME_PROCESSO.AsString))) then
        Result := True;
      GetObjectDao.CDSDados.Next;
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

function TObjectActionProcess.GetObjectDao: TObjectDaoProcess;
begin
  Result := TObjectDaoProcess(inherited GetObjectDao);
end;


function TObjectActionProcess.SendProcess: Boolean;
var
  vReturn: String;
  vXMLSucesso: IXMLSucessoType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
  vEnvio:String;
begin
  try
    try
      Result := False;
      if (FTimeCaptura.Enabled and (TConstantSystem.GetSectionActive > 0)) then
      begin
        Disable;
        if (GetObjectDao.ExistData) then
        begin
          FDMHTTP.Clear;
          FDMHTTP.URL := TConstantSystem.GetSiteAPIProcess;
          FDMHTTP.AddFieldParams('SESS_ID', TConstantSystem.GetSectionActive);
          vEnvio := SetListProcessXML(ExtractFilePath(Application.ExeName)+'log2.txt');//
//          TDMUtils.MyException('Envio processos: '+vEnvio);
          FDMHTTP.AddFieldParams('ARQUIVO', vEnvio);

          vReturn := FDMHTTP.SendPOST;
          //FDMHTTP.AddHash;
{          vStr := TStringList.Create;
          vStr.Text := vEnvio;
          vStr.SaveToFile('C:\envio.xml');
          vStr.Text := vReturn;
          vStr.SaveToFile('C:\retorno.xml');}

          if (not TDMUtils.IsEmpty(vReturn)) then
          begin
            vXML    := TDMUtils.GetXML(vReturn);

            if TDMUtils.LocateStr('<sucesso>', vReturn) then
            begin
              vXMLSucesso := Getsucesso(vXML);
              if (UpperCase(vXMLSucesso.CalculaHash) <> UpperCase(vXMLSucesso.Hash)) then
              begin
                Result := False;
                TDMUtils.MyException('Erro ao enviar lista de processos: Hash invalido!'+#13+
                'Enviado: '+ UpperCase(vXMLSucesso.CalculaHash)+#13+
                'Recebido: '+ UpperCase(vXMLSucesso.Hash), true);
              end
              else
              begin
                Result := True;
                TDMUtils.MyException('Lista de processos enviados com sucesso!');
              end;
            end
            else
            begin
              vXMLErro := GetErro(vXML);
              if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
              begin
                Result := False;
                TDMUtils.MyException('Erro ao enviar lista de processos: Hash invalido!'+#13+
                  'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
                  'Recebido: '+ UpperCase(vXMLErro.Hash), True);
              end
              else
              begin
                TDMUtils.MyException('Erro ao enviar lista de processos: '+TDMUtils.IntToStr2(vXMLErro.Codigo) + vXMLErro.Mensagem, True);
              end;
            end;
          end
          else
            TDMUtils.MyException('Erro ao enviar lista de processos!', true);
        end
        else
          Result := True;
      end;
    except
        Result := False;
        TDMUtils.MyException('Erro ao listar processos!'+#13+#10+
              'Retorno: '+vReturn, true);
        exit;
    end;
  finally
    Disable;
  end;
end;

function TObjectActionProcess.SetListProcessXML(aFileName: string = ''): String;
var
  vListXML: IXMLPROCESSOSType;
  vXML: IXMLPROCESSOType;
begin
  Result := '';;
  try
    try
      GetObjectDao.CDSDados.DisableControls;
      vListXML := NewPROCESSOS;

      GetObjectDao.CDSDados.First;

      while not GetObjectDao.CDSDados.Eof do
      begin
        vXML := vListXML.Add;

        vXML.Set_NOME(GetObjectDao.CDSDadosNOME_PROCESSO.AsString);
        vXML.Set_DESCRICAO(GetObjectDao.CDSDadosDESCRICAO.AsString);
        vXML.Set_NOME_USUARIO_SISTEMA(GetObjectDao.CDSDadosNOME_USUARIO_AMBIENTE.AsString);
        vXML.Set_MEMORIA_RAM_UTILIZADA(GetObjectDao.CDSDadosMEMORIA_RAM_UTILIZADA.AsInteger);
        vXML.Set_CPU_UTILIZADO(GetObjectDao.CDSDadosCPU_UTILIZADO.AsInteger);
        vXML.Set_EMPRESA(GetObjectDao.CDSDadosEMPRESA.AsString);
        vXML.Set_VERSAO_ARQUIVO(GetObjectDao.CDSDadosVERSAO_ARQUIVO.AsString);
        vXML.Set_NOME_INTERNO(GetObjectDao.CDSDadosNOME_INTERNO.AsString);
        vXML.Set_COPYRIGHT(GetObjectDao.CDSDadosCOPYRIGHT.AsString);
        vXML.Set_NOME_ORIGINAL(GetObjectDao.CDSDadosNOME_ORIGINAL.AsString);
        vXML.Set_PRODUTO(GetObjectDao.CDSDadosPRODUTO.AsString);
        vXML.Set_VERSAO_PRODUTO(GetObjectDao.CDSDadosVERSAO_PRODUTO.AsString);
        vXML.Set_COMENTARIOS(GetObjectDao.CDSDadosCOMENTARIOS.AsString);
        vXML.Set_ATRIBUTOS(GetObjectDao.CDSDadosATRIBUTOS.AsString);
        vXML.Set_TIPO(GetObjectDao.CDSDadosTIPO.AsString);
        vXML.Set_OS(GetObjectDao.CDSDadosOS.AsString);
        vXML.Set_Diretorio(GetObjectDao.CDSDadosDIRETORIO.AsString);
        vXML.Set_MD5(GetObjectDao.CDSDadosMD5.AsString);
        GetObjectDao.CDSDados.Next;
      end;

      vListXML.Set_HASH(vListXML.CalculaHash);

      Result := TDMUtils.FormatXMLData2(vListXML.XML);

      if not TDMUtils.IsEmpty(aFileName) then
      begin
        TDMUtils.DeleteFile2(aFileName);
        vListXML.SaveToFile(aFileName);
      end;
    except
      Result := '';
      TDMUtils.MyException('Erro ao gerar lista de processos!', True);
      exit;
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

function TObjectActionProcess.TerminateAllProcess: Boolean;
begin
  Result := True;
  try
    GetObjectDao.CDSDados.DisableControls;
    GetObjectDao.CDSDados.First;
    while not GetObjectDao.CDSDados.Eof do
    begin
      if not TDMUtils.IsEmpty(GetObjectDao.CDSDadosNOME_PROCESSO.AsString) then
      begin
        if (TerminateProcess2(GetObjectDao.CDSDadosNOME_PROCESSO.AsString) = 0) then
          Result := False;
      end;
      GetObjectDao.CDSDados.Next;
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

function TObjectActionProcess.TerminateProcess2(aFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(aFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(aFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


procedure TObjectActionProcess.TimerOnTimer(Sender: TObject);
begin
  GetListProcessWindows(False);
end;

procedure TObjectActionProcess.GetListProcessXML(aFileName: String; aFinalize: Boolean=False);
var
  vListXML: IXMLPROCESSOSType;
begin
  try
    vListXML := LoadPROCESSOS(aFileName);
    GetListProcessXML(vListXML, aFinalize);
  finally
    vListXML := nil;
  end;
end;

function TObjectActionProcess.IsRunningProcess(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

initialization
  Classes.RegisterClass(TObjectActionProcess);

end.

