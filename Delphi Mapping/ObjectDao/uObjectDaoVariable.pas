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
unit uObjectDaoVariable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de Variáveis
  /// </summary>
  /// <remarks>
  /// <para>
  /// * Variável de Global de Unit
  /// </para>
  /// <para>
  /// * Variável de Class
  /// </para>
  /// <para>
  /// * Variável de Método
  /// </para>
  /// <para>
  /// * Parâmetro
  /// </para>
  /// </remarks>
  TObjectDaoVariable = class(TObjectDao)
    CDSDadosID_VARIABLE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_METHOD: TIntegerField;
    CDSDadosID_VISIBILITY_CLASS: TIntegerField;
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    CDSDadosID_TYPE_VALUE: TStringField;
    CDSDadosTYPE_MODIFY: TStringField;
    SQLDADOSID_VARIABLE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSDEFAULT_VAR: TStringField;
    SQLDADOSIS_PARAM: TStringField;
    SQLDADOSVALUE_VAR: TStringField;
    SQLDADOSID_METHOD: TIntegerField;
    SQLDADOSID_VISIBILITY_CLASS: TIntegerField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSIS_STATIC: TStringField;
    SQLDADOSID_TYPE_VALUE: TStringField;
    SQLDADOSTYPE_MODIFY: TStringField;
    SQLDADOSIS_RETURN: TStringField;
    SQLDADOSINDEX_VAR: TIntegerField;
    CDSDadosDEFAULT_VAR: TStringField;
    CDSDadosVALUE_VAR: TStringField;
    CDSDadosINDEX_VAR: TIntegerField;
    CDSDadosIS_PARAM: TStringField;
    CDSDadosIS_STATIC: TStringField;
    CDSDadosIS_RETURN: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uObjectDaoApplication;

initialization

RegisterClass(TObjectDaoVariable);

end.
