unit uDMValidateProcess;

interface
  uses
    uDMFileInfoUtils, SysUtils, classes;

  type
    TDMValidateProcess = class
      private
        FDMListFileInfoUtils: TDMListFileInfoUtils;
      protected
      public

    procedure Define;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function GetNameProcess(aFileInfoUtils: TDMFileInfoUtils): string;
    class function ProcessEquals(const poFileInfoUtils, poCompareFileInfoUtils: TDMFileInfoUtils): Boolean;

    end;
implementation

uses uDMUtils;

{ TDMValidateProcess }

procedure TDMValidateProcess.AfterConstruction;
begin
  inherited;
  FDMListFileInfoUtils := TDMListFileInfoUtils.Create;
  Define;
end;

procedure TDMValidateProcess.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FDMListFileInfoUtils);
  inherited;
end;

procedure TDMValidateProcess.Define;
var
  vDMFileInfoUtils: TDMFileInfoUtils;
begin
  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.MD5              := 'F9F2F807752D14C70D32E8999DDBB927';
  vDMFileInfoUtils.FileDescription  := 'RageKings CMS';
  vDMFileInfoUtils.ProductName      := 'RageKings CMS';
  vDMFileInfoUtils.LegalCopyright   := 'RageKings';
  vDMFileInfoUtils.OriginalFilename := 'RageKings CMS';
  vDMFileInfoUtils.NameValidate     := 'RageKings CMS.exe';


  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.MD5              := '58F973BC33C619806129A0A6C3D43B3E';
  vDMFileInfoUtils.FileDescription  := 'AugS Dist';
  vDMFileInfoUtils.ProductName      := 'AugS Dist';
  vDMFileInfoUtils.LegalCopyright   := 'AugS Dist';
  vDMFileInfoUtils.FileName         := 'AugS Distro Center!AugmentedSkills!AugS Dist';
  vDMFileInfoUtils.OriginalFilename := 'Augs_Dist';
  vDMFileInfoUtils.NameValidate     := 'Augs_Dist.exe';


  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.MD5              := 'A08224D0EE84AC9CC533A496366EE1C6';
  vDMFileInfoUtils.NameValidate     := 'Code64.exe';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := 'CLB Copyright 2010';
  vDMFileInfoUtils.FileDescription  := 'CLB Injector';
  vDMFileInfoUtils.FileVersion      := '1.0.0.38';
  vDMFileInfoUtils.InternalName     := 'CLB Injector';
  vDMFileInfoUtils.LegalCopyright   := 'By ™ЊϊмөмŦђεр™';
  vDMFileInfoUtils.OriginalFilename := 'CLB Injector';
  vDMFileInfoUtils.ProductName      := 'CLB Copyright 2010';
  vDMFileInfoUtils.ProductVersion   := '1.0.0.0';
  vDMFileInfoUtils.Comments         := '';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := 'Aplicacao';
  vDMFileInfoUtils.OS               := 'Win32 API';
  vDMFileInfoUtils.FileName         := 'CBL Injector!CBL Injector V1.2.exe';
  vDMFileInfoUtils.NameValidate     := 'CBL Injector V1.2.exe';
  vDMFileInfoUtils.MD5              := '2D78A2A808E85F3843D54367E907328E';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := '';
  vDMFileInfoUtils.FileDescription  := '';
  vDMFileInfoUtils.FileVersion      := '';
  vDMFileInfoUtils.InternalName     := '';
  vDMFileInfoUtils.LegalCopyright   := '';
  vDMFileInfoUtils.OriginalFilename := '';
  vDMFileInfoUtils.ProductName      := '';
  vDMFileInfoUtils.ProductVersion   := '';
  vDMFileInfoUtils.Comments         := '';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := '';
  vDMFileInfoUtils.OS               := '';
  vDMFileInfoUtils.FileName         := 'H3R0 Injector!H3R0 Injector.exe';
  vDMFileInfoUtils.NameValidate     := 'H3R0 Injector.exe';
  vDMFileInfoUtils.MD5              := '4274AA3FB911F5621F34595E58E50A7B';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := 'http://warzone-sys.net';
  vDMFileInfoUtils.FileDescription  := '~Lear Injector';
  vDMFileInfoUtils.FileVersion      := '1.3.4.7';
  vDMFileInfoUtils.InternalName     := '~Lear Injector';
  vDMFileInfoUtils.LegalCopyright   := 'Warzone - Sys';
  vDMFileInfoUtils.OriginalFilename := '~Lear Injector';
  vDMFileInfoUtils.ProductName      := 'Injector';
  vDMFileInfoUtils.ProductVersion   := '1.3.4.7';
  vDMFileInfoUtils.Comments         := 'Criado e desenvolvido por ~Lear';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := 'Aplicacao';
  vDMFileInfoUtils.OS               := 'Win32 API';
  vDMFileInfoUtils.FileName         := 'Pack Lear Injector!~Lear Injector.exe';
  vDMFileInfoUtils.NameValidate     := '~Lear Injector.exe';
  vDMFileInfoUtils.MD5              := 'B0CA58BC310CFBF1FD6923EF74A19BBF';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := 'http://warzone-sys.net';
  vDMFileInfoUtils.FileDescription  := '~Lear Injector';
  vDMFileInfoUtils.FileVersion      := '1.3.4.7';
  vDMFileInfoUtils.InternalName     := '~Lear Injector';
  vDMFileInfoUtils.LegalCopyright   := 'Warzone - Sys';
  vDMFileInfoUtils.OriginalFilename := '~Lear Injector';
  vDMFileInfoUtils.ProductName      := 'Injector';
  vDMFileInfoUtils.ProductVersion   := '1.3.4.7';
  vDMFileInfoUtils.Comments         := 'Criado e desenvolvido por ~Lear';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := 'Aplicacao';
  vDMFileInfoUtils.OS               := 'Win32 API';
  vDMFileInfoUtils.FileName         := 'Pack Lear Injector!~Lear Injector - Pulsar.exe';
  vDMFileInfoUtils.NameValidate     := '~Lear Injector - Pulsar.exe';
  vDMFileInfoUtils.MD5              := '869B73DF335F4FB46A025CADB7B52E71';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := 'x1nixmzeng';
  vDMFileInfoUtils.FileDescription  := 'x1nject';
  vDMFileInfoUtils.FileVersion      := '1.0.0.0';
  vDMFileInfoUtils.InternalName     := '';
  vDMFileInfoUtils.LegalCopyright   := 'x1nixmzeng';
  vDMFileInfoUtils.OriginalFilename := '';
  vDMFileInfoUtils.ProductName      := '';
  vDMFileInfoUtils.ProductVersion   := '1.0.0.0';
  vDMFileInfoUtils.Comments         := 'Public Release';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := 'Aplicacao';
  vDMFileInfoUtils.OS               := 'Win32 API';
  vDMFileInfoUtils.FileName         := 'PerX Injector - x1Inject!PerX.exe';
  vDMFileInfoUtils.NameValidate     := 'PerX.exe';
  vDMFileInfoUtils.MD5              := 'E974A7ED7FA0C096AA1F59AE6D8CCE72';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := '';
  vDMFileInfoUtils.FileDescription  := '';
  vDMFileInfoUtils.FileVersion      := '';
  vDMFileInfoUtils.InternalName     := '';
  vDMFileInfoUtils.LegalCopyright   := '';
  vDMFileInfoUtils.OriginalFilename := '';
  vDMFileInfoUtils.ProductName      := '';
  vDMFileInfoUtils.ProductVersion   := '';
  vDMFileInfoUtils.Comments         := '';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := '';
  vDMFileInfoUtils.OS               := '';
  vDMFileInfoUtils.FileName         := 'WebCheats Utilities v1.0!Web Cheats Utilities v1.0.exe';
  vDMFileInfoUtils.NameValidate     := 'Web Cheats Utilities v1.0.exe';
  vDMFileInfoUtils.MD5              := '75667634DDAB97F027745F1770B260F6';

  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;
  vDMFileInfoUtils.CompanyName      := '';
  vDMFileInfoUtils.FileDescription  := '';
  vDMFileInfoUtils.FileVersion      := '';
  vDMFileInfoUtils.InternalName     := '';
  vDMFileInfoUtils.LegalCopyright   := '';
  vDMFileInfoUtils.OriginalFilename := '';
  vDMFileInfoUtils.ProductName      := '';
  vDMFileInfoUtils.ProductVersion   := '';
  vDMFileInfoUtils.Comments         := '';
  vDMFileInfoUtils.Attribute        := '';
  vDMFileInfoUtils.TypeFile         := '';
  vDMFileInfoUtils.OS               := '';
  vDMFileInfoUtils.FileName         := 'XRL Mult Injector!XRL Mult - Injector V2.0 V.I.P.exe';
  vDMFileInfoUtils.NameValidate     := 'XRL Mult - Injector V2.0 V.I.P.exe';
  vDMFileInfoUtils.MD5              := '4672D13CB02D37E7D4C3A8F3B3084362';
end;

function TDMValidateProcess.GetNameProcess(aFileInfoUtils: TDMFileInfoUtils): string;
var
  vIndex: Integer;
  vFileInfoUtils: TDMFileInfoUtils;

  function LocateItem(aName, aValue: string): Boolean;
  var
    vList: TStringList;
    vIndex2: Integer;
  begin
    vList := nil;
    try
      vList := TDMUtils.Explode(aValue, '!');
      Result := False;
      if Assigned(vList) then
      begin
        for vIndex2 := 0 to vList.Count -1 do
        begin
          Result := (not (TDMUtils.IsEmpty(aName) or TDMUtils.IsEmpty(aValue))) and
                  (pos(UpperCase(Trim(vList.Strings[vIndex2])), UpperCase(Trim(aName))) > 0);
          if Result then
          begin
            Result := True;
            exit;
          end;
        end;
      end;
    finally
      TDMUtils.DestroyObject(vList);
    end;
  end;
begin
  if Assigned(FDMListFileInfoUtils) then
  begin
    if not TDMUtils.IsEmpty(aFileInfoUtils.FileName) then
    begin
      Result := aFileInfoUtils.NameValidate;
      for vIndex := 0 to FDMListFileInfoUtils.Count -1 do
      begin
        vFileInfoUtils := FDMListFileInfoUtils.Items[vIndex];
        if ProcessEquals(aFileInfoUtils, vFileInfoUtils) then
          Result := vFileInfoUtils.NameValidate;
      end;
    end;
  end;
end;

class function TDMValidateProcess.ProcessEquals(const poFileInfoUtils,
  poCompareFileInfoUtils: TDMFileInfoUtils): Boolean;
  function LocateItem(const aName, aValue: string): Boolean;
  var
    vList: TStringList;
    vIndex2: Integer;
  begin
    vList := nil;
    try
      vList := TDMUtils.Explode(aValue, '!');
      Result := False;
      if Assigned(vList) then
      begin
        for vIndex2 := 0 to vList.Count -1 do
        begin
          Result := (not (TDMUtils.IsEmpty(aName) or TDMUtils.IsEmpty(aValue))) and
                  (pos(UpperCase(Trim(vList.Strings[vIndex2])), UpperCase(Trim(aName))) > 0);
          if Result then
          begin
            Result := True;
            exit;
          end;
        end;
      end;
    finally
      TDMUtils.DestroyObject(vList);
    end;
  end;
begin
  Result := False;
  if Assigned(poFileInfoUtils) and Assigned(poCompareFileInfoUtils) then
  begin
    if not TDMUtils.IsEmpty(poFileInfoUtils.FileName) then
    begin
      if  LocateItem(poFileInfoUtils.MD5, poCompareFileInfoUtils.MD5) or
          LocateItem(poFileInfoUtils.CompanyName, poCompareFileInfoUtils.CompanyName) or
          LocateItem(poFileInfoUtils.FileDescription, poCompareFileInfoUtils.FileDescription) or
          LocateItem(poFileInfoUtils.InternalName, poCompareFileInfoUtils.InternalName) or
          LocateItem(poFileInfoUtils.LegalCopyright, poCompareFileInfoUtils.LegalCopyright) or
          LocateItem(poFileInfoUtils.OriginalFilename, poCompareFileInfoUtils.OriginalFilename) or
          LocateItem(poFileInfoUtils.ProductName, poCompareFileInfoUtils.ProductName) or
          LocateItem(poFileInfoUtils.FileName, poCompareFileInfoUtils.FileName) or
          LocateItem(ExtractFilePath(poFileInfoUtils.FileName), ExtractFilePath(poCompareFileInfoUtils.FileName)) or
          LocateItem(ExtractFileName(poFileInfoUtils.FileName), ExtractFileName(poCompareFileInfoUtils.FileName)) or
          LocateItem(poFileInfoUtils.NameValidate, poCompareFileInfoUtils.NameValidate) then
        Result := True;
    end;
  end;
end;

end.
