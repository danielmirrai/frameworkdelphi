{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi Sênior }
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
  /// Controle ação
  /// </summary>
  /// <remarks>
  /// E desenvolvido todos as implementação de regra de negócio
  /// </remarks>
  TObjectActionCustom = class(TComponent)
  public
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; virtual;

    /// <summary>
    /// Limpa variáveis
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
