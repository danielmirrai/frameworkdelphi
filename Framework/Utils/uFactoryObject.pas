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
  Forms, uObjectAction, uConstantUtils, classes, uObjectDaoCustom,
  uDMException, DB, DBClient, SysUtils, Windows, Controls, uDMUtilsDao,
  uFormModelCustom, uFormModel, uFormAddModel, uFormViewModel,
  uObjectDao;

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

    class function GetNameFormAdd(const psNameClass: String): string;
    class function GetNameFormView(const psNameClass: String): string;
    class function GetNameObjectAction(const psNameClass: String): string;
    class function GetNameObjectDao(const psNameClass: String): string;
    class function GetNameDMObject(const psNameClass,
      psNewName: String): string;
    class function CloneComponent(poOrigemComponent: TComponent; poOwner: TComponent): TComponent; Overload;
    class function CloneComponent(poOrigemComponent: TObject; poOwner: TComponent): TObject; Overload;
    class function OpenSearch(poObjectActionSearch, poObjectActionDest: TObjectAction; const psFieldID, psFieldDC: String): BOolean;

    class procedure UpdateLookupSearch(poObjectActionSearch, poObjectActionDest: TObjectAction; const psFieldID, psFieldDC: String;
      const pbUpdateDC: Boolean = True);
    // class procedure ImportValues(poObjectOrigem, poObjectDestino: TComponent);
  end;

const
  sMSG_ObjectNotFound = 'O objeto %s não existe.';

implementation

{ TFactoryObject }

uses uDMUtils, uObjectActionCustom;

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

class function TFactoryObject.CloneComponent(poOrigemComponent: TComponent; poOwner: TComponent)
  : TComponent;
var
  oMemoryStream: TMemoryStream;
  oOwner: TComponent;
begin
  Result := nil;
  if not Assigned(poOrigemComponent) then
    Exit;
  oMemoryStream := TMemoryStream.Create;
  try
    oMemoryStream.WriteComponent(poOrigemComponent);
    oMemoryStream.Position := 0;
    oOwner := poOrigemComponent.Owner;
    if Assigned(poOwner) then
      oOwner := poOwner;

    Result := TFactoryObject.CreateComponent(poOrigemComponent.ClassName, oOwner);
    oMemoryStream.ReadComponent(Result);
    Result.Assign(poOrigemComponent);
  finally
    TDMUtils.DestroyObject(oMemoryStream);
  end;
end;

class function TFactoryObject.CloneComponent(poOrigemComponent: TObject; poOwner: TComponent): TObject;
begin
  Result := nil;
  if not assigned(poOrigemComponent) then
    Exit;
  if poOrigemComponent is TComponent then
    Result := CloneComponent(TComponent(poOrigemComponent), poOwner)
  else
    Result := TFactoryObject.CreateComponent(poOrigemComponent.ClassName, poOwner);
end;

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
  begin
    if Assigned(oObjectAction) then
    begin
      oFormAddModel := TFactoryObject.CreateComponent
        (GetNameFormAdd(psNameClass), nil, oObjectAction) as TFormAddModel;
      Result := CreateComponent(TClassFormViewModel(oClass), poOwner,
        oFormAddModel);
      TFormViewModel(Result).CanCreateFormAddModel := True;
    end
    else
      Result := CreateComponent(TClassFormViewModel(oClass), poOwner,
        oFormAddModel)
  end
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

class function TFactoryObject.GetNameDMObject(const psNameClass,
  psNewName: String): string;
begin
  Result := StringReplace(psNameClass, 'FormView', psNewName,
    [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ObjectDao', psNewName,
    [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'FormAdd', psNewName,
    [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ObjectAction', psNewName,
    [rfReplaceAll, rfIgnoreCase]);
end;

class function TFactoryObject.GetNameFormAdd(const psNameClass: String): string;
begin
  Result := GetNameDMObject(psNameClass, 'FormAdd');
end;

class function TFactoryObject.GetNameFormView(const psNameClass
  : String): string;
begin
  Result := GetNameDMObject(psNameClass, 'FormView');
end;

class function TFactoryObject.GetNameObjectAction(const psNameClass
  : String): string;
begin
  Result := GetNameDMObject(psNameClass, 'ObjectAction');
end;

class function TFactoryObject.GetNameObjectDao(const psNameClass
  : String): string;
begin
  Result := GetNameDMObject(psNameClass, 'ObjectDao');
end;
class function TFactoryObject.OpenSearch(poObjectActionSearch, poObjectActionDest: TObjectAction; const psFieldID, psFieldDC: String): BOolean;
var
  oFormViewModel: TFormViewModel;
  sName: string;
begin
  Result := False;
  if not (Assigned(poObjectActionSearch) and Assigned(poObjectActionDest)) then
    Exit;
  sName := TFactoryObject.GetNameFormView(poObjectActionSearch.ClassName);
  oFormViewModel := TFactoryObject.CreateComponent(sName, nil, poObjectActionSearch) as TFormViewModel;
  try
    oFormViewModel.SelectModel := True;

    oFormViewModel.ShowModal;
    Result := (oFormViewModel.ModalResult = mrOk);
    if Result then
    begin
      TDMUtilsDao.SetValorField(poObjectActionDest.FObjectDao.CDSDados.FindField(psFieldID), poObjectActionSearch.FObjectDao.FieldID.AsInteger);
      TDMUtilsDao.SetValorField(poObjectActionDest.FObjectDao.CDSDados.FindField(psFieldDC), poObjectActionSearch.FObjectDao.FieldDC.AsString);
    end;
  finally
    TDMUtils.DestroyObject(oFormViewModel);
  end;
end;

class procedure TFactoryObject.UpdateLookupSearch(poObjectActionSearch, poObjectActionDest: TObjectAction; const psFieldID, psFieldDC: String;
  const pbUpdateDC: Boolean = True);
var
  oFieldID, oFieldDC: TField;
  bLocate, bEditou: Boolean;
begin
  if not (Assigned(poObjectActionDest) and Assigned(poObjectActionDest) and poObjectActionDest.FObjectDao.ExistData) then
    Exit;

  oFieldID := poObjectActionDest.FObjectDao.CDSDados.FindField(psFieldID);
  oFieldDC := poObjectActionDest.FObjectDao.CDSDados.FindField(psFieldDC);
  if not (Assigned(oFieldID) and Assigned(oFieldDC)) then
    Exit;

  poObjectActionDest.FObjectDao.SetBackupMasterSource;
  try
    bLocate := poObjectActionSearch.FObjectDao.CDSDados.Locate(TDMUtils.IIf(pbUpdateDC, poObjectActionSearch.FObjectDao.FieldID.FieldName, poObjectActionSearch.FObjectDao.FieldDC.FieldName),
        TDMUtils.IIf(pbUpdateDC, oFieldID.AsInteger, oFieldDC.AsString), [loCaseInsensitive, loPartialKey]);
    bEditou := not TDMUtilsdao.Editing(oFieldID.DataSet);
    if bEditou then
      oFieldID.DataSet.Edit;
    try
      if not bLocate then
      begin
        TDMUtilsDao.SetValorField(oFieldID, sCST_EmptyStr);
        TDMUtilsDao.SetValorField(oFieldDC, sCST_EmptyStr);
        OpenSearch(poObjectActionSearch, poObjectActionDest, psFieldID, psFieldDC);
        Exit;
      end;

      TDMUtilsDao.SetValorField(oFieldID, poObjectActionSearch.FObjectDao.FieldID.AsInteger);
      TDMUtilsDao.SetValorField(oFieldDC, poObjectActionSearch.FObjectDao.FieldDC.AsString);
    finally
      if bEditou then
        oFieldID.DataSet.Post;
    end;
  finally
    poObjectActionDest.FObjectDao.RevertBackupMasterSource;
  end;
end;

{
  class procedure TFactoryObject.ImportValues(poObjectOrigem, poObjectDestino: TComponent);

  var
  oRttiContext: TRttiContext;
  oRttiType: TRttiType;
  oRttiField: TRttiField;
  oValueOrigem, oValueDestino: TValue;
  oConvertVariant: Variant;
  begin
  if not (Assigned(poObjectOrigem) and Assigned(poObjectDestino) and
  (poObjectOrigem.ClassType = poObjectDestino.ClassType)
  and (not TDMUtils.ExisteString('<', poObjectDestino.ClassType.ClassName))) then
  Exit;

  oRttiContext := TRttiContext.Create;
  try
  oRttiType := oRttiContext.GetType(poObjectOrigem.ClassType);
  for oRttiField in oRttiType.GetFields do
  begin
  oValueOrigem := oRttiField.GetValue(poObjectOrigem);
  oValueDestino := oRttiField.GetValue(poObjectDestino);
  if oValueDestino.IsEmpty then
  Continue;

  if ( oValueOrigem.IsObject) then
  begin
  if (oValueOrigem.AsObject = oValueDestino.AsObject) then
  Continue;

  if (oValueOrigem.AsObject = nil) <> (oValueDestino.AsObject = nil) then
  oRttiField.SetValue(poObjectDestino, oValueOrigem)
  else
  ImportValues(oValueOrigem.AsObject, oValueDestino.AsObject);
  end
  else
  if oValueOrigem.TryAsType<Variant>(oConvertVariant) and
  (oValueOrigem.AsVariant <> oValueDestino.AsVariant) then
  oRttiField.SetValue(poObjectDestino, oValueOrigem);
  end;
  finally
  oRttiContext.Free;
  end;
  end; }

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
