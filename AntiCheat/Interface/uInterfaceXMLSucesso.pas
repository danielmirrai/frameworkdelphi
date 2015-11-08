
{***********************************************************************************}
{                                                                                   }
{                                 XML Data Binding                                  }
{                                                                                   }
{         Generated on: 26/01/2013 14:44:36                                         }
{       Generated from: F:\Programação\Delphi\AntiCheat\XML\SelecionaPartida2.xml   }
{   Settings stored in: F:\Programação\Delphi\AntiCheat\XML\SelecionaPartida2.xdb   }
{                                                                                   }
{***********************************************************************************}

unit uInterfaceXMLSucesso;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLSucessoType = interface;

{ IXMLSucessoType }

  IXMLSucessoType = interface(IXMLNode)
    ['{E89E8513-1B56-4CB8-B0E1-D9B047A308FA}']
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
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ Forward Decls }

  TXMLSucessoType = class;

{ TXMLSucessoType }

  TXMLSucessoType = class(TXMLNode, IXMLSucessoType)
  protected
    { IXMLSucessoType }
    function Get_Codigo: Integer;
    function Get_Mensagem: WideString;
    function Get_Hash: WideString;
    procedure Set_Codigo(Value: Integer);
    procedure Set_Mensagem(Value: WideString);
    procedure Set_Hash(Value: WideString);
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ Global Functions }

function Getsucesso(Doc: IXMLDocument): IXMLSucessoType;
function Loadsucesso(const FileName: string): IXMLSucessoType;
function Newsucesso: IXMLSucessoType;

const
  TargetNamespace = '';

implementation

uses uDMUtils, uDMHash;

{ Global Functions }

function Getsucesso(Doc: IXMLDocument): IXMLSucessoType;
begin
  Result := Doc.GetDocBinding('sucesso', TXMLSucessoType, TargetNamespace) as IXMLSucessoType;
end;

function Loadsucesso(const FileName: string): IXMLSucessoType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('sucesso', TXMLSucessoType, TargetNamespace) as IXMLSucessoType;
end;

function Newsucesso: IXMLSucessoType;
begin
  Result := NewXMLDocument.GetDocBinding('sucesso', TXMLSucessoType, TargetNamespace) as IXMLSucessoType;
end;

{ TXMLSucessoType }

function TXMLSucessoType.CalculaHash: string;
var
  vDMHash: TDMHash;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    vDMHash.Add(Get_Codigo);
    vDMHash.Add(Get_Mensagem);
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLSucessoType.Get_Codigo: Integer;
begin
  Result := ChildNodes['codigo'].NodeValue;
end;

procedure TXMLSucessoType.SaveToFile(aFileName: string);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLSucessoType.Set_Codigo(Value: Integer);
begin
  ChildNodes['codigo'].NodeValue := Value;
end;

function TXMLSucessoType.Get_Mensagem: WideString;
begin
  Result := ChildNodes['mensagem'].Text;
end;

procedure TXMLSucessoType.Set_Mensagem(Value: WideString);
begin
  ChildNodes['mensagem'].NodeValue := Value;
end;

function TXMLSucessoType.Get_Hash: WideString;
begin
  Result := ChildNodes['hash'].Text;
end;

procedure TXMLSucessoType.Set_Hash(Value: WideString);
begin
  ChildNodes['hash'].NodeValue := Value;
end;

end.