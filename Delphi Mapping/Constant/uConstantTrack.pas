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
unit uConstantTrack;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Contnrs;

const
  cInitializationListClass = 'TYPE';
  cInitializationMethod =
    'CLASS_FUNCTION|CLASS_PROCEDURE|FUNCTION|PROCEDURE|CONSTRUCTOR|DESTRUCTOR|PROPERTY';
  cFinishUnit = 'END.';
  cFinish = 'END;|FINALIZATION|INITIALIZATION|IMPLEMENTATION|INTERFACE|' +
    cFinishUnit;
  cTypesMethods =
    'STRICT PROTECTED|STRICT PRIVATE|PRIVATE|PROTECTED|PUBLIC|PUBLISHED';
  cOperator = 'END|BEGIN|THEN|DO|ELSE';
  sCST_ClassVar = 'CLASS VAR';
  sCST_Var = 'VAR';
  cInitializationVar = sCST_ClassVar + '|' + sCST_Var + '|' + cTypesMethods;
  cInitializationConst = 'CONST';
  cInitializationUnit = 'UNIT';
  cInitializationClass = 'CLASS';
  cFinishMethods = ';';
  cFinishVariable = ':';
  cFinishConst = '=';
  cInitializationUses = 'USES';
  cInitializationParams = '(';
  cFinishParams = ')';
  cInitializationOther = cInitializationListClass + '|' + cFinish + '|' +
    cInitializationMethod + '|' + cTypesMethods + '|' + cInitializationVar + '|'
    + cInitializationConst + '|' + cInitializationUnit + '|' +
    cInitializationConst;

implementation

end.
