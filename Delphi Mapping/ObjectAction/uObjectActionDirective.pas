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
unit uObjectActionDirective;

interface

uses
  uObjectAction, uObjectDaoDirective, Classes, Forms, SysUtils,
  uConstantDirective, TypInfo,
  uConstantUtils, Contnrs, uDMUtils, uDMList, uObjectActionCustom,
  uFactoryObject,
  DB, uObjectActionCommand;

type
  TDirective = class(TItemCommand)
  end;

  TListDirective = Class(TListCommand)
  public
    procedure Load; Override;
  end;

  TDirectiveabsolute = class(TDirective)
  end;

  TDirectiveexport = class(TDirective)
  end;

  TDirectivepublic = class(TDirective)
  end;

  TDirectivetdcall = class(TDirective)
  end;

  TDirectiveabstract = class(TDirective)
  end;

  TDirectiveexternal = class(TDirective)
  end;

  TDirectivenear = class(TDirective)
  end;

  TDirectivetrict = class(TDirective)
  end;

  TDirectivepublished = class(TDirective)
  end;

  TDirectiveassembler = class(TDirective)
  end;

  TDirectivefar = class(TDirective)
  end;

  TDirectiveautomated = class(TDirective)
  end;

  TDirectivefinal = class(TDirective)
  end;

  TDirectiveoperator = class(TDirective)
  end;

  TDirectiveunsafe = class(TDirective)
  end;

  TDirectivecdecl = class(TDirective)
  end;

  TDirectiveforward = class(TDirective)
  end;

  TDirectiveout = class(TDirective)
  end;

  TDirectivevarargs = class(TDirective)
  end;

  TDirectiveoverload = class(TDirective)
  end;

  TDirectiveregister = class(TDirective)
  end;

  TDirectivevirtual = class(TDirective)
  end;

  TDirectiveoverride = class(TDirective)
  end;

  TDirectivereintroduce = class(TDirective)
  end;

  TDirectivedeprecated = class(TDirective)
  end;

  TDirectiveinline = class(TDirective)
  end;

  TDirectivepascal = class(TDirective)
  end;

  TDirectivedispid = class(TDirective)
  end;

  TDirectivelibrary = class(TDirective)
  end;

  TDirectiveplatform = class(TDirective)
  end;

  TDirectiveafecall = class(TDirective)
  end;

  TDirectivedynamic = class(TDirective)
  end;

  TDirectiveprivate = class(TDirective)
  end;

  TDirectiveealed = class(TDirective)
  end;

  TDirectiveexperimental = class(TDirective)
  end;

  TDirectivemessage = class(TDirective)
  end;

  TDirectiveprotected = class(TDirective)
  end;

  TDirectiveStatic = class(TDirective)
  end;

  TDirectiveStrict = class(TDirective)
  end;

  /// <summary>
  /// Constrole ação das diretivas do delphi
  /// </summary>
  TObjectActionDirective = Class(TObjectActionCommand)
  protected
    function GetListCommand: TListCommand; Override;
  public
    FObjectDaoDirective: TObjectDaoDirective;
    function GetIDType: Integer; Override;
    procedure AfterConstruction; override;
  end;

implementation

{ TDirective }

procedure TObjectActionDirective.AfterConstruction;
begin

  inherited;
  FObjectDaoDirective := GetObjectDao as TObjectDaoDirective;
end;

{ TDirective }

function TObjectActionDirective.GetIDType: Integer;
begin
  Result := 2;
end;

{ TListDirective }

procedure TListDirective.Load;
begin
  inherited;
  Add(TDirectiveoverride);
  Add(TDirectivevirtual);
  Add(TDirectiveoverload);
  Add(TDirectiveabsolute);
  Add(TDirectiveexport);
  Add(TDirectivepublic);
  Add(TDirectivetdcall);
  Add(TDirectiveabstract);
  Add(TDirectiveexternal);
  Add(TDirectivenear);
  Add(TDirectivetrict);
  Add(TDirectivepublished);
  Add(TDirectiveassembler);
  Add(TDirectivefar);
  Add(TDirectiveautomated);
  Add(TDirectivefinal);
  Add(TDirectiveoperator);
  Add(TDirectiveunsafe);
  Add(TDirectivecdecl);
  Add(TDirectiveforward);
  Add(TDirectiveout);
  Add(TDirectivevarargs);
  Add(TDirectiveregister);
  Add(TDirectivereintroduce);
  Add(TDirectivedeprecated);
  Add(TDirectiveinline);
  Add(TDirectivepascal);
  Add(TDirectivedispid);
  Add(TDirectivelibrary);
  Add(TDirectiveplatform);
  Add(TDirectiveafecall);
  Add(TDirectivedynamic);
  Add(TDirectiveprivate);
  Add(TDirectiveealed);
  Add(TDirectiveexperimental);
  Add(TDirectivemessage);
  Add(TDirectiveprotected);
  Add(TDirectiveStatic);
  Add(TDirectiveStrict);
end;

function TObjectActionDirective.GetListCommand: TListCommand;
begin
  Result := TListDirective.Create(Self);
end;

initialization

RegisterClass(TObjectActionDirective);

end.
