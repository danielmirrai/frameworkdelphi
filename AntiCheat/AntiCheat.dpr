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

program AntiCheat;

uses
  Windows,
  Classes,
  SysUtils,
  Forms,
  uObjectActionProcess in 'ObjectAction\uObjectActionProcess.pas',
  uObjectDaoProcess in 'ObjectDao\uObjectDaoProcess.pas' {ObjectDaoProcess: TDataModule},
  uInterfaceXMLProcess in 'Interface\uInterfaceXMLProcess.pas',
  uConstantProcess in 'Constant\uConstantProcess.pas',
  uObjectActionLogin in 'ObjectAction\uObjectActionLogin.pas',
  uObjectdaoLogin in 'ObjectDao\uObjectdaoLogin.pas' {ObjectDaoLogin: TDataModule},
  uObjectDaoImage in 'ObjectDao\uObjectDaoImage.pas' {ObjectDaoImage: TDataModule},
  uObjectActionImage in 'ObjectAction\uObjectActionImage.pas',
  uConstantImage in 'Constant\uConstantImage.pas',
  uObjectDaoGame in 'ObjectDao\uObjectDaoGame.pas' {ObjectDaoGame: TDataModule},
  uObjectActionGame in 'ObjectAction\uObjectActionGame.pas',
  uFormAddLogin in 'Forms\Add\uFormAddLogin.pas' {FormAddLogin},
  uInterfaceXMLLogin in 'Interface\uInterfaceXMLLogin.pas',
  uInterfaceXMLErro in 'Interface\uInterfaceXMLErro.pas',
  uInterfaceXMLListGame in 'Interface\uInterfaceXMLListGame.pas',
  uFormPrincipal in 'Forms\Info\uFormPrincipal.pas' {FormPrincipal},
  uInterfaceXMLSucesso in 'Interface\uInterfaceXMLSucesso.pas',
  uFormViewSearchGame in 'Forms\View\uFormViewSearchGame.pas' {FormViewSearchGame},
  uObjectActionPlayers in 'ObjectAction\uObjectActionPlayers.pas',
  uObjectDaoPlayers in 'ObjectDao\uObjectDaoPlayers.pas' {ObjectDaoPlayers: TDataModule},
  uConstantPlayers in 'Constant\uConstantPlayers.pas',
  uInterfaceXMLPlayers in 'Interface\uInterfaceXMLPlayers.pas',
  uFormViewSearchPlayers in 'Forms\View\uFormViewSearchPlayers.pas' {FormViewSearchPlayers},
  uConstantSystem in 'Constant\uConstantSystem.pas',
  uConstantAntiCheat in 'Constant\uConstantAntiCheat.pas',
  uConstantUtils in 'Framework\Constant\uConstantUtils.pas',
  uFormModelCustom in 'Framework\Forms\Model\uFormModelCustom.pas' {FormModelCustom},
  uFormModel in 'Framework\Forms\Model\uFormModel.pas' {FormModel},
  uFormAddModelCustom in 'Framework\Forms\Add\uFormAddModelCustom.pas' {FormAddModelCustom},
  uFormAddModel in 'Framework\Forms\Add\uFormAddModel.pas' {FormAddModel},
  uFormGridCustom in 'Framework\Forms\View\uFormGridCustom.pas' {FormGridCustom},
  uFormGrid in 'Framework\Forms\View\uFormGrid.pas' {FormGrid},
  uFormViewModelCustom in 'Framework\Forms\View\uFormViewModelCustom.pas' {FormViewModelCustom},
  uFormViewModel in 'Framework\Forms\View\uFormViewModel.pas' {FormViewModel},
  uFormViewSearchModelCustom in 'Framework\Forms\View\uFormViewSearchModelCustom.pas' {FormViewSearchModelCustom},
  uFormViewSearchModel in 'Framework\Forms\View\uFormViewSearchModel.pas' {FormViewSearchModel},
  uObjectAction in 'Framework\ObjectAction\uObjectAction.pas',
  uObjectDaoCustom in 'Framework\ObjectDao\uObjectDaoCustom.pas' {ObjectDaoCustom: TDataModule},
  uObjectDao in 'Framework\ObjectDao\uObjectDao.pas' {ObjectDao: TDataModule},
  uObjectDaoApplication in 'Framework\ObjectDao\uObjectDaoApplication.pas' {ObjectDaoApplication: TDataModule},
  uObjectActionCustom in 'Framework\ObjectAction\uObjectActionCustom.pas',
  MD5 in 'Framework\Utils\MD5.pas',
  uDMCript in 'Framework\Utils\uDMCript.pas',
  uDMException in 'Framework\Utils\uDMException.pas',
  uDMFileInfoUtils in 'Framework\Utils\uDMFileInfoUtils.pas',
  uDMHash in 'Framework\Utils\uDMHash.pas',
  uDMHTTP in 'Framework\Utils\uDMHTTP.pas',
  uDMInfoComputer in 'Framework\Utils\uDMInfoComputer.pas',
  uDMList in 'Framework\Utils\uDMList.pas',
  uDMRegistry in 'Framework\Utils\uDMRegistry.pas',
  uDMUtils in 'Framework\Utils\uDMUtils.pas',
  uDMUtilsDao in 'Framework\Utils\uDMUtilsDao.pas',
  uDMUtilsImage in 'Framework\Utils\uDMUtilsImage.pas',
  uDMUtilsMessage in 'Framework\Utils\uDMUtilsMessage.pas',
  uDMValidateProcess in 'Framework\Utils\uDMValidateProcess.pas',
  uFactoryObject in 'Framework\Utils\uFactoryObject.pas',
  uTraducaoDevExpressBR in 'Framework\Constant\uTraducaoDevExpressBR.pas',
  uDMSevenZip in 'Framework\Utils\uDMSevenZip.pas',
  uInfoRam in 'Framework\Utils\uInfoRam.pas',
  SevenZipVCL in 'Framework\Terceiros\SevenZip\SevenZipVCL.pas',
  MagicApiHook in 'Framework\Terceiros\MagicApiHook\MagicApiHook.pas';

{$R *.res}


begin
{  handle := FindWindow('TFormPrincipal', nil);
  if Handle = 0 then
  begin                                  }
    Application.Initialize;
    Application.Title := 'Gamer AntiCheat';            
   Application.CreateForm(TObjectDaoApplication, ObjectDaoApplication);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;                      {
  end
  else
    ShowWindow(handle, SW_RESTORE);    }
end.

