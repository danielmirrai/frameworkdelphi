{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectActionOperator;

interface

uses
  uObjectAction, uObjectDaoOperator, Classes, Forms, SysUtils,
  uConstantOperator, uDMList, TypInfo,
  uConstantUtils, Contnrs, uDMUtils, uObjectActionCustom, DB, Dialogs,
  uObjectActionCommand;

type

  TOperator = class(TItemCommand)
  end;

  TListOperator = Class(TListCommand)
  public
    /// <summary>
    /// Carrega todos os camandos de operações do delphi
    /// </summary>
    procedure ImportAll; Override;
  end;

  TOperatorFullStop = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorColon = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorSquare_BracketsBegin = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorSquare_BracketsEnd = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorBracketsEnd = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorBracketsBegin = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorSemicolon = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorAt_Sign = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorNot = class(TOperator)
  end;

  TOperatorCaret = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorMultiplication = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorDivision = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorDiv = class(TOperator)
  end;

  TOperatorMod = class(TOperator)
  end;

  TOperatorAnd = class(TOperator)
  end;

  TOperatorShl = class(TOperator)
  end;

  TOperatorShr = class(TOperator)
  end;

  TOperatorAs = class(TOperator)
  end;

  TOperatorAddition = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorSubtraction = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorOr = class(TOperator)
  end;

  TOperatorXor = class(TOperator)
  end;

  TOperatorEquality = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorGreater_Than = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorLess_Than = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorInequality = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorsubset = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorSuperset = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorComma = class(TOperator)
  public
    function GetCommand: string; Override;
  end;

  TOperatorIn = class(TOperator)
  end;

  TOperatorIs = class(TOperator)
  end;

  /// <summary>
  /// Constrole ação de operadores do delphi
  /// </summary>
  /// <example>
  /// <para>
  /// 1 + 1
  /// </para>
  /// <para>
  /// 2 * 1
  /// </para>
  /// </example>
  TObjectActionOperator = Class(TObjectActionCommand)
  protected
    function GetListCommand: TListCommand; Override;
  public
    FObjectDaoOperator: TObjectDaoOperator;
    function GetIDType: Integer; Override;
    procedure AfterConstruction; override;
  end;

implementation

uses uFactoryObject;

procedure TObjectActionOperator.AfterConstruction;
begin
  inherited;
  FObjectDaoOperator := GetObjectDao as TObjectDaoOperator;
end;

{ TOperator }

{ TOperatorAt_Sign }

function TOperatorAt_Sign.GetCommand: string;
begin
  Result := '@';
end;

{ TOperatorCaret }

function TOperatorCaret.GetCommand: string;
begin
  Result := '^';
end;

{ TOperatorMultiplication }

function TOperatorMultiplication.GetCommand: string;
begin
  Result := '*';
end;

{ TOperatorDivision }

function TOperatorDivision.GetCommand: string;
begin
  Result := '/';
end;

{ TOperatorAddition }

function TOperatorAddition.GetCommand: string;
begin
  Result := '+';
end;

{ TOperatorSubtraction }

function TOperatorSubtraction.GetCommand: string;
begin
  Result := '-';
end;

{ TOperatorEquality }

function TOperatorEquality.GetCommand: string;
begin
  Result := '=';
end;

{ TOperatorGreater_Than }

function TOperatorGreater_Than.GetCommand: string;
begin
  Result := '>';
end;

{ TOperatorLess_Than }

function TOperatorLess_Than.GetCommand: string;
begin
  Result := '<';
end;

{ TOperatorInequality }

function TOperatorInequality.GetCommand: string;
begin
  Result := '<>';
end;

{ TOperatorsubset }

function TOperatorsubset.GetCommand: string;
begin
  Result := '<=';
end;

{ TOperatorSuperset }

function TOperatorSuperset.GetCommand: string;
begin
  Result := '>=';
end;

{ TListOperator }

procedure TListOperator.ImportAll;
begin
  inherited;
  Add(TOperatorFullStop);
  Add(TOperatorColon);
  Add(TOperatorSquare_BracketsBegin);
  Add(TOperatorSquare_BracketsEnd);
  Add(TOperatorBracketsBegin);
  Add(TOperatorBracketsEnd);
  Add(TOperatorSemicolon);
  Add(TOperatorAt_Sign);
  Add(TOperatorNot);
  Add(TOperatorCaret);
  Add(TOperatorMultiplication);
  Add(TOperatorDivision);
  Add(TOperatorDiv);
  Add(TOperatorMod);
  Add(TOperatorAnd);
  Add(TOperatorShl);
  Add(TOperatorShr);
  Add(TOperatorAs);
  Add(TOperatorAddition);
  Add(TOperatorSubtraction);
  Add(TOperatorOr);
  Add(TOperatorXor);
  Add(TOperatorEquality);
  Add(TOperatorGreater_Than);
  Add(TOperatorLess_Than);
  Add(TOperatorInequality);
  Add(TOperatorsubset);
  Add(TOperatorSuperset);
  Add(TOperatorComma);
  Add(TOperatorIn);
  Add(TOperatorIs);
end;

{ TOperatorFullStop }

function TOperatorFullStop.GetCommand: string;
begin
  Result := '.';
end;

{ TOperatorColon }

function TOperatorColon.GetCommand: string;
begin
  Result := ':';
end;

{ TOperatorBracketsEnd }

function TOperatorBracketsEnd.GetCommand: string;
begin
  Result := ')';
end;

{ TOperatorBracketsBegin }

function TOperatorBracketsBegin.GetCommand: string;
begin
  Result := '(';
end;

{ TOperatorSemicolon }

function TOperatorSemicolon.GetCommand: string;
begin
  Result := ';';
end;

{ TOperatorComma }

function TOperatorComma.GetCommand: string;
begin
  Result := ',';
end;

{ TOperatorSquare_BracketsBegin }

function TOperatorSquare_BracketsBegin.GetCommand: string;
begin
  Result := '[';
end;

{ TOperatorSquare_BracketsEnd }

function TOperatorSquare_BracketsEnd.GetCommand: string;
begin
  Result := ']';
end;

function TObjectActionOperator.GetListCommand: TListCommand;
begin
  Result := TListOperator.Create(Self);
end;

{ TOperator }

function TObjectActionOperator.GetIDType: Integer;
begin
  Result := 3;
end;

initialization

RegisterClass(TObjectActionOperator);

end.
