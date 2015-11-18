program ProjectQueryGeneratorComposed;

{%ToDo 'ProjectQueryGeneratorComposed.todo'}

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
  uFormMainQuery in 'Forms\Model\uFormMainQuery.pas' {FormMainQuery},
  uObjectActionQueryBuilder in 'ObjectAction\uObjectActionQueryBuilder.pas',
  uConstantQueryBuilder in 'Constant\uConstantQueryBuilder.pas',
  uFormMain;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TObjectDaoApplication, ObjectDaoApplication);
  Application.CreateForm(TFormMainQuery, FormMain);
  Application.Title := 'Gerador de query composta';
  Application.Run;
end.
