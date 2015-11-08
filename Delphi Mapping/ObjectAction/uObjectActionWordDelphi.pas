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
unit uObjectActionWordDelphi;

interface

uses
  uObjectAction, uObjectDaoWordDelphi, Classes, Forms, SysUtils,
  uConstantWordDelphi,
  TypInfo, uDMList,
  uConstantUtils, uDMUtils, Contnrs, uObjectActionCustom, uFactoryObject,
  DB, uObjectActionCommand;

type
  TWord = class(TItemCommand)
  end;

  TListWord = class(TListCommand)
  public
    procedure ImportAll; Override;
  end;

  TWordend = class(TWord)
  end;

  TWordinterface = class(TWord)
  end;

  TWordrecord = class(TWord)
  end;

  TWordvar = class(TWord)
  end;

  TWordarray = class(TWord)
  end;

  TWordexcept = class(TWord)
  end;

  TWordrepeat = class(TWord)
  end;

  TWordwhile = class(TWord)
  end;

  TWordexports = class(TWord)
  end;

  TWordlabel = class(TWord)
  end;

  TWordresourcestring = class(TWord)
  end;

  TWordwith = class(TWord)
  end;

  TWordasm = class(TWord)
  end;

  TWordfile = class(TWord)
  end;

  TWordlibrary = class(TWord)
  end;

  TWordDelphiet = class(TWord)
  end;

  TWordbegin = class(TWord)
  end;

  TWordfinalization = class(TWord)
  end;

  TWordcase = class(TWord)
  end;

  TWordfinally = class(TWord)
  end;

  TWordnil = class(TWord)
  end;

  TWordclass = class(TWord)
  end;

  TWordfor = class(TWord)
  end;

  TWordDelphitring = class(TWord)
  end;

  TWordconst = class(TWord)
  end;

  TWordfunction = class(TWord)
  end;

  TWordobject = class(TWord)
  end;

  TWordthen = class(TWord)
  end;

  TWordconstructor = class(TWord)
  end;

  TWordgoto = class(TWord)
  end;

  TWordof = class(TWord)
  end;

  TWordthreadvar = class(TWord)
  end;

  TWorddestructor = class(TWord)
  end;

  TWordif = class(TWord)
  end;

  TWordto = class(TWord)
  end;

  TWorddispinterface = class(TWord)
  end;

  TWordimplementation = class(TWord)
  end;

  TWordpacked = class(TWord)
  end;

  TWordtry = class(TWord)
  end;

  TWordin = class(TWord)
  end;

  TWordprocedure = class(TWord)
  end;

  TWordtype = class(TWord)
  end;

  TWorddo = class(TWord)
  end;

  TWordinherited = class(TWord)
  end;

  TWordprogram = class(TWord)
  end;

  TWordunit = class(TWord)
  end;

  TWorddownto = class(TWord)
  end;

  TWordinitialization = class(TWord)
  end;

  TWordproperty = class(TWord)
  end;

  TWorduntil = class(TWord)
  end;

  TWordelse = class(TWord)
  end;

  TWordinline = class(TWord)
  end;

  TWordraise = class(TWord)
  end;

  TWorduses = class(TWord)
  end;

  TWordpackage = class(TWord)
  end;

  TWordrequires = class(TWord)
  end;

  TWordSet = class(TWord)
  end;

  /// <summary>
  /// Ação de comandos do delphi
  /// </summary>
  /// <example>
  /// <para>
  /// Begin
  /// </para>
  /// <para>
  /// End
  /// </para>
  /// </example>
  TObjectActionWordDelphi = Class(TObjectActionCommand)
  protected
    function GetListCommand: TListCommand; Override;
  public
    FObjectDaoWordDelphi: TObjectDaoWordDelphi;
    function GetIDType: Integer; Override;
    procedure AfterConstruction; override;
  end;

implementation

procedure TObjectActionWordDelphi.AfterConstruction;
begin

  inherited;
  FObjectDaoWordDelphi := GetObjectDao as TObjectDaoWordDelphi;
end;

{ TListWord }

procedure TListWord.ImportAll;
begin
  Add(TWordend);
  Add(TWordinterface);
  Add(TWordrecord);
  Add(TWordvar);
  Add(TWordarray);
  Add(TWordexcept);
  Add(TWordrepeat);
  Add(TWordwhile);
  Add(TWordexports);
  Add(TWordlabel);
  Add(TWordresourcestring);
  Add(TWordwith);
  Add(TWordasm);
  Add(TWordfile);
  Add(TWordlibrary);
  Add(TWordDelphiet);
  Add(TWordbegin);
  Add(TWordfinalization);
  Add(TWordcase);
  Add(TWordfinally);
  Add(TWordnil);
  Add(TWordclass);
  Add(TWordfor);
  Add(TWordDelphitring);
  Add(TWordconst);
  Add(TWordfunction);
  Add(TWordobject);
  Add(TWordthen);
  Add(TWordconstructor);
  Add(TWordgoto);
  Add(TWordof);
  Add(TWordthreadvar);
  Add(TWorddestructor);
  Add(TWordif);
  Add(TWordto);
  Add(TWorddispinterface);
  Add(TWordimplementation);
  Add(TWordpacked);
  Add(TWordtry);
  Add(TWordin);
  Add(TWordprocedure);
  Add(TWordtype);
  Add(TWorddo);
  Add(TWordinherited);
  Add(TWordprogram);
  Add(TWordunit);
  Add(TWorddownto);
  Add(TWordinitialization);
  Add(TWordproperty);
  Add(TWorduntil);
  Add(TWordelse);
  Add(TWordinline);
  Add(TWordraise);
  Add(TWorduses);
  Add(TWordpackage);
  Add(TWordrequires);
  Add(TWordSet);
end;

function TObjectActionWordDelphi.GetListCommand: TListCommand;
begin
  Result := TListWord.Create(Self);
end;

{ TWord }

function TObjectActionWordDelphi.GetIDType: Integer;
begin
  Result := 4;
end;

initialization

RegisterClass(TObjectActionWordDelphi);

end.
