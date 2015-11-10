program ProjectQueryGeneratorComposed;

uses
  Forms,
  uObjectDaoApplication,
  uFormAddFields in 'Forms\Add\uFormAddFields.pas' {FormAddFields},
  uFormAddReferenceFK in 'Forms\Add\uFormAddReferenceFK.pas' {FormAddReferenceFK},
  uObjectDaoFields in 'ObjectDao\uObjectDaoFields.pas' {ObjectDaoFields: TDataModule},
  uObjectDaoReferenceFK in 'ObjectDao\uObjectDaoReferenceFK.pas' {ObjectDaoReferenceFK: TDataModule},
  uObjectActionFields in 'ObjectAction\uObjectActionFields.pas',
  uObjectActionReferenceFK in 'ObjectAction\uObjectActionReferenceFK.pas',
  uConstantFields in 'Constant\uConstantFields.pas',
  uConstantReferenceFK in 'Constant\uConstantReferenceFK.pas',
  uObjectDaoAplicacaoQuery in 'ObjectDao\uObjectDaoAplicacaoQuery.pas' {ObjectDaoAplicacaoQuery: TDataModule},
  uFormViewFields in 'Forms\View\uFormViewFields.pas' {FormViewFields},
  uFormViewReferenceFK in 'Forms\View\uFormViewReferenceFK.pas' {FormViewReferenceFK},
  uFormMain in '..\Framework\Forms\Model\uFormMain.pas' {FormMain},
  uFormMainQuery in 'Forms\Model\uFormMainQuery.pas' {FormMainQuery};

{$R *.res}

var
  FormMainQuery: TFormMainQuery;
begin
  Application.Initialize;
  Application.CreateForm(TObjectDaoAplicacaoQuery, ObjectDaoApplication);
  Application.CreateForm(TFormMainQuery, FormMainQuery);
  Application.Title := 'Gerador de query composta';
  Application.Run;
end.
