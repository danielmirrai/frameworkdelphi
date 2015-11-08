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
unit uObjectDaoComment;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de comentário da unit
  /// </summary>
  TObjectDaoComment = class(TObjectDao)
    CDSDadosID: TIntegerField;
    CDSDadosDATA: TStringField;
    CDSDadosID_TYPE_COMMENT: TIntegerField;
    SQLDADOSID: TIntegerField;
    SQLDADOSDATA: TStringField;
    SQLDADOSID_TYPE_COMMENT: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoComment }

{ TObjectDaoComment }

initialization

RegisterClass(TObjectDaoComment);

end.
