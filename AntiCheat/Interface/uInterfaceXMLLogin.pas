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


{*******************************************************************************}
{                                                                               }
{                               XML Data Binding                                }
{                                                                               }
{         Generated on: 23/01/2013 22:34:59                                     }
{       Generated from: F:\Programação\Delphi\AntiCheat\XML\LoginRetorno2.xml   }
{   Settings stored in: F:\Programação\Delphi\AntiCheat\XML\LoginRetorno2.xdb   }
{                                                                               }
{*******************************************************************************}

unit uInterfaceXMLLogin;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLJogadorType = interface;

{ IXMLJogadorType }

  IXMLJogadorType = interface(IXMLNode)
    ['{6579A4EB-0E62-4A67-95F4-ADC1688F6762}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Login: WideString;
    function Get_Nome: WideString;
    function Get_Cla: WideString;
    function Get_Equipe: WideString;
    function Get_Sessid: Integer;
    function Get_Hash: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Login(Value: WideString);
    procedure Set_Nome(Value: WideString);
    procedure Set_Cla(Value: WideString);
    procedure Set_Equipe(Value: WideString);
    procedure Set_Sessid(Value: Integer);
    procedure Set_Hash(Value: WideString);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Login: WideString read Get_Login write Set_Login;
    property Nome: WideString read Get_Nome write Set_Nome;
    property Cla: WideString read Get_Cla write Set_Cla;
    property Equipe: WideString read Get_Equipe write Set_Equipe;
    property Sessid: Integer read Get_Sessid write Set_Sessid;
    property Hash: WideString read Get_Hash write Set_Hash;

    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ Forward Decls }

  TXMLJogadorType = class;

{ TXMLJogadorType }

  TXMLJogadorType = class(TXMLNode, IXMLJogadorType)
  protected
    { IXMLJogadorType }
    function Get_Id: Integer;
    function Get_Login: WideString;
    function Get_Nome: WideString;
    function Get_Cla: WideString;
    function Get_Equipe: WideString;
    function Get_Sessid: Integer;
    function Get_Hash: WideString;
    procedure Set_Id(Value: Integer);
    procedure Set_Login(Value: WideString);
    procedure Set_Nome(Value: WideString);
    procedure Set_Cla(Value: WideString);
    procedure Set_Equipe(Value: WideString);
    procedure Set_Sessid(Value: Integer);
    procedure Set_Hash(Value: WideString);
    procedure SaveToFile(aFileName: string);
    function CalculaHash: string;
  end;

{ Global Functions }

function Getjogador(Doc: IXMLDocument): IXMLJogadorType;
function Loadjogador(const FileName: string): IXMLJogadorType;
function Newjogador: IXMLJogadorType;

const
  TargetNamespace = '';

implementation

uses uDMUtils, uConstantSystem, uDMHash;

{ Global Functions }

function Getjogador(Doc: IXMLDocument): IXMLJogadorType;
begin
  Result := Doc.GetDocBinding('jogador', TXMLJogadorType, TargetNamespace) as IXMLJogadorType;
end;

function Loadjogador(const FileName: string): IXMLJogadorType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('jogador', TXMLJogadorType, TargetNamespace) as IXMLJogadorType;
end;

function Newjogador: IXMLJogadorType;
begin
  Result := NewXMLDocument.GetDocBinding('jogador', TXMLJogadorType, TargetNamespace) as IXMLJogadorType;
end;

{ TXMLJogadorType }

function TXMLJogadorType.Get_Id: Integer;
begin
  Result := ChildNodes['id'].NodeValue;
end;

procedure TXMLJogadorType.Set_Id(Value: Integer);
begin
  ChildNodes['id'].NodeValue := Value;
end;

function TXMLJogadorType.Get_Login: WideString;
begin
  Result := ChildNodes['login'].Text;
end;

procedure TXMLJogadorType.Set_Login(Value: WideString);
begin
  ChildNodes['login'].NodeValue := Value;
end;

function TXMLJogadorType.Get_Nome: WideString;
begin
  Result := ChildNodes['nome'].Text;
end;

procedure TXMLJogadorType.Set_Nome(Value: WideString);
begin
  ChildNodes['nome'].NodeValue := Value;
end;

function TXMLJogadorType.CalculaHash: string;
var
  vDMHash: TDMHash;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    vDMHash.Add(Get_Id);
    vDMHash.Add(Get_Login);
    vDMHash.Add(Get_Nome);
    vDMHash.Add(Get_Cla);
    vDMHash.Add(Get_Sessid);
    vDMHash.Add(cHashKey);
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLJogadorType.Get_Cla: WideString;
begin
  Result := ChildNodes['cla'].Text;
end;

function TXMLJogadorType.Get_Equipe: WideString;
begin
  Result := ChildNodes['equipe'].Text;
end;

procedure TXMLJogadorType.SaveToFile(aFileName: string);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLJogadorType.Set_Cla(Value: WideString);
begin
  ChildNodes['cla'].NodeValue := Value;
end;

procedure TXMLJogadorType.Set_Equipe(Value: WideString);
begin
  ChildNodes['equipe'].NodeValue := Value;
end;

function TXMLJogadorType.Get_Sessid: Integer;
begin
  Result := ChildNodes['sessid'].NodeValue;
end;

procedure TXMLJogadorType.Set_Sessid(Value: Integer);
begin
  ChildNodes['sessid'].NodeValue := Value;
end;

function TXMLJogadorType.Get_Hash: WideString;
begin
  Result := ChildNodes['hash'].Text;
end;

procedure TXMLJogadorType.Set_Hash(Value: WideString);
begin
  ChildNodes['hash'].NodeValue := Value;
end;

end.