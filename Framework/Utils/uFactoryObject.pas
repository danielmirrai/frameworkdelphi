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

unit uFactoryObject;

interface

uses
  Vcl.Forms, uObjectAction, uConstantUtils, classes, uObjectDaoCustom,
  uDMException,
  uFormModelCustom, uFormModel, uFormAddModel, uFormViewModel, uObjectDao;

type
  TCreateObject = Class of TComponent;
  eObjectNotFound = class(eDMExcepetion);

  TFactoryObject = class
  public
    class function CreateComponent(const poClasse: TClassObjectDao;
      poOwner: TComponent = nil): TComponent; Overload;
    class function CreateComponent(const poClasse: TClassFormViewModel;
      poOwner: TComponent = nil; poFormAddModel: TFormAddModel = nil)
      : TComponent; Overload;
    class function CreateComponent(const poClasse: TClassFormAddModel;
      poOwner: TComponent = nil; poObjectAction: TObjectAction = nil)
      : TComponent; Overload;
    class function CreateComponent(const poClasse: TClassObjectAction;
      poOwner: TComponent = nil; poObjectDao: TObjectDao = nil)
      : TComponent; Overload;
    class function CreateComponent(const poClasse: TCreateObject;
      poOwner: TComponent = nil): TComponent; Overload;
    class function CreateComponent(const poClasse: TClassFormModel;
      poOwner: TComponent = nil): TComponent; Overload;

    class function CreateComponent(const psNameClass: String;
      poOwner: TComponent = nil; poChildren: TObject = nil)
      : TComponent; Overload;
  end;

const
  sMSG_ObjectNotFound = 'O objeto %s não existe.';

implementation

{ TFactoryObject }

class function TFactoryObject.CreateComponent(const poClasse: TCreateObject;
  poOwner: TComponent): TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner);
end;

class function TFactoryObject.CreateComponent(const poClasse: TClassFormModel;
  poOwner: TComponent): TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner);
end;

class function TFactoryObject.CreateComponent(const poClasse
  : TClassFormAddModel; poOwner: TComponent; poObjectAction: TObjectAction)
  : TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner, poObjectAction);
end;

class function TFactoryObject.CreateComponent(const poClasse
  : TClassFormViewModel; poOwner: TComponent; poFormAddModel: TFormAddModel)
  : TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner, poFormAddModel);
end;

{ TFactoryObject }

class function TFactoryObject.CreateComponent(const psNameClass: String;
  poOwner: TComponent; poChildren: TObject): TComponent;
var
  oClass: TPersistentClass;
  oObjectDao: TObjectDao;
  oFormAddModel: TFormAddModel;
  oObjectAction: TObjectAction;
begin
  Result := nil;
  oClass := GetClass(psNameClass);

  if not Assigned(oClass) then
    raise eObjectNotFound.CreateFmt(sMSG_ObjectNotFound, [psNameClass]);

  oObjectDao := nil;
  oFormAddModel := nil;
  oObjectAction := nil;

  if Assigned(poChildren) then
  begin
    if poChildren is TObjectDao then
      oObjectDao := TObjectDao(poChildren)
    else if poChildren is TFormAddModel then
      oFormAddModel := TFormAddModel(poChildren)
    else if poChildren is TObjectAction then
      oObjectAction := TObjectAction(poChildren);
  end;

  if oClass.InheritsFrom(TObjectDao) then
    Result := CreateComponent(TClassObjectDao(oClass), poOwner)
  else if oClass.InheritsFrom(TFormViewModel) then
    Result := CreateComponent(TClassFormViewModel(oClass), poOwner,
      oFormAddModel)
  else if oClass.InheritsFrom(TFormAddModel) then
    Result := CreateComponent(TClassFormAddModel(oClass), poOwner,
      oObjectAction)
  else if oClass.InheritsFrom(TObjectAction) then
    Result := CreateComponent(TClassObjectAction(oClass), poOwner, oObjectDao)
  else if oClass.InheritsFrom(TFormModel) then
    Result := CreateComponent(TClassFormModel(oClass), poOwner)
  else if oClass.InheritsFrom(TComponent) then
    Result := CreateComponent(TFormClass(oClass), poOwner)
end;

class function TFactoryObject.CreateComponent(const poClasse
  : TClassObjectAction; poOwner: TComponent; poObjectDao: TObjectDao)
  : TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner, poObjectDao);
end;

class function TFactoryObject.CreateComponent(const poClasse: TClassObjectDao;
  poOwner: TComponent): TComponent;
begin
  Result := nil;
  if Assigned(poClasse) then
    Result := poClasse.Create(poOwner);
end;

end.
