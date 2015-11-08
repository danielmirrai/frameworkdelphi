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


unit uFormAddLogin;
                                         
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, MidasLib,
  Dialogs, uFormAddModel, cxGraphics, cxControls, cxLookAndFeels, ShellAPI,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlue,
  cxClasses, cxPropertiesStore, ActnList, cxGroupBox, cxTextEdit,
  ExtCtrls, dxGDIPlusClasses, cxImage, cxLabel, StdCtrls, cxButtons, dxSkinsForm,
  dxSkinBlack, cxDBEdit,
  uObjectActionLogin, uObjectdaoLogin, uObjectDaoApplication, DB,
  cxHyperLinkEdit, uObjectActionCustom, SevenZipVCL,
  cxProgressBar, dxSkinsdxBarPainter, Menus, dxStatusBar,
  dxRibbonStatusBar, dxBar, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, dxSkinsDefaultPainters, uFormAddModelCustom;

type
  TFormAddLogin = class(TFormAddModel)
    lbl_Usuario: TcxLabel;
    lbl_Senha: TcxLabel;
    lbl_Titulo: TcxLabel;
    img_Login: TcxImage;
    lbl_Informativo: TcxLabel;
    edt_Login: TcxDBTextEdit;
    edt_Senha: TcxDBTextEdit;
    Timer: TTimer;  
    dxBarManager1: TdxBarManager;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    btn_Sair: TcxButton;
    btn_login: TcxButton;
    procedure dxRibbonStatusBar1Panels1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dxRibbonStatusBar1Panels3DblClick(Sender: TObject);
    procedure dxRibbonStatusBar1Panels1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure Clear;
    procedure UpdateStatusTime;
  public
    FObjectActionLogin: TObjectActionLogin;
    procedure Logout;           
    procedure Save; Override;
    procedure AfterConstruction; override;
    function GetObjectAction: TObjectActionLogin; reintroduce;
    { Public declarations }

  end;

var
  FormAddLogin: TFormAddLogin;

implementation

uses uDMUtils, uConstantProcess, uFormPrincipal, uConstantSystem;


{$R *.dfm}

{ TFormAddLogin }

procedure TFormAddLogin.AfterConstruction;
begin
  inherited;
  FObjectActionLogin := GetObjectAction;
  FObjectActionLogin.Add;
  UpdateStatusTime;
end;

procedure TFormAddLogin.Clear;
begin
  FObjectActionLogin.FObjectDaoLogin.Clear;
  FObjectActionLogin.Add;
end;



procedure TFormAddLogin.dxRibbonStatusBar1Panels1Click(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', cSiteDeveloper, '', '', 1);
end;

procedure TFormAddLogin.FormActivate(Sender: TObject);
begin
  inherited;
  TDMUtils.FocusSet(edt_Login);
end;

function TFormAddLogin.GetObjectAction: TObjectActionLogin;
begin
  Result := TObjectActionLogin(inherited GetObjectAction);
end;

procedure TFormAddLogin.Logout;
begin
  FObjectActionLogin.Logouf;
  Clear;
end;

procedure TFormAddLogin.Save;
begin
  inherited Save;
  Tag := mrCancel;
  FObjectActionLogin.Login;
  if FObjectActionLogin.FObjectDaoLogin.CDSDadosLOGGED.AsBoolean then
    Tag := mrOk;
end;

procedure TFormAddLogin.TimerTimer(Sender: TObject);
begin
  inherited;
  UpdateStatusTime;
end;

procedure TFormAddLogin.UpdateStatusTime;
begin
  dxRibbonStatusBar1.Panels[1].Text := TDMUtils.FormatDateTime2(Now);
end;

procedure TFormAddLogin.dxRibbonStatusBar1Panels3DblClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', cSiteDeveloper, '', '', 1);
end;

procedure TFormAddLogin.dxRibbonStatusBar1Panels1DblClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', cSiteCriarConta, '', '', 1);
end;

procedure TFormAddLogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if not FObjectActionLogin.FObjectDaoLogin.CDSDadosLOGGED.AsBoolean then
    Application.Terminate;
end;

initialization
  RegisterClass(TFormAddLogin);
  
end.

