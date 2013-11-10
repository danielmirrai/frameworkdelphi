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
unit uObjectDaoApplication;

interface

uses
  Classes, MidasLib, jpeg, Vcl.ImgList, Vcl.Controls;

type
  TObjectDaoApplication = class(TDataModule)
    Img1: TImageList;
    Img2: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization

RegisterClass(TObjectDaoApplication);

end.
