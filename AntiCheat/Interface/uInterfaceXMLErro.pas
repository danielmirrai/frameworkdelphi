
{**********************************************************************}
{                                                                      }
{                           XML Data Binding                           }
{                                                                      }
{         Generated on: 23/01/2013 22:54:47                            }
{       Generated from: F:\Programação\Delphi\AntiCheat\XML\erro.xml   }
{   Settings stored in: F:\Programação\Delphi\AntiCheat\XML\erro.xdb   }
{                                                                      }
{**********************************************************************}

unit uInterfaceXMLErro;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLErroType = interface;

{ IXMLErroType }

  IXMLErroType = interface(IXMLNode)
    ['{FE12D23F-526F-4174-8D61-24AAC7F3CD73}']
    { Property Accessors }
    function Get_Codigo: Integer;
    function Get_Mensagem: WideString;
    function Get_Hash: WideString;
    procedure Set_Codigo(Value: Integer);
    procedure Set_Mensagem(Value: WideString);
    procedure Set_Hash(Value: WideString);
    { Methods & Properties }
    property Codigo: Integer read Get_Codigo write Set_Codigo;
    property Mensagem: WideString read Get_Mensagem write Set_Mensagem;
    property Hash: WideString read Get_Hash write Set_Hash;
    function CalculaHash: string;
    procedure SaveToFile(aFileName: string);
  end;

{ Forward Decls }

  TXMLErroType = class;

{ TXMLErroType }

  TXMLErroType = class(TXMLNode, IXMLErroType)
  protected
    { IXMLErroType }
    function Get_Codigo: Integer;
    function Get_Mensagem: WideString;
    function Get_Hash: WideString;
    procedure Set_Codigo(Value: Integer);
    procedure Set_Mensagem(Value: WideString);
    procedure Set_Hash(Value: WideString);
    function CalculaHash: string;
    procedure SaveToFile(aFileName: string);
  end;

{ Global Functions }

function GetErro(Doc: IXMLDocument): IXMLErroType;
function Loaderro(const FileName: string): IXMLErroType;
function Newerro: IXMLErroType;

const
  TargetNamespace = '';

implementation

uses uConstantSystem, uDMUtils, uDMHash;

{ Global Functions }

function GetErro(Doc: IXMLDocument): IXMLErroType;
begin
  Result := Doc.GetDocBinding('erro', TXMLErroType, TargetNamespace) as IXMLErroType;
end;

function Loaderro(const FileName: string): IXMLErroType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('erro', TXMLErroType, TargetNamespace) as IXMLErroType;
end;

function Newerro: IXMLErroType;
begin
  Result := NewXMLDocument.GetDocBinding('erro', TXMLErroType, TargetNamespace) as IXMLErroType;
end;

{ TXMLErroType }

function TXMLErroType.CalculaHash: string;
var
  vDMHash: TDMHash;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    vDMHash.Add(Get_Codigo);
    vDMHash.Add(Get_Mensagem);
    vDMHash.Add(cHashKey);
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLErroType.Get_Codigo: Integer;
begin
  Result := ChildNodes['codigo'].NodeValue;
end;

procedure TXMLErroType.SaveToFile(aFileName: string);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLErroType.Set_Codigo(Value: Integer);
begin
  ChildNodes['codigo'].NodeValue := Value;
end;

function TXMLErroType.Get_Mensagem: WideString;
begin
  Result := ChildNodes['mensagem'].Text;
end;

procedure TXMLErroType.Set_Mensagem(Value: WideString);
begin
  ChildNodes['mensagem'].NodeValue := Value;
end;

function TXMLErroType.Get_Hash: WideString;
begin
  Result := ChildNodes['hash'].Text;
end;

procedure TXMLErroType.Set_Hash(Value: WideString);
begin
  ChildNodes['hash'].NodeValue := Value;
end;

end.