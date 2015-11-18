unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModelCustom, ActnList, Menus;

type
  TFormMain = class(TFormModelCustom)
    mm: TMainMenu;
    actlst: TActionList;
    ac_Close: TAction;
    ac_Refresh: TAction;
    act_OpenForm: TAction;
    procedure act_OpenFormExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AutoCreateMenus; virtual;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
implementation

uses uDMClasses, uFactoryObject, uFormViewModelCustom;

{$R *.dfm}

{ TFormPrincipal }

procedure TFormMain.AutoCreateMenus;
var
  I: Integer;
  aMenuItem: TMenuItem;
  ClassOfPersistent: TClassOfPersistent;
begin
  DMClasses.LockList;
  try
    for i := 0 to Length(DMClasses.ListTypeClass) - 1 do
    begin
      ClassOfPersistent := DMClasses.ListTypeClass[i];
      if not ClassOfPersistent.InheritsFrom(TFormViewModelCustom) then
        COntinue;

      aMenuItem := TMenuItem.Create(nil);            
      aMenuItem.OnClick := act_OpenFormExecute;
      aMenuItem.Name := ClassOfPersistent.ClassName;
      aMenuItem.Caption := aMenuItem.Name; 
      mm.Items.Add(aMenuItem);
    end;
  finally
    DMClasses.UnLockList;
    Application.ProcessMessages;
  end;
end;

procedure TFormMain.act_OpenFormExecute(Sender: TObject);
begin
  inherited;
  TFactoryObject.CreateComponent((Sender as TMenuItem).Name);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
//  AutoCreateMenus;
end;

end.
