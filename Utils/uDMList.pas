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

unit uDMList;

interface
uses Classes, Contnrs;

type
  TListStringList = class(TObjectList)
  private
    function GetItems(Index: Integer): TStringList;
    procedure SetItems(Index: Integer; const Value: TStringList);
  public
    function Add: TStringList; overload;
    function Add(aList: TStringList): TStringList; overload;
    function Add(aText: string): TStringList; overload;
    constructor Create; overload;
    destructor Destroy; override;
    property Items[Index: Integer]: TStringList read GetItems write SetItems;
  end;
implementation

{ TListStringList }

function TListStringList.Add: TStringList;
var
  vNew: TStringList;
begin
  vNew := TStringList.Create;
  Result := Add(vNew);
end;

function TListStringList.Add(aList: TStringList): TStringList;
begin
  inherited Add(aList);
  result := aList;
end;

function TListStringList.Add(aText: string): TStringList;
var
  vNewList: TStringList;
begin
  vNewList := TStringList.Create;
  vNewList.Text := aText;
  Result := Add(vNewList);
end;

constructor TListStringList.Create;
begin
  inherited Create;
end;

destructor TListStringList.Destroy;
begin
  inherited Destroy;
end;

function TListStringList.GetItems(Index: Integer): TStringList;
begin
  Result := TStringList(inherited Items[index]);
end;

procedure TListStringList.SetItems(Index: Integer; const Value: TStringList);
begin
  inherited Items[Index] := Value;
end;

end.
