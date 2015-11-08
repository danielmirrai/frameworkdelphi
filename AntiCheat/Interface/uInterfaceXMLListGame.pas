
{*******************************************************************************}
{                                                                               }
{                               XML Data Binding                                }
{                                                                               }
{         Generated on: 25/01/2013 21:16:00                                     }
{       Generated from: F:\Programação\Delphi\AntiCheat\XML\ListaPartidas.xml   }
{   Settings stored in: F:\Programação\Delphi\AntiCheat\XML\ListaPartidas.xdb   }
{                                                                               }
{*******************************************************************************}

unit uInterfaceXMLListGame;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPartidasType = interface;
  IXMLPartidaType = interface;
  IXMLPartidaTypeList = interface;

{ IXMLPartidasType }

  IXMLPartidasType = interface(IXMLNode)
    ['{C589230D-55BD-4FB9-9928-6928B94C124D}']
    { Property Accessors }
    function Get_Partida: IXMLPartidaTypeList;
    function Get_Hash: WideString;
    procedure Set_Hash(Value: WideString);

    { Methods & Properties }
    property Partida: IXMLPartidaTypeList read Get_Partida;
    property Hash: WideString read Get_Hash write Set_Hash;
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ IXMLPartidaType }

  IXMLPartidaType = interface(IXMLNode)
    ['{08439D41-CDE9-4EA9-8E17-D2BD33DFB352}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Codigo: WideString;
    function Get_Descricao: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Codigo(Value: WideString);
    procedure Set_Descricao(Value: WideString);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Codigo: WideString read Get_Codigo write Set_Codigo;
    property Descricao: WideString read Get_Descricao write Set_Descricao;
  end;

{ IXMLPartidaTypeList }

  IXMLPartidaTypeList = interface(IXMLNodeCollection)
    ['{CDA16411-F1E4-46A3-B96B-4E1F558EBBE3}']
    { Methods & Properties }
    function Add: IXMLPartidaType;
    function Insert(const Index: Integer): IXMLPartidaType;

    function Get_Item(Index: Integer): IXMLPartidaType;
    property Items[Index: Integer]: IXMLPartidaType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLPartidasType = class;
  TXMLPartidaType = class;
  TXMLPartidaTypeList = class;

{ TXMLPartidasType }

  TXMLPartidasType = class(TXMLNode, IXMLPartidasType)
  private
    FPartida: IXMLPartidaTypeList;
  public
    { IXMLPartidasType }
    function Get_Partida: IXMLPartidaTypeList;
    function Get_Hash: WideString;
    procedure Set_Hash(Value: WideString);
    procedure AfterConstruction; override;
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ TXMLPartidaType }

  TXMLPartidaType = class(TXMLNode, IXMLPartidaType)
  protected
    { IXMLPartidaType }
    function Get_Id: Integer;
    function Get_Codigo: WideString;
    function Get_Descricao: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Codigo(Value: WideString);
    procedure Set_Descricao(Value: WideString);
  end;

{ TXMLPartidaTypeList }

  TXMLPartidaTypeList = class(TXMLNodeCollection, IXMLPartidaTypeList)
  protected
    { IXMLPartidaTypeList }
    function Add: IXMLPartidaType;
    function Insert(const Index: Integer): IXMLPartidaType;

    function Get_Item(Index: Integer): IXMLPartidaType;
  end;

{ Global Functions }

function Getpartidas(Doc: IXMLDocument): IXMLPartidasType;
function Loadpartidas(const FileName: string): IXMLPartidasType;
function Newpartidas: IXMLPartidasType;

const
  TargetNamespace = '';

implementation

uses uDMUtils, uDMHash, uConstantSystem;

{ Global Functions }

function Getpartidas(Doc: IXMLDocument): IXMLPartidasType;
begin
  Result := Doc.GetDocBinding('partidas', TXMLPartidasType, TargetNamespace) as IXMLPartidasType;
end;

function Loadpartidas(const FileName: string): IXMLPartidasType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('partidas', TXMLPartidasType, TargetNamespace) as IXMLPartidasType;
end;

function Newpartidas: IXMLPartidasType;
begin
  Result := NewXMLDocument.GetDocBinding('partidas', TXMLPartidasType, TargetNamespace) as IXMLPartidasType;
end;

{ TXMLPartidasType }

procedure TXMLPartidasType.AfterConstruction;
begin
  RegisterChildNode('partida', TXMLPartidaType);
  FPartida := CreateCollection(TXMLPartidaTypeList, IXMLPartidaType, 'partida') as IXMLPartidaTypeList;
  inherited;
end;

function TXMLPartidasType.Get_Partida: IXMLPartidaTypeList;
begin
  Result := FPartida;
end;

function TXMLPartidasType.CalculaHash: string;
var
  vDMHash: TDMHash;
  vIndex: Integer;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    for vIndex := 0 to Get_Partida.Count -1 do
    begin
      vDMHash.Add(Get_Partida.Items[vIndex].Id);
      vDMHash.Add(Get_Partida.Items[vIndex].Codigo);
      vDMHash.Add(Get_Partida.Items[vIndex].Descricao);
      vDMHash.Add(cHashKey);
    end;
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLPartidasType.Get_Hash: WideString;
begin
  Result := ChildNodes['hash'].Text;
end;

procedure TXMLPartidasType.SaveToFile(aFileName: string);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLPartidasType.Set_Hash(Value: WideString);
begin
  ChildNodes['hash'].NodeValue := Value;
end;

{ TXMLPartidaType }

function TXMLPartidaType.Get_Id: Integer;
begin
  Result := ChildNodes['id'].NodeValue;
end;

procedure TXMLPartidaType.Set_Id(Value: Integer);
begin
  ChildNodes['id'].NodeValue := Value;
end;

function TXMLPartidaType.Get_Codigo: WideString;
begin
  Result := ChildNodes['codigo'].Text;
end;

procedure TXMLPartidaType.Set_Codigo(Value: WideString);
begin
  ChildNodes['codigo'].NodeValue := Value;
end;

function TXMLPartidaType.Get_Descricao: WideString;
begin
  Result := ChildNodes['descricao'].Text;
end;

procedure TXMLPartidaType.Set_Descricao(Value: WideString);
begin
  ChildNodes['descricao'].NodeValue := Value;
end;

{ TXMLPartidaTypeList }

function TXMLPartidaTypeList.Add: IXMLPartidaType;
begin
  Result := AddItem(-1) as IXMLPartidaType;
end;

function TXMLPartidaTypeList.Insert(const Index: Integer): IXMLPartidaType;
begin
  Result := AddItem(Index) as IXMLPartidaType;
end;

function TXMLPartidaTypeList.Get_Item(Index: Integer): IXMLPartidaType;
begin
  Result := List[Index] as IXMLPartidaType;
end;

end.