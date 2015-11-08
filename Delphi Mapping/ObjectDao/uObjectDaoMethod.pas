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
unit uObjectDaoMethod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de métodos do arquivo mapeado
  /// </summary>
  /// <remarks>
  /// Podendo ser dentro de Class ou unit
  /// </remarks>
  /// <example>
  /// <para>
  /// public
  /// </para>
  /// <para>
  /// function GetName: string;
  /// </para>
  /// </example>
  TObjectDaoMethod = class(TObjectDao)
    CDSDadosID_METHOD: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    CDSDadosID_VISIBILITY_CLASS: TIntegerField;
    SQLDADOSID_METHOD: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSID_VISIBILITY_CLASS: TIntegerField;
    SQLDADOSIS_FUNCTION: TStringField;
    SQLDADOSIS_STATIC: TStringField;
    CDSDadosIS_STATIC: TStringField;
    CDSDadosIS_FUNCTION: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
{ TObjectDaoMethod }

initialization

RegisterClass(TObjectDaoMethod);

end.
