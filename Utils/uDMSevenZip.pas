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

unit uDMSevenZip;

interface

uses
  SevenZipVCL, Classes, Dialogs, SysUtils, cxProgressBar, cxLabel, Windows, Forms;

type
  TDMSevenZip = class
    private
    FProgressBar: TcxProgressBar;
    FCaption: TcxLabel;
      procedure SetSevenZip(const Value: TSevenZip);
    procedure SetProgressBar(const Value: TcxProgressBar);
    procedure SetCaption(const Value: TcxLabel);

    protected
      FOpenDialog: TOpenDialog;
      FSevenZip :TSevenZip;
      procedure SevenZipOnOpenVolume(var FileName: WideString;
        Removable: Boolean; out Cancel: Boolean); virtual;
      procedure SevenZipOnExtractOverwrite(Sender: TObject;
        FileName: WideString; var DoOverwrite: Boolean); virtual;
      procedure SevenZipOnPreProgress(Sender: TObject; MaxProgress: Int64);
      procedure SevenZipOnProgress(Sender: TObject; Filename: WideString;
        FilePosArc, FilePosFile: Int64); virtual;
      procedure SevenZipOnAddfile(Sender: TObject; Filename: WideString;
        Filesize: Int64); virtual;
      procedure SevenZipOnListfile(Sender: TObject; Filename: WideString;
        Fileindex, FileSizeU, FileSizeP, Fileattr, Filecrc: int64;
        Filemethod: WideString; FileTime: Double); virtual;
      procedure SevenZipOnExtractfile(Sender: TObject; Filename: WideString;
        Filesize: Int64); virtual;
      procedure SevenZipOnMessage(Sender: TObject; ErrCode: Integer;
        Message: String; Filename: WideString); virtual;
        procedure SevenZipOnSetAddName(Sender: TObject; FileIndex: Cardinal;
      var OldFileName: WideString);virtual;
      procedure SevenZipOnSetExtractName(Sender: TObject; FileIndex: Cardinal;
        var OldFileName: WideString); virtual;
      procedure Configure;
    public
      procedure Cancel;
      function AddFile(aFileName: string): Boolean; Overload;
      function AddFile(aFileName: TStringList): Boolean; Overload;
      procedure SetZipName(aName: String);
      function OpenFile(aDirectory: String = 'C:\'): Boolean;
      function Extract(aFileName, aDirectoryNew: String): Boolean;
      procedure AfterConstruction; override;
      procedure BeforeDestruction; override;
      property SevenZip :TSevenZip read FSevenZip write SetSevenZip;
      property ProgressBar: TcxProgressBar read FProgressBar write SetProgressBar;
      property Caption: TcxLabel read FCaption write SetCaption;


  end;

implementation

uses uDMUtils;

{ TDMSevenZip }

function TDMSevenZip.AddFile(aFileName: string): Boolean;
var
  vList: TStringList;
begin
  vList := nil;
  try
    vList := TStringList.Create;
    vList.Add(aFileName);
    Result := AddFile(vList);
  finally
    TDMUtils.DestroyObject(vList);
  end;
end;

function TDMSevenZip.AddFile(aFileName: TStringList): Boolean;
var
  vReturn, vIndex: Integer;
begin
  FSevenZip.Files.Clear;
  for vIndex := 0 to aFileName.Count -1 do
  begin
    FSevenZip.Files.AddString(pchar(aFileName.Strings[vIndex]));
  end;

  vReturn := FSevenZip.Add;
  Result  := vReturn > -1;
end;

procedure TDMSevenZip.AfterConstruction;
begin
  inherited;
  FOpenDialog := TOpenDialog.Create(nil);
  FSevenZip   := TSevenZip.Create(nil);
  Configure;
end;

procedure TDMSevenZip.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FSevenZip);
  TDMUtils.DestroyObject(FOpenDialog);
  inherited;
end;

procedure TDMSevenZip.Cancel;
begin
  FSevenZip.Cancel;
end;

procedure TDMSevenZip.Configure;
begin
  FSevenZip.OnAddfile             := SevenZipOnAddfile;
  FSevenZip.OnExtractfile         := SevenZipOnExtractfile;
  FSevenZip.OnExtractOverwrite    := SevenZipOnExtractOverwrite;
  FSevenZip.OnListfile            := SevenZipOnListfile;
  FSevenZip.OnMessage             := SevenZipOnMessage;
  FSevenZip.OnOpenVolume          := SevenZipOnOpenVolume;
  FSevenZip.OnPreProgress         := SevenZipOnPreProgress;
  FSevenZip.OnProgress            := SevenZipOnProgress;
  FSevenZip.OnSetAddName          := SevenZipOnSetAddName;
  FSevenZip.OnSetExtractName      := SevenZipOnSetExtractName;
  FSevenZip.AddOptions            := [AddRecurseDirs];
  FSevenZip.LZMACompressStrength  := NORMAL;
  FSevenZip.LZMACompressType      := LZMA;
  FSevenZip.SFXCreate             := False;
  SetZipName('');
  FSevenZip.Password := '';
end;

function TDMSevenZip.Extract(aFileName, aDirectoryNew: String): Boolean;
var
  vReturn : integer;
begin
  //select extract dir
  FSevenZip.ExtrBaseDir := aDirectoryNew;

  //Overwrite existing files during extrect ?
  FSevenZip.ExtractOptions := FSevenZip.ExtractOptions + [ExtractOverwrite];

  //Clear Extractlist - for all files do nothing else
  FSevenZip.Files.clear;
  FSevenZip.Files.AddString(aFileName);

  //extract files
  vReturn := FSevenZip.Extract;

  Result := vReturn > 0;
end;

function TDMSevenZip.OpenFile(aDirectory: String): Boolean;
begin
  Result := True;
  FOpenDialog.InitialDir := aDirectory;
  if FOpenDialog.Execute then
    FSevenZip.SZFileName := FOpenDialog.FileName
  else
    Result := False;
end;

procedure TDMSevenZip.SetCaption(const Value: TcxLabel);
begin
  FCaption := Value;
end;

procedure TDMSevenZip.SetProgressBar(const Value: TcxProgressBar);
begin
  FProgressBar := Value;
end;

procedure TDMSevenZip.SetSevenZip(const Value: TSevenZip);
begin
  FSevenZip := Value;
end;

procedure TDMSevenZip.SetZipName(aName: String);
begin
  FSevenZip.SZFileName := aName;
end;

procedure TDMSevenZip.SevenZipOnAddfile(Sender: TObject; Filename: WideString;
  Filesize: Int64);
begin
  inherited;
  if Assigned(FCaption) then
    FCaption.Caption            := 'Aguarde... '+filename;

  if Assigned(FProgressBar) then
  begin
    Fprogressbar.Position       := 0;
    FProgressBar.Properties.Max := Filesize;
  end;
end;

procedure TDMSevenZip.SevenZipOnExtractfile(Sender: TObject;
  Filename: WideString; Filesize: Int64);
begin
  inherited;
  if Assigned(FCaption) then
    FCaption.caption            := filename;

  if Assigned(FProgressBar) then
  begin
    FProgressBar.position       := 0;
    FProgressBar.Properties.Max := filesize;
  end;
end;

procedure TDMSevenZip.SevenZipOnExtractOverwrite(Sender: TObject;
  FileName: WideString; var DoOverwrite: Boolean);
begin
  inherited;
   DOOverwrite := true;
end;

procedure TDMSevenZip.SevenZipOnListfile(Sender: TObject; Filename: WideString;
  Fileindex, FileSizeU, FileSizeP, Fileattr, Filecrc: int64;
  Filemethod: WideString; FileTime: Double);
begin
  inherited;
end;

procedure TDMSevenZip.SevenZipOnMessage(Sender: TObject; ErrCode: Integer;
  Message: String; Filename: WideString);
begin
  inherited;
end;

procedure TDMSevenZip.SevenZipOnOpenVolume(var FileName: WideString;
  Removable: Boolean; out Cancel: Boolean);
begin
  inherited;
end;

procedure TDMSevenZip.SevenZipOnPreProgress(Sender: TObject;
  MaxProgress: Int64);
begin
  inherited;
  if Assigned(FProgressBar) then
  begin
    if Maxprogress > 0 then
      FProgressBar.Properties.Max := Maxprogress;
  end;
end;

procedure TDMSevenZip.SevenZipOnProgress(Sender: TObject; Filename: WideString;
  FilePosArc, FilePosFile: Int64);
begin
  inherited;
  if Assigned(FProgressBar) then
  begin
    //progress of all files
    FProgressBar.Position := fileposArc;

    //progress of current file
    FProgressBar.Position := fileposfile;
    Application.ProcessMessages;
  end;
end;

procedure TDMSevenZip.SevenZipOnSetAddName(Sender: TObject; FileIndex: Cardinal;
  var OldFileName: WideString);
begin
  inherited;
end;

procedure TDMSevenZip.SevenZipOnSetExtractName(Sender: TObject;
  FileIndex: Cardinal; var OldFileName: WideString);
begin
  inherited;
end;

end.
