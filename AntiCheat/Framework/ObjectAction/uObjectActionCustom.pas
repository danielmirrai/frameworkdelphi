{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi S�nior }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Fones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectActionCustom;

interface

uses
  uObjectDaoCustom, Classes, SysUtils;

type
  TClassObjectActionCustom = class of TObjectActionCustom;

  /// <summary>
  /// Controle a��o
  /// </summary>
  /// <remarks>
  /// E desenvolvido todos as implementa��o de regra de neg�cio
  /// </remarks>
  TObjectActionCustom = class(TComponent)
  public
    /// <summary>
    /// Atualiza informa��es
    /// </summary>
    procedure Refresh; virtual;

    /// <summary>
    /// Limpa vari�veis
    /// </summary>
    /// <example>
    /// FNome := '';
    /// </example>
    procedure Clear; Virtual;
    procedure AfterConstruction; override;
  end;

implementation

uses uDMUtils, uFactoryObject;

{ TObjectActionCustom }

procedure TObjectActionCustom.AfterConstruction;
begin
  inherited;
  Clear;
end;

procedure TObjectActionCustom.Clear;
begin
end;

procedure TObjectActionCustom.Refresh;
begin

end;

initialization

RegisterClass(TObjectActionCustom);

end.
