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

unit uFormModelCustom;

interface

uses
  Classes, Controls, Forms;

type
  TFormModelCustom = class(TForm)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  protected
    FFirstActivate: Boolean;
    procedure DefinePropertiesStore; virtual;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    { Public declarations }
  end;

implementation

uses uConstantUtils;

{$R *.dfm}
{ TFormModelCustom }

procedure TFormModelCustom.AfterConstruction;
begin
  FFirstActivate := True;
  inherited;
  { SetResorcePortugues; }
  DefinePropertiesStore;
end;

procedure TFormModelCustom.BeforeDestruction;
begin
  inherited;
end;

procedure TFormModelCustom.DefinePropertiesStore;
begin {
    cxPropertiesStore.StorageName := TConstantUtils.GetRegistryPath(Self);
    cxPropertiesStore.Active := True;
    cxPropertiesStore.RestoreFrom; }
end;

procedure TFormModelCustom.FormActivate(Sender: TObject);
begin
  inherited;
  FFirstActivate := False;
end;

initialization

RegisterClass(TFormModelCustom);

end.
