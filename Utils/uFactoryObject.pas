{***********************************************************}
{                                                           }
{                Developed by Daniel Mirrai                 }
{                                                           }
{                Senior Delphi Programmer                   }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{                   www.danielmirrai.com                    }
{***********************************************************}

unit uFactoryObject;

interface
uses
  uObjectActionCustom, classes, uObjectDaoCustom;

type
  TFactoryObject = class
  public
    class function CreateObject(aClassObjectAction: TClassObjectActionCustom): TObjectActionCustom; overload;
    class function CreateObject(aClassObjectAction: TClassObjectActionCustom; aOwner: TComponent): TObjectActionCustom; overload;
    class function CreateObject(aClassObjectDao: TClassObjectDaoCustom; aOwner: TComponent = nil): TObjectDaoCustom; overload;
  end;
implementation

{ TFactoryObject }

class function TFactoryObject.CreateObject(
  aClassObjectAction: TClassObjectActionCustom): TObjectActionCustom;
begin
  Result := aClassObjectAction.Create;
end;

class function TFactoryObject.CreateObject(
  aClassObjectDao: TClassObjectDaoCustom; aOwner: TComponent = nil): TObjectDaoCustom;
begin
  Result := aClassObjectDao.Create(aOwner);
end;

class function TFactoryObject.CreateObject(aClassObjectAction: TClassObjectActionCustom; aOwner: TComponent): TObjectActionCustom;
begin
  Result := TFactoryObject.CreateObject(aClassObjectAction);
  Result.Owner := aOwner;
end;

end.
