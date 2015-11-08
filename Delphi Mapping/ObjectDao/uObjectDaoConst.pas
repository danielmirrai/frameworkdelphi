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
unit uObjectDaoConst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de const da unit
  /// </summary>
  TObjectDaoConst = class(TObjectDao)
    CDSDadosID_CONST: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_METHOD: TIntegerField;
    CDSDadosID_VISIBILITY_CLASS: TIntegerField;
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    CDSDadosID_TYPE_VALUE: TStringField;
    SQLDADOSID_CONST: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSVALUE_CONST: TStringField;
    SQLDADOSID_METHOD: TIntegerField;
    SQLDADOSID_VISIBILITY_CLASS: TIntegerField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSID_TYPE_VALUE: TStringField;
    CDSDadosVALUE_CONST: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uObjectDaoApplication;

initialization

RegisterClass(TObjectDaoConst);

end.
