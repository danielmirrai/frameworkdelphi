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



{***********************************************************}
{                                                           }
{                     XML Data Binding                      }
{                                                           }
{         Generated on: 11/01/2013 21:17:21                 }
{       Generated from: C:\Users\Daniel\Desktop\teste.xml   }
{   Settings stored in: C:\Users\Daniel\Desktop\teste.xdb   }
{                                                           }
{***********************************************************}

unit uInterfaceXMLProcess;

interface

uses XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPROCESSOSType = interface;
  IXMLPROCESSOType = interface;

{ IXMLPROCESSOSType }

  IXMLPROCESSOSType = interface(IXMLNodeCollection)
    ['{8CB3C8DD-5237-4E98-8422-77936253F1E3}']
    { Property Accessors }
    function Get_PROCESSO(Index: Integer): IXMLPROCESSOType;
    { Methods & Properties }
    function Add: IXMLPROCESSOType;
    function Insert(const Index: Integer): IXMLPROCESSOType;
    procedure Set_HASH(Value: WideString);
    function Get_HASH: WideString;
    property PROCESSO[Index: Integer]: IXMLPROCESSOType read Get_PROCESSO; default;
    procedure SaveToFile(aFileName: WideString);
    function CalculaHash: WideString;

    property HASH: WideString read Get_HASH write Set_HASH;
  end;

{ IXMLPROCESSOType }

  IXMLPROCESSOType = interface(IXMLNode)
    ['{D2288A9B-8B87-4408-8CF2-2476C3247DCA}']
    { Property Accessors }
    function Get_NOME: WideString;
    function Get_DESCRICAO: WideString;
    function Get_NOME_USUARIO_SISTEMA: WideString;
    function Get_MEMORIA_RAM_UTILIZADA: Integer;
    function Get_CPU_UTILIZADO: Integer;
    procedure Set_NOME(Value: WideString);
    procedure Set_DESCRICAO(Value: WideString);
    procedure Set_NOME_USUARIO_SISTEMA(Value: WideString);
    procedure Set_MEMORIA_RAM_UTILIZADA(Value: Integer);
    procedure Set_CPU_UTILIZADO(Value: Integer);
    procedure Set_EMPRESA(Value: WideString);
    function Get_EMPRESA: WideString;
    procedure Set_VERSAO_ARQUIVO(Value: WideString);
    function Get_VERSAO_ARQUIVO: WideString;
    procedure Set_NOME_INTERNO(Value: WideString);
    function Get_NOME_INTERNO: WideString;
    procedure Set_COPYRIGHT(Value: WideString);
    function Get_COPYRIGHT: WideString;
    procedure Set_NOME_ORIGINAL(Value: WideString);
    function Get_NOME_ORIGINAL: WideString;
    procedure Set_PRODUTO(Value: WideString);
    function Get_PRODUTO: WideString;
    procedure Set_VERSAO_PRODUTO(Value: WideString);
    function Get_VERSAO_PRODUTO: WideString;
    procedure Set_COMENTARIOS(Value: WideString);
    function Get_COMENTARIOS: WideString;
    procedure Set_ATRIBUTOS(Value: WideString);
    function Get_ATRIBUTOS: WideString;
    procedure Set_TIPO(Value: WideString);
    function Get_TIPO: WideString;
    procedure Set_OS(Value: WideString);
    function Get_OS: WideString;
    procedure Set_DIRETORIO(Value: WideString);
    function Get_DIRETORIO: WideString;
    procedure Set_MD5(Value: WideString);
    function Get_MD5: WideString;
    { Methods & Properties }
    property NOME: WideString read Get_NOME write Set_NOME;
    property DESCRICAO: WideString read Get_DESCRICAO write Set_DESCRICAO;
    property NOME_USUARIO_SISTEMA: WideString read Get_NOME_USUARIO_SISTEMA write Set_NOME_USUARIO_SISTEMA;
    property MEMORIA_RAM_UTILIZADA: Integer read Get_MEMORIA_RAM_UTILIZADA write Set_MEMORIA_RAM_UTILIZADA;
    property CPU_UTILIZADO: Integer read Get_CPU_UTILIZADO write Set_CPU_UTILIZADO;
    property EMPRESA: WideString read Get_EMPRESA write Set_EMPRESA;
    property VERSAO_ARQUIVO: WideString read Get_VERSAO_ARQUIVO write Set_VERSAO_ARQUIVO;
    property NOME_INTERNO: WideString read Get_NOME_INTERNO write Set_NOME_INTERNO;
    property COPYRIGHT: WideString read Get_COPYRIGHT write Set_COPYRIGHT;
    property NOME_ORIGINAL: WideString read Get_NOME_ORIGINAL write Set_NOME_ORIGINAL;
    property PRODUTO: WideString read Get_PRODUTO write Set_PRODUTO;
    property VERSAO_PRODUTO: WideString read Get_VERSAO_PRODUTO write Set_VERSAO_PRODUTO;
    property COMENTARIOS: WideString read Get_COMENTARIOS write Set_COMENTARIOS;
    property ATRIBUTOS: WideString read Get_ATRIBUTOS write Set_ATRIBUTOS;
    property TIPO: WideString read Get_TIPO write Set_TIPO;
    property OS: WideString read Get_OS write Set_OS;
    property DIRETORIO: WideString read Get_DIRETORIO write Set_DIRETORIO;
    property MD5: WideString read Get_MD5 write Set_MD5;
  end;

{ Forward Decls }

  TXMLPROCESSOSType = class;
  TXMLPROCESSOType = class;

{ TXMLPROCESSOSType }

  TXMLPROCESSOSType = class(TXMLNodeCollection, IXMLPROCESSOSType)
  protected
    { IXMLPROCESSOSType }
    function Get_PROCESSO(Index: Integer): IXMLPROCESSOType;
    function Add: IXMLPROCESSOType;
    function Insert(const Index: Integer): IXMLPROCESSOType;
  public
    procedure Set_HASH(Value: WideString);
    function Get_HASH: WideString;
    procedure SaveToFile(aFileName: WideString);
    function CalculaHash: WideString;
    procedure AfterConstruction; override;
  end;

{ TXMLPROCESSOType }

  TXMLPROCESSOType = class(TXMLNode, IXMLPROCESSOType)
  public
    { IXMLPROCESSOType }
    function Get_NOME: WideString;
    function Get_DESCRICAO: WideString;
    function Get_NOME_USUARIO_SISTEMA: WideString;
    function Get_MEMORIA_RAM_UTILIZADA: Integer;
    function Get_CPU_UTILIZADO: Integer;
    function Get_EMPRESA: WideString;
    procedure Set_NOME(Value: WideString);
    procedure Set_DESCRICAO(Value: WideString);
    procedure Set_NOME_USUARIO_SISTEMA(Value: WideString);
    procedure Set_MEMORIA_RAM_UTILIZADA(Value: Integer);
    procedure Set_CPU_UTILIZADO(Value: Integer);
    procedure Set_EMPRESA(Value: WideString);
    procedure Set_VERSAO_ARQUIVO(Value: WideString);
    function Get_VERSAO_ARQUIVO: WideString;
    procedure Set_NOME_INTERNO(Value: WideString);
    function Get_NOME_INTERNO: WideString;
    procedure Set_COPYRIGHT(Value: WideString);
    function Get_COPYRIGHT: WideString;
    procedure Set_NOME_ORIGINAL(Value: WideString);
    function Get_NOME_ORIGINAL: WideString;
    procedure Set_PRODUTO(Value: WideString);
    function Get_PRODUTO: WideString;
    procedure Set_VERSAO_PRODUTO(Value: WideString);
    function Get_VERSAO_PRODUTO: WideString;
    procedure Set_COMENTARIOS(Value: WideString);
    function Get_COMENTARIOS: WideString;
    procedure Set_ATRIBUTOS(Value: WideString);
    function Get_ATRIBUTOS: WideString;
    procedure Set_TIPO(Value: WideString);
    function Get_TIPO: WideString;
    procedure Set_OS(Value: WideString);
    function Get_OS: WideString;
    procedure Set_DIRETORIO(Value: WideString);
    function Get_DIRETORIO: WideString;
    procedure Set_MD5(Value: WideString);
    function Get_MD5: WideString;
  end;

{ Global Functions }

function GetPROCESSOS(Doc: IXMLDocument): IXMLPROCESSOSType;
function LoadPROCESSOS(const FileName: WideString): IXMLPROCESSOSType;
function NewPROCESSOS: IXMLPROCESSOSType;

const
  TargetNamespace = '';

implementation

uses uDMUtils, uDMHash, uConstantSystem;

{ Global Functions }

function GetPROCESSOS(Doc: IXMLDocument): IXMLPROCESSOSType;
begin
  Result := Doc.GetDocBinding('PROCESSOS', TXMLPROCESSOSType, TargetNamespace) as IXMLPROCESSOSType;
end;

function LoadPROCESSOS(const FileName: WideString): IXMLPROCESSOSType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('PROCESSOS', TXMLPROCESSOSType, TargetNamespace) as IXMLPROCESSOSType;
end;

function NewPROCESSOS: IXMLPROCESSOSType;
begin
  Result := NewXMLDocument.GetDocBinding('PROCESSOS', TXMLPROCESSOSType, TargetNamespace) as IXMLPROCESSOSType;
end;

{ TXMLPROCESSOSType }

procedure TXMLPROCESSOSType.AfterConstruction;
begin
  RegisterChildNode('PROCESSO', TXMLPROCESSOType);
  ItemTag := 'PROCESSO';
  ItemInterface := IXMLPROCESSOType;
  inherited;
end;



function TXMLPROCESSOSType.CalculaHash: WideString;
var
  vDMHash: TDMHash;
  vIndex: Integer;
  vXMLPROCESSO: IXMLPROCESSOType;
begin
  Result  := '';
  vDMHash := nil;
  try
    vDMHash := TDMHash.Create;
    for vIndex := 0 to GetCount -1 do
    begin
      vXMLPROCESSO := Get_PROCESSO(vIndex);
      vDMHash.Add(vXMLPROCESSO.Get_NOME);
      vDMHash.Add(vXMLPROCESSO.Get_DESCRICAO);
      vDMHash.Add(vXMLPROCESSO.Get_NOME_USUARIO_SISTEMA);
      vDMHash.Add(vXMLPROCESSO.Get_MEMORIA_RAM_UTILIZADA);
      vDMHash.Add(vXMLPROCESSO.Get_CPU_UTILIZADO);
      vDMHash.Add(vXMLPROCESSO.Get_EMPRESA);
      vDMHash.Add(vXMLPROCESSO.Get_VERSAO_ARQUIVO);
      vDMHash.Add(vXMLPROCESSO.Get_NOME_INTERNO);
      vDMHash.Add(vXMLPROCESSO.Get_COPYRIGHT);
      vDMHash.Add(vXMLPROCESSO.Get_NOME_ORIGINAL);
      vDMHash.Add(vXMLPROCESSO.Get_PRODUTO);
      vDMHash.Add(vXMLPROCESSO.Get_VERSAO_PRODUTO);
      vDMHash.Add(vXMLPROCESSO.Get_COMENTARIOS);
      vDMHash.Add(vXMLPROCESSO.Get_ATRIBUTOS);
      vDMHash.Add(vXMLPROCESSO.Get_TIPO);
      vDMHash.Add(vXMLPROCESSO.Get_OS);
      vDMHash.Add(vXMLPROCESSO.Get_DIRETORIO);
      vDMHash.Add(vXMLPROCESSO.Get_MD5);
    end;
    vDMHash.Add(cHashKey);
    Result := vDMHash.GetHash;
  finally
    TDMUtils.DestroyObject(vDMHash);
  end;
  Result := Get_Hash;
end;

function TXMLPROCESSOSType.Get_HASH: WideString;
begin
  Result := ChildNodes['HASH'].Text;
end;

function TXMLPROCESSOSType.Get_PROCESSO(Index: Integer): IXMLPROCESSOType;
begin
  Result := List[Index] as IXMLPROCESSOType;
end;

function TXMLPROCESSOSType.Add: IXMLPROCESSOType;
begin
  Result := AddItem(-1) as IXMLPROCESSOType;
end;

function TXMLPROCESSOSType.Insert(const Index: Integer): IXMLPROCESSOType;
begin
  Result := AddItem(Index) as IXMLPROCESSOType;
end;

procedure TXMLPROCESSOSType.SaveToFile(aFileName: WideString);
begin
  TDMUtils.XMLSaveToFile(aFileName, Self.GetXML);
end;

procedure TXMLPROCESSOSType.Set_HASH(Value: WideString);
begin
  ChildNodes['HASH'].NodeValue := Value;
end;

{ TXMLPROCESSOType }

function TXMLPROCESSOType.Get_NOME: WideString;
begin
  Result := ChildNodes['NOME'].Text;
end;

procedure TXMLPROCESSOType.Set_NOME(Value: WideString);
begin
  ChildNodes['NOME'].NodeValue := Value;
end;

function TXMLPROCESSOType.Get_DESCRICAO: WideString;
begin
  Result := ChildNodes['DESCRICAO'].Text;
end;

function TXMLPROCESSOType.Get_DIRETORIO: WideString;
begin
  Result := ChildNodes['DIRETORIO'].Text;
end;

function TXMLPROCESSOType.Get_EMPRESA: WideString;
begin
  Result := ChildNodes['EMPRESA'].Text;
end;

procedure TXMLPROCESSOType.Set_DESCRICAO(Value: WideString);
begin
  ChildNodes['DESCRICAO'].NodeValue := Value;
end;

function TXMLPROCESSOType.Get_NOME_INTERNO: WideString;
begin
  Result := ChildNodes['NOME_INTERNO'].Text;
end;

function TXMLPROCESSOType.Get_NOME_ORIGINAL: WideString;
begin
  Result := ChildNodes['NOME_ORIGINAL'].Text;
end;

procedure TXMLPROCESSOType.Set_DIRETORIO(Value: WideString);
begin
  ChildNodes['DIRETORIO'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_EMPRESA(Value: WideString);
begin
  ChildNodes['EMPRESA'].NodeValue := Value;
end;

function TXMLPROCESSOType.Get_NOME_USUARIO_SISTEMA: WideString;
begin
  Result := ChildNodes['NOME_USUARIO_SISTEMA'].Text;
end;

function TXMLPROCESSOType.Get_OS: WideString;
begin
  Result := ChildNodes['OS'].Text;
end;

function TXMLPROCESSOType.Get_PRODUTO: WideString;
begin
  Result := ChildNodes['PRODUTO'].Text;
end;

function TXMLPROCESSOType.Get_TIPO: WideString;
begin
  Result := ChildNodes['TIPO'].Text;
end;

function TXMLPROCESSOType.Get_VERSAO_ARQUIVO: WideString;
begin
  Result := ChildNodes['VERSAO_ARQUIVO'].Text;
end;

function TXMLPROCESSOType.Get_VERSAO_PRODUTO: WideString;
begin
  Result := ChildNodes['VERSAO_PRODUTO'].Text;
end;

procedure TXMLPROCESSOType.Set_NOME_INTERNO(Value: WideString);
begin
  ChildNodes['NOME_INTERNO'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_NOME_ORIGINAL(Value: WideString);
begin
  ChildNodes['NOME_ORIGINAL'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_NOME_USUARIO_SISTEMA(Value: WideString);
begin
  ChildNodes['NOME_USUARIO_SISTEMA'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_OS(Value: WideString);
begin
  ChildNodes['OS'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_PRODUTO(Value: WideString);
begin
  ChildNodes['PRODUTO'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_TIPO(Value: WideString);
begin
  ChildNodes['TIPO'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_VERSAO_ARQUIVO(Value: WideString);
begin
  ChildNodes['VERSAO_ARQUIVO'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_VERSAO_PRODUTO(Value: WideString);
begin
  ChildNodes['VERSAO_PRODUTO'].NodeValue := Value;
end;

function TXMLPROCESSOType.Get_MD5: WideString;
begin
  Result := ChildNodes['MD5'].Text;
end;

function TXMLPROCESSOType.Get_MEMORIA_RAM_UTILIZADA: Integer;
begin
  Result := ChildNodes['MEMORIA_RAM_UTILIZADA'].NodeValue;
end;

procedure TXMLPROCESSOType.Set_MD5(Value: WideString);
begin
  ChildNodes['MD5'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_MEMORIA_RAM_UTILIZADA(Value: Integer);
begin
  ChildNodes['MEMORIA_RAM_UTILIZADA'].NodeValue := Value;
end;


function TXMLPROCESSOType.Get_ATRIBUTOS: WideString;
begin
  Result := ChildNodes['ATRIBUTOS'].Text;
end;

function TXMLPROCESSOType.Get_COMENTARIOS: WideString;
begin
  Result := ChildNodes['COMENTARIOS'].Text;
end;

function TXMLPROCESSOType.Get_COPYRIGHT: WideString;
begin
  Result := ChildNodes['COPYRIGHT'].Text;
end;

function TXMLPROCESSOType.Get_CPU_UTILIZADO: Integer;
begin
  Result := ChildNodes['CPU_UTILIZADO'].NodeValue;
end;

procedure TXMLPROCESSOType.Set_ATRIBUTOS(Value: WideString);
begin
  ChildNodes['ATRIBUTOS'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_COMENTARIOS(Value: WideString);
begin
  ChildNodes['COMENTARIOS'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_COPYRIGHT(Value: WideString);
begin
  ChildNodes['COPYRIGHT'].NodeValue := Value;
end;

procedure TXMLPROCESSOType.Set_CPU_UTILIZADO(Value: Integer);
begin
  ChildNodes['CPU_UTILIZADO'].NodeValue := Value;
end;

end.