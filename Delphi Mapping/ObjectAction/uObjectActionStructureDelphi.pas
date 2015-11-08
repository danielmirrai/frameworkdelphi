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
unit uObjectActionStructureDelphi;

interface

uses uDMUtils, SysUtils, Variants, Graphics,

  Controls, Forms, Dialogs, StdCtrls, uObjectActionStructure,
  Contnrs, Classes;

type

  /// <summary>
  /// Definição de dados que será mapeado
  /// </summary>
  TObjectActionStructureDelphi = class(TObjectActionStructure)

  end;

  TListStructureDelphi = class(TListStructureData)

  end;

implementation

{ TItemUnit }

{ TListStructureDelphi }

initialization

RegisterClass(TObjectActionStructureDelphi);

end.
