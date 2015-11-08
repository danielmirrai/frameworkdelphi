{***********************************************************}
{                                                           }
{             Desenvolvido por Daniel Mirrai                }
{                                                           }
{              Programador Delphi Sênior                    }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Fones: +55 (51) 9413-3725 / 3111-2388            }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{***********************************************************}

unit uObjectDaoApplication;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, dxSkinsCore, dxSkinBlack, MidasLib, cxLookAndFeels,
  dxSkinsForm, ImgList, cxGraphics, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, 
  dxSkinFoggy, dxSkinGlassOceans, 
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, 
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, 
  dxSkinXmas2008Blue;

type
  TObjectDaoApplication = class(TDataModule)
    ImageList_16: TcxImageList;
    dxSkinController: TdxSkinController;
    ImageList_32: TcxImageList;
    ImageList_48: TcxImageList;
    ImageList_24: TcxImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  ObjectDaoApplication: TObjectDaoApplication;  
implementation

{$R *.dfm}

initialization
  RegisterClass(TObjectDaoApplication);

end.
