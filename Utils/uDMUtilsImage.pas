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

unit uDMUtilsImage;

interface
uses
  Windows, Classes, Forms, Graphics, jpeg, SysUtils, cxImage, Types, uConstantUtils;

type
  TRGBArray = array[Word] of TRGBTriple;
  pRGBArray = ^TRGBArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

  TDMUtilsImage = class
  private
  public
    class procedure CaptureScreen(aFileName: string);
    class procedure ResizeImage(aFileName: string; aMaxWidth: Integer; aMaxHeight: Integer = nCST_Zero);
    class procedure SmoothResize(aSrc, aDst: TBitmap);
    class function SaveJPEGPictureFile(aBitmap: TBitmap; aFilePath, aFileName: string; aQuality: Integer): Boolean;
    class procedure QualityResizeBitmap(bmpOrig, bmpDest: TBitmap; newWidth, newHeight: Integer);
    class function AjustarImagem(ImgW, ImgH, nW, nH: Integer): TRect;
    class procedure ImgJpegRezise(ObjJpg: TJPEGImage; Width, Height: Integer);
    class procedure SetJPGCompression(ACompression: integer; const AInFile: string; const AOutFile: string);
    class function PictureToBinary(var poImage: TcxImage): TStringList; overload;
    class function PictureToBinary(const psFilename: string): TStringList; overload;
    class function PictureToStream(var poImage: TcxImage): TMemoryStream;
    class function StreamToPicture(var poStream: TMemoryStream): TcxImage;
    class procedure StreamPictureToFile(var poStream: TMemoryStream; const psFileName: string);
    class function BinaryToPicture(const psValueImage: string): TcxImage;
    class function SaveImage(const psValueImage, psFilename: string): string;
    class function CreatecxImage: TcxImage;
    class procedure StreamToByteArray(const poStream: TStream; out poByteDynArray: TByteDynArray);
    class procedure ByteArrayToStream(const poByteDynArray: TByteDynArray; const poStream: TStream);

  end;
implementation

uses uDMUtils, uDMUtilsMessage;

{ TDMUtilsImage }

class function TDMUtilsImage.AjustarImagem(ImgW, ImgH, nW, nH: Integer): TRect;
var
  xySpct: Double;
begin
  if ((ImgW > nCST_Zero) and (ImgH > nCST_Zero)) and ((ImgW > nW) or (ImgH > nH)) then
  begin
    xySpct := ImgW / ImgH;
    if ImgW > ImgH then
    begin
      ImgW := nW;
      ImgH := Trunc(nW / xySpct);
      if ImgH > nH then
      begin
        ImgH := nH;
        ImgW := Trunc(nH * xySpct);
      end;
    end
    else
    begin
      ImgH := nH;
      ImgW := Trunc(nH * xySpct);
      if ImgW > nW then
      begin
        ImgW := nW;
        ImgH := Trunc(nW / xySpct);
      end;
    end;
  end;
  with Result do
  begin
    Left := nCST_Zero;
    Top := nCST_Zero;
    Right := ImgW;
    Bottom := ImgH;
  end;
end;

class procedure TDMUtilsImage.CaptureScreen(aFileName: string);
var
  vBitmapCanvas: TCanvas;
  vBitmap: TBitmap;
  vDC: hDC;
  vJpg: TJPEGImage;
  vPicture: TPicture;
begin
  vBitmapCanvas := nil;
  vJpg := nil;
  vBitmap := nil;
  vPicture := nil;
  try
    try
      if FileExists(aFileName) then
        DeleteFile(aFileName);

      TDMUtils.CreateDirectory(aFileName);
      vBitmap := TBitmap.Create;
      vBitmap.Width := round(Screen.Width);
      vBitmap.Height := round(Screen.Height);
      vDC := GetDC(0);
      vBitmapCanvas := TCanvas.Create;
      vBitmapCanvas.Handle := vDC;
      vBitmap.Canvas.CopyRect(Rect(0, 0, vBitmap.Width, vBitmap.Height),
        vBitmapCanvas, Rect(0, 0, Screen.Width, Screen.Height));

      vJpg := TJPEGImage.Create;
      vJpg.Assign(vBitmap);

      vPicture := TPicture.Create;

      vPicture.Assign(vJpg);
      vPicture.SaveToFile(aFileName);

      SetJPGCompression(40, aFileName, aFileName);
    except
      on E: Exception do
      begin
        TDMUtils.MyException(sCST_ErrorSavingImage, True);
        exit;
      end;
    end;
  finally
    TDMUtils.DestroyObject(vBitmapCanvas);
    TDMUtils.DestroyObject(vJpg);
    TDMUtils.DestroyObject(vBitmap);
    TDMUtils.DestroyObject(vPicture);
  end;
end;

class function TDMUtilsImage.CreatecxImage: TcxImage;
begin
  Result := TcxImage.Create(nil);
  Result.Properties.GraphicClassName := 'TJPEGImage';
end;

class procedure TDMUtilsImage.ImgJpegRezise(ObjJpg: TJPEGImage; Width,
  Height: Integer);
var
  fRect: TRect;
  ObjBmp: TBitmap;
begin
  ObjBmp := TBitmap.Create;
  try
    fRect := AjustarImagem(ObjJpg.Width, ObjJpg.Height, Width, Height);
    ObjJpg.Scale := jsFullSize;
    ObjBmp.Width := fRect.Right;
    ObjBmp.Height := fRect.Bottom;
    ObjBmp.Canvas.FillRect(fRect);
    ObjBmp.Canvas.StretchDraw(fRect, ObjJpg);
    ObjJpg.Assign(ObjBmp);
  finally
    ObjBmp.Free;
  end;
end;

class function TDMUtilsImage.PictureToBinary(var poImage: TcxImage): TStringList;
var
  otmpJPG: TJPEGImage;
  oMemoryStream: TMemoryStream;
  oByteArray: TByteDynArray;
  nIndex: Integer;
begin
  Result := TStringList.Create;
  Result.Clear;
  if poImage.Picture.Height > nCST_Zero then
  begin
    otmpJPG := TJPEGImage.Create;
    oMemoryStream := TMemoryStream.Create;
    try
      oTmpJPG.Assign(poImage.Picture.Graphic);
      poImage.Picture.Assign(otmpJPG);
      otmpJPG.SaveToStream(oMemoryStream);
      StreamToByteArray(oMemoryStream, oByteArray);
      for nIndex := nCST_Zero to Length(oByteArray) do
        Result.Add(TDMUtils.IntToStr2(oByteArray[nIndex]));
    finally
      TDMUtils.DestroyObject(otmpJPG);
      TDMUtils.DestroyObject(oMemoryStream);
    end;
  end;
end;

class function TDMUtilsImage.PictureToBinary(const psFilename: string): TStringList;
var
  oImage: TcxImage;
begin
  Result := nil;
  if FileExists(psFilename) then
  begin
    oImage := TDMUtilsImage.CreatecxImage;
    try
      oImage.Picture.LoadFromFile(psFilename);
      Result := PictureToBinary(oImage);
    finally
      TDMUtils.DestroyObject(oImage);
    end;
  end;
end;

class function TDMUtilsImage.PictureToStream(var poImage: TcxImage): TMemoryStream;
var
  otmpJPG: TJPEGImage;
begin
  Result := TMemoryStream.Create;
  if poImage.Picture.Height > nCST_Zero then
  begin
    otmpJPG := TJPEGImage.Create;
    try
      oTmpJPG.Assign(poImage.Picture.Graphic);
      poImage.Picture.Assign(otmpJPG);
      otmpJPG.SaveToStream(Result);
    finally
      TDMUtils.DestroyObject(otmpJPG);
    end;
  end;
end;

class procedure TDMUtilsImage.QualityResizeBitmap(bmpOrig, bmpDest: TBitmap;
  newWidth, newHeight: Integer);
var
  xIni, xFin, yIni, yFin, xSalt, ySalt: Double;
  X, Y, pX, pY, tpX: Integer;
  R, G, B: Integer;
  pxColor: TColor;
begin
  bmpDest.Width := newWidth;
  bmpDest.Height := newHeight;

  xSalt := bmpOrig.Width / newWidth;
  ySalt := bmpOrig.Height / newHeight;

  yFin := nCST_Zero;
  for Y := nCST_Zero to pred(newHeight) do
  begin
    yIni := yFin;
    yFin := yIni + ySalt;
    if yFin >= bmpOrig.Height then
      yFin := pred(bmpOrig.Height);

    xFin := nCST_Zero;
    for X := nCST_Zero to pred(newWidth) do
    begin
      xIni := xFin;
      xFin := xIni + xSalt;
      if xFin >= bmpOrig.Width then
        xFin := pred(bmpOrig.Width);

      R := nCST_Zero;
      G := nCST_Zero;
      B := nCST_Zero;
      tpX := nCST_Zero;

      for pY := Round(yIni) to Round(yFin) do
        for pX := Round(xIni) to Round(xFin) do
        begin
          Inc(tpX);
          pxColor := ColorToRGB(bmpOrig.Canvas.Pixels[pX, pY]);
          R := R + GetRValue(pxColor);
          G := G + GetGValue(pxColor);
          B := B + GetBValue(pxColor);
        end;

      bmpDest.Canvas.Pixels[X, Y] := RGB(Round(R / tpX), Round(G / tpX), Round(B / tpX));
    end;
  end;
end;

class procedure TDMUtilsImage.ResizeImage(aFileName: string; aMaxWidth: Integer; aMaxHeight: Integer = nCST_Zero);
var
  vOldBitmap,
    vNewBitmap: TBitmap;
  vJPEGImage: TJPEGImage;
begin
  vJPEGImage := nil;
  vOldBitmap := nil;
  vNewBitmap := nil;
  if FileExists(aFileName) then
  begin
    try
      try
        vJPEGImage := TJPEGImage.Create;
        vJPEGImage.LoadFromFile(aFileName);

        vOldBitmap := TBitmap.Create;
        vOldBitmap.Assign(vJPEGImage);

        vNewBitmap := TBitmap.Create;

        vNewBitmap.Width := aMaxWidth;
        vNewBitmap.Height := TDMUtils.IIf((aMaxHeight = nCST_Zero), MulDiv(aMaxWidth, vOldBitmap.Height, vOldBitmap.Width), aMaxHeight);
        SmoothResize(vOldBitmap, vNewBitmap);
        RenameFile(aFileName, ChangeFileExt(aFileName, '.$$$'));
        if SaveJPEGPictureFile(vNewBitmap, ExtractFilePath(aFileName),
          ExtractFileName(aFileName), aMaxWidth * 2) then
          DeleteFile(ChangeFileExt(aFileName, '.$$$'))
        else
          RenameFile(ChangeFileExt(aFileName, '.$$$'), aFileName);
      except
        on E: Exception do
          Assert(False, e.Message);
      end;
    finally
      TDMUtils.DestroyObject(vOldBitmap);
      TDMUtils.DestroyObject(vJPEGImage);
      TDMUtils.DestroyObject(vNewBitmap);
    end;
  end;
end;

class function TDMUtilsImage.SaveImage(const psValueImage, psFilename: string): string;
var
  oImage: TcxImage;
begin
  if not TDMUtils.IsEmpty(psValueImage) then
  begin
    oImage := BinaryToPicture(psValueImage);
    try
      TDMUtils.CreateDirectory(psFilename);
      oImage.Picture.SaveToFile(psFilename);
    finally
      TDMUtils.DestroyObject(oImage);
    end;
  end;
end;

class function TDMUtilsImage.SaveJPEGPictureFile(aBitmap: TBitmap; aFilePath,
  aFileName: string; aQuality: Integer): Boolean;
begin
  Result := True;
  try
    if ForceDirectories(aFilePath) then
    begin
      with TJPegImage.Create do
      begin
        try
          Assign(aBitmap);
          CompressionQuality := aQuality;
          SaveToFile(aFilePath + aFileName);
        finally
          Free;
        end;
      end;
    end;
  except
    raise;
    Result := False;
  end;
end;

class procedure TDMUtilsImage.SetJPGCompression(ACompression: integer; const AInFile,
  AOutFile: string);
var

  iCompression: integer;

  oJPG: TJPegImage;

  oBMP: TBitMap;

begin

  { Forcar a Compressião para a faixa entre 1..100 }

  iCompression := abs(ACompression);

  if iCompression = nCST_Zero then

    iCompression := 1;

  if iCompression > 100 then

    iCompression := 100;

  { Cria as classes de trabalho Jpeg e Bmp }

  oJPG := TJPegImage.Create;

  oJPG.LoadFromFile(AInFile);

  oBMP := TBitMap.Create;

  oBMP.Assign(oJPG);

  { Fazer a Compressão e salva o novo arquivo }

  oJPG.CompressionQuality := iCompression;

  oJPG.Compress;

  oJPG.SaveToFile(AOutFile);

  { Limpar }

  oJPG.Free;
  oBMP.Free;
end;

class procedure TDMUtilsImage.SmoothResize(aSrc, aDst: TBitmap);
var
  x, y: Integer;
  xP, yP: Integer;
  xP2, yP2: Integer;
  vSrcLine1, vSrcLine2: pRGBArray;
  t3: Integer;
  z, z2, iz2: Integer;
  vDstLine: pRGBArray;
  vDstGap: Integer;
  w1, w2, w3, w4: Integer;
begin
  aSrc.PixelFormat := pf24Bit;
  aDst.PixelFormat := pf24Bit;

  if (aSrc.Width = aDst.Width) and (aSrc.Height = aDst.Height) then
    aDst.Assign(aSrc)
  else
  begin
    vDstLine := aDst.ScanLine[0];
    vDstGap := Integer(aDst.ScanLine[1]) - Integer(vDstLine);

    xP2 := MulDiv(pred(aSrc.Width), $10000, aDst.Width);
    yP2 := MulDiv(pred(aSrc.Height), $10000, aDst.Height);
    yP := nCST_Zero;

    for y := nCST_Zero to pred(aDst.Height) do
    begin
      xP := nCST_Zero;

      vSrcLine1 := aSrc.ScanLine[yP shr 16];

      if (yP shr 16 < pred(aSrc.Height)) then
        vSrcLine2 := aSrc.ScanLine[succ(yP shr 16)]
      else
        vSrcLine2 := aSrc.ScanLine[yP shr 16];

      z2 := succ(yP and $FFFF);
      iz2 := succ((not yp) and $FFFF);
      for x := nCST_Zero to pred(aDst.Width) do
      begin
        t3 := xP shr 16;
        z := xP and $FFFF;
        w2 := MulDiv(z, iz2, $10000);
        w1 := iz2 - w2;
        w4 := MulDiv(z, z2, $10000);
        w3 := z2 - w4;
        vDstLine[x].rgbtRed := (vSrcLine1[t3].rgbtRed * w1 +
          vSrcLine1[t3 + 1].rgbtRed * w2 +
          vSrcLine2[t3].rgbtRed * w3 + vSrcLine2[t3 + 1].rgbtRed * w4) shr 16;
        vDstLine[x].rgbtGreen :=
          (vSrcLine1[t3].rgbtGreen * w1 + vSrcLine1[t3 + 1].rgbtGreen * w2 +

          vSrcLine2[t3].rgbtGreen * w3 + vSrcLine2[t3 + 1].rgbtGreen * w4) shr 16;
        vDstLine[x].rgbtBlue := (vSrcLine1[t3].rgbtBlue * w1 +
          vSrcLine1[t3 + 1].rgbtBlue * w2 +
          vSrcLine2[t3].rgbtBlue * w3 +
          vSrcLine2[t3 + 1].rgbtBlue * w4) shr 16;
        Inc(xP, xP2);
      end; {for}
      Inc(yP, yP2);
      vDstLine := pRGBArray(Integer(vDstLine) + vDstGap);
    end; {for}
  end; {if}
end; {SmoothResize}

class procedure TDMUtilsImage.StreamToByteArray(const poStream: TStream; out poByteDynArray: TByteDynArray);
begin
  poStream.Position := nCST_Zero;
  SetLength(poByteDynArray, poStream.Size);
  poStream.Read(Pointer(poByteDynArray)^, poStream.Size);
end;

class function TDMUtilsImage.BinaryToPicture(const psValueImage: string): TcxImage;
var
  oTmpJPG: TJPEGImage;
  oMemoryStream: TMemoryStream;
  oByteArray: TByteDynArray;
  oListBinary: TStringList;
  nIndex: Integer;
begin
  Result := TDMUtilsImage.CreatecxImage;
  if (not TDMUtils.IsEmpty(psValueImage)) then
  begin
    oTmpJPG := TJPEGImage.Create;
    oListBinary := TDMUtils.Explode(psValueImage);
    oMemoryStream := TMemoryStream.Create;
    try
      SetLength(oByteArray, oListBinary.Count);
      for nIndex := nCST_Zero to oListBinary.Count - nCST_One do
        oByteArray[nIndex] := TDMUtils.StrToInt2(oListBinary.Strings[nIndex]);

      ByteArrayToStream(oByteArray, oMemoryStream);
      oTmpJPG.LoadFromStream(oMemoryStream);
      Result.Picture.Assign(oTmpJPG);
    finally
      TDMUtils.DestroyObject(oTmpJPG);
      TDMUtils.DestroyObject(oMemoryStream);
      TDMUtils.DestroyObject(oListBinary);
    end;
  end;
end;

class procedure TDMUtilsImage.ByteArrayToStream(const poByteDynArray: TByteDynArray; const poStream: TStream);
begin
  poStream.Position := nCST_Zero;
  poStream.Size := Length(poByteDynArray);
  poStream.Write(Pointer(poByteDynArray)^, Length(poByteDynArray));
end;

class function TDMUtilsImage.StreamToPicture(var poStream: TMemoryStream): TcxImage;
var
  otmpJPG: TJPEGImage;
begin
  Result := CreatecxImage;
  if Assigned(poStream) then
  begin
    otmpJPG := TJPEGImage.Create;
    try
      otmpJPG.LoadFromStream(poStream);
      Result.Picture.Assign(oTmpJPG);
    finally
      TDMUtils.DestroyObject(otmpJPG);
    end;
  end;
end;

class procedure TDMUtilsImage.StreamPictureToFile(var poStream: TMemoryStream; const psFileName: string);
var
  oImage: TcxImage;
begin
  oImage := StreamToPicture(poStream);
  try
    TDMUtils.CreateDirectory(psFileName);
    if Assigned(oImage) then
      oImage.Picture.SaveToFile(psFileName);
  finally
    TDMUtils.DestroyObject(oImage);
  end;
end;

end.
