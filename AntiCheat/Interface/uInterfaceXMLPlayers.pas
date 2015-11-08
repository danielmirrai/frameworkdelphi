
{********************************************************************************}
{                                                                                }
{                                XML Data Binding                                }
{                                                                                }
{         Generated on: 03/02/2013 15:39:03                                      }
{       Generated from: F:\Programação\Delphi\AntiCheat\XML\ListaJogadores.xml   }
{   Settings stored in: F:\Programação\Delphi\AntiCheat\XML\ListaJogadores.xdb   }
{                                                                                }
{********************************************************************************}

unit uInterfaceXMLPlayers;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLJogadores_onlineType = interface;
  IXMLJogador_infoType = interface;
  IXMLJogador_infoTypeList = interface;

{ IXMLJogadores_onlineType }

  IXMLJogadores_onlineType = interface(IXMLNode)
    ['{F8DBB9AC-64D5-4AC0-ABC6-9E58B28BD6B1}']
    { Property Accessors }
    function Get_Jogador_info: IXMLJogador_infoTypeList;
    function Get_Hash: WideString;
    procedure Set_Hash(Value: WideString);
    { Methods & Properties }
    property Jogador_info: IXMLJogador_infoTypeList read Get_Jogador_info;
    property Hash: WideString read Get_Hash write Set_Hash;
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ IXMLJogador_infoType }

  IXMLJogador_infoType = interface(IXMLNode)
    ['{FAB53E74-83C9-44C3-9A3C-C478697A388C}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Login: WideString;
    function Get_Cla: WideString;
    function Get_Data_inicio: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Login(Value: WideString);
    procedure Set_Cla(Value: WideString);
    procedure Set_Data_inicio(Value: WideString);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Login: WideString read Get_Login write Set_Login;
    property Cla: WideString read Get_Cla write Set_Cla;
    property Data_inicio: WideString read Get_Data_inicio write Set_Data_inicio;
  end;

{ IXMLJogador_infoTypeList }

  IXMLJogador_infoTypeList = interface(IXMLNodeCollection)
    ['{E95FFC3B-F079-4562-B716-384B7D8A0187}']
    { Methods & Properties }
    function Add: IXMLJogador_infoType;
    function Insert(const Index: Integer): IXMLJogador_infoType;

    function Get_Item(Index: Integer): IXMLJogador_infoType;
    property Items[Index: Integer]: IXMLJogador_infoType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLJogadores_onlineType = class;
  TXMLJogador_infoType = class;
  TXMLJogador_infoTypeList = class;

{ TXMLJogadores_onlineType }

  TXMLJogadores_onlineType = class(TXMLNode, IXMLJogadores_onlineType)
  private
    FJogador_info: IXMLJogador_infoTypeList;
  protected
    { IXMLJogadores_onlineType }
    function Get_Jogador_info: IXMLJogador_infoTypeList;
    function Get_Hash: WideString;
    procedure Set_Hash(Value: WideString);
  public
    procedure AfterConstruction; override;
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ TXMLJogador_infoType }

  TXMLJogador_infoType = class(TXMLNode, IXMLJogador_infoType)
  protected
    { IXMLJogador_infoType }
    function Get_Id: Integer;
    function Get_Login: WideString;
    function Get_Cla: WideString;
    function Get_Data_inicio: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Login(Value: WideString);
    procedure Set_Cla(Value: WideString);
    procedure Set_Data_inicio(Value: WideString);
  end;

{ TXMLJogador_infoTypeList }

  TXMLJogador_infoTypeList = class(TXMLNodeCollection, IXMLJogador_infoTypeList)
  protected
    { IXMLJogador_infoTypeList }
    function Add: IXMLJogador_infoType;
    function Insert(const Index: Integer): IXMLJogador_infoType;

    function Get_Item(Index: Integer): IXMLJogador_infoType;
  end;

{ Global Functions }

function Getjogadores_online(Doc: IXMLDocument): IXMLJogadores_onlineType;
function Loadjogadores_online(const FileName: string): IXMLJogadores_onlineType;
function Newjogadores_online: IXMLJogadores_onlineType;

const
  TargetNamespace = '';

implementation

uses uDMUtils, uDMHash;

{ Global Functions }

function Getjogadores_online(Doc: IXMLDocument): IXMLJogadores_onlineType;
begin
  Result := Doc.GetDocBinding('jogadores_online', TXMLJogadores_onlineType, TargetNamespace) as IXMLJogadores_onlineType;
end;

function Loadjogadores_online(const FileName: string): IXMLJogadores_onlineType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('jogadores_online', TXMLJogadores_onlineType, TargetNamespace) as IXMLJogadores_onlineType;
end;

function Newjogadores_online: IXMLJogadores_onlineType;
begin
  Result := NewXMLDocument.GetDocBinding('jogadores_online', TXMLJogadores_onlineType, TargetNamespace) as IXMLJogadores_onlineType;
end;

{ TXMLJogadores_onlineType }

procedure TXMLJogadores_onlineType.AfterConstruction;
begin
  RegisterChildNode('jogador_info', TXMLJogador_infoType);
  FJogador_info := CreateCollection(TXMLJogador_infoTypeList, IXMLJogador_infoType, 'jogador_info') as IXMLJogador_infoTypeList;
  inherited;
end;

function TXMLJogadores_onlineType.Get_Jogador_info: IXMLJogador_infoTypeList;
begin
  Result := FJogador_info;
end;

function TXMLJogadores_onlineType.CalculaHash: string;
var
  vDMHash: TDMHash;
  vIndex: Integer;
  vXMLJOGADOR_INFO: IXMLJOGADOR_INFOType;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    for vIndex := 0 to  Get_JOGADOR_INFO.Count -1 do
    begin
      vXMLJOGADOR_INFO := Get_JOGADOR_INFO.Items[vIndex];
      vDMHash.Add(vXMLJOGADOR_INFO.Get_Login);
      vDMHash.Add(vXMLJOGADOR_INFO.Get_Cla);
      vDMHash.Add(vXMLJOGADOR_INFO.Get_Data_Inicio);
    end;
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLJogadores_onlineType.Get_Hash: WideString;
begin
  Result := ChildNodes['hash'].Text;
end;

procedure TXMLJogadores_onlineType.SaveToFile(aFileName: string);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLJogadores_onlineType.Set_Hash(Value: WideString);
begin
  ChildNodes['hash'].NodeValue := Value;
end;

{ TXMLJogador_infoType }

function TXMLJogador_infoType.Get_Id: Integer;
begin
  Result := ChildNodes['id'].NodeValue;
end;

procedure TXMLJogador_infoType.Set_Id(Value: Integer);
begin
  ChildNodes['id'].NodeValue := Value;
end;

function TXMLJogador_infoType.Get_Login: WideString;
begin
  Result := ChildNodes['login'].Text;
end;

procedure TXMLJogador_infoType.Set_Login(Value: WideString);
begin
  ChildNodes['login'].NodeValue := Value;
end;

function TXMLJogador_infoType.Get_Cla: WideString;
begin
  Result := ChildNodes['cla'].Text;
end;

procedure TXMLJogador_infoType.Set_Cla(Value: WideString);
begin
  ChildNodes['cla'].NodeValue := Value;
end;

function TXMLJogador_infoType.Get_Data_inicio: WideString;
begin
  Result := ChildNodes['data_inicio'].Text;
end;

procedure TXMLJogador_infoType.Set_Data_inicio(Value: WideString);
begin
  ChildNodes['data_inicio'].NodeValue := Value;
end;

{ TXMLJogador_infoTypeList }

function TXMLJogador_infoTypeList.Add: IXMLJogador_infoType;
begin
  Result := AddItem(-1) as IXMLJogador_infoType;
end;

function TXMLJogador_infoTypeList.Insert(const Index: Integer): IXMLJogador_infoType;
begin
  Result := AddItem(Index) as IXMLJogador_infoType;
end;

function TXMLJogador_infoTypeList.Get_Item(Index: Integer): IXMLJogador_infoType;
begin
  Result := List[Index] as IXMLJogador_infoType;
end;

end.