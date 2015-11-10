unit uFormMainQuery;

interface

uses
  Windows, Messages, uFormMain, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus;

type
  TFormMainQuery = class(TFormMain)
    imFormViewFields: TMenuItem;
    imFormViewReferenceFK: TMenuItem;
    procedure imFormViewFieldsClick(Sender: TObject);
    procedure imFormViewReferenceFKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uFormViewFields, uFormViewReferenceFK;
{$R *.dfm}

procedure TFormMainQuery.imFormViewFieldsClick(Sender: TObject);
begin
  inherited;
  TFormViewFields.OpenView;
end;

procedure TFormMainQuery.imFormViewReferenceFKClick(Sender: TObject);
begin
  inherited;
  TFormViewReferenceFK.OpenView;
end;

end.
