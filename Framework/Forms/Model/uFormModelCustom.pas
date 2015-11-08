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
    constructor Create(poOwner: TComponent); Override;
    procedure Assign(Source: TPersistent); overload; Override;
    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); reintroduce; Overload; virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    { Public declarations }
  end;

implementation

uses uConstantUtils, uObjectActionTimeExecuting;

{$R *.dfm}
{ TFormModelCustom }

procedure TFormModelCustom.AfterConstruction;
begin
  FFirstActivate := True;
  inherited;
  { SetResorcePortugues; }
  DefinePropertiesStore;
end;

procedure TFormModelCustom.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oFormModelCustom: TFormModelCustom;
begin
  inherited Assign(Source);
  if not(Assigned(Source) and (Source is TFormModelCustom)) then
    Exit;

  oFormModelCustom := TFormModelCustom(Source);
  FFirstActivate := oFormModelCustom.FFirstActivate;
end;

procedure TFormModelCustom.Assign(Source: TPersistent);
begin
  Assign(Source, True);
end;

procedure TFormModelCustom.BeforeDestruction;
begin
  inherited;
end;

constructor TFormModelCustom.Create(poOwner: TComponent);
begin
  inherited Create(poOwner);

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
