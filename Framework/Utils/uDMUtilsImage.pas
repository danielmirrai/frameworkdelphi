{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }

unit uDMUtilsImage;

interface

uses
  Windows, uConstantUtils, Classes, Forms, Graphics, jpeg, SysUtils, Types;

type
  TRGBArray = array [Word] of TRGBTriple;
  pRGBArray = ^TRGBArray;
  TRGBTripleArray = array [0 .. 32767] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

  TDMUtilsImage = class
  private
  public
    class procedure CaptureScreen(aFileName: string);
    class procedure ResizeImage(aFileName: string; aMaxWidth: Integer;
      aMaxHeight: Integer = nCST_Zero);
    class procedure SmoothResize(aSrc, aDst: TBitmap);
    class function SaveJPEGPictureFile(aBitmap: TBitmap;
      aFilePath, aFileName: string; aQuality: Integer): Boolean;
    class procedure QualityResizeBitmap(bmpOrig, bmpDest: TBitmap;
      newWidth, newHeight: Integer);
    class function AjustarImagem(ImgW, ImgH, nW, nH: Integer): TRect;
    class procedure ImgJpegRezise(ObjJpg: TJPEGImage; Width, Height: Integer);
    class procedure SetJPGCompression(ACompression: Integer;
      const AInFile: string; const AOutFile: string);
    class procedure StreamToByteArray(const poStream: TStream;
      out poByteDynArray: TByteDynArray);
    class procedure ByteArrayToStream(const poByteDynArray: TByteDynArray;
      const poStream: TStream);

  end;

implementation

uses uDMUtils, uDMUtilsMessage;

{ TDMUtilsImage }

class function TDMUtilsImage.AjustarImagem(ImgW, ImgH, nW, nH: Integer): TRect;
var
  xySpct: Double;
begin
  if ((ImgW > nCST_Zero) and (ImgH > nCST_Zero)) and ((ImgW > nW) or (ImgH > nH))
  then
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
      vDC := GetDC(nCST_Zero);
      vBitmapCanvas := TCanvas.Create;
      vBitmapCanvas.Handle := vDC;
      vBitmap.Canvas.CopyRect(Rect(0, nCST_Zero, vBitmap.Width, vBitmap.Height),
        vBitmapCanvas, Rect(0, nCST_Zero, Screen.Width, Screen.Height));

      vJpg := TJPEGImage.Create;
      vJpg.Assign(vBitmap);

      vPicture := TPicture.Create;

      vPicture.Assign(vJpg);
      vPicture.SaveToFile(aFileName);

      SetJPGCompression(40, aFileName, aFileName);
    except
      TDMUtils.MyException(sCST_ErrorSavingImage, True);
      exit;
    end;
  finally
    TDMUtils.DestroyObject(vBitmapCanvas);
    TDMUtils.DestroyObject(vJpg);
    TDMUtils.DestroyObject(vBitmap);
    TDMUtils.DestroyObject(vPicture);
  end;
end;

class procedure TDMUtilsImage.ImgJpegRezise(ObjJpg: TJPEGImage;
  Width, Height: Integer);
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
    TDMUtils.DestroyObject(ObjBmp);
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

      for pY := round(yIni) to round(yFin) do
      begin
        for pX := round(xIni) to round(xFin) do
        begin
          Inc(tpX);
          pxColor := ColorToRGB(bmpOrig.Canvas.Pixels[pX, pY]);
          R := R + GetRValue(pxColor);
          G := G + GetGValue(pxColor);
          B := B + GetBValue(pxColor);
        end;
      end;

      bmpDest.Canvas.Pixels[X, Y] := RGB(round(R / tpX), round(G / tpX),
        round(B / tpX));
    end;
  end;
end;

class procedure TDMUtilsImage.ResizeImage(aFileName: string; aMaxWidth: Integer;
  aMaxHeight: Integer = nCST_Zero);
var
  vOldBitmap, vNewBitmap: TBitmap;
  vJPEGImage: TJPEGImage;
begin
  vJPEGImage := nil;
  vOldBitmap := nil;
  vNewBitmap := nil;
  if not FileExists(aFileName) then
    exit;
  try
    try
      vJPEGImage := TJPEGImage.Create;
      vJPEGImage.LoadFromFile(aFileName);

      vOldBitmap := TBitmap.Create;
      vOldBitmap.Assign(vJPEGImage);

      vNewBitmap := TBitmap.Create;

      vNewBitmap.Width := aMaxWidth;
      vNewBitmap.Height := TDMUtils.IIf((aMaxHeight = nCST_Zero),
        MulDiv(aMaxWidth, vOldBitmap.Height, vOldBitmap.Width), aMaxHeight);
      SmoothResize(vOldBitmap, vNewBitmap);
      RenameFile(aFileName, ChangeFileExt(aFileName, '.$$$'));
      if SaveJPEGPictureFile(vNewBitmap, ExtractFilePath(aFileName),
        ExtractFileName(aFileName), aMaxWidth * 2) then
        DeleteFile(ChangeFileExt(aFileName, '.$$$'))
      else
        RenameFile(ChangeFileExt(aFileName, '.$$$'), aFileName);
    except
      TDMUtils.MyException('Resize Image');
    end;
  finally
    TDMUtils.DestroyObject(vOldBitmap);
    TDMUtils.DestroyObject(vJPEGImage);
    TDMUtils.DestroyObject(vNewBitmap);
  end;
end;

class function TDMUtilsImage.SaveJPEGPictureFile(aBitmap: TBitmap;
  aFilePath, aFileName: string; aQuality: Integer): Boolean;
var
  oJPegImage: TJPEGImage;
begin
  Result := True;
  try
    if not ForceDirectories(aFilePath) then
      exit;

    oJPegImage := TJPEGImage.Create;
    try
      oJPegImage.Assign(aBitmap);
      oJPegImage.CompressionQuality := aQuality;
      oJPegImage.SaveToFile(aFilePath + aFileName);
    finally
      TDMUtils.DestroyObject(oJPegImage);
    end;
  except
    raise;
    Result := False;
  end;
end;

class procedure TDMUtilsImage.SetJPGCompression(ACompression: Integer;
  const AInFile, AOutFile: string);
var
  iCompression: Integer;
  oJPG: TJPEGImage;
  oBMP: TBitmap;
begin
  iCompression := abs(ACompression);

  if iCompression = nCST_Zero then
    iCompression := nCST_One;

  if iCompression > 100 then
    iCompression := 100;

  oJPG := TJPEGImage.Create;
  oBMP := TBitmap.Create;
  try
    oJPG.LoadFromFile(AInFile);
    oBMP.Assign(oJPG);
    oJPG.CompressionQuality := iCompression;

    oJPG.Compress;
    oJPG.SaveToFile(AOutFile);
  finally
    TDMUtils.DestroyObject(oJPG);
    TDMUtils.DestroyObject(oBMP);
  end;
end;

class procedure TDMUtilsImage.SmoothResize(aSrc, aDst: TBitmap);
var
  X, Y: Integer;
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
  begin
    aDst.Assign(aSrc);
    exit;
  end;

  vDstLine := aDst.ScanLine[0];
  vDstGap := Integer(aDst.ScanLine[1]) - Integer(vDstLine);

  xP2 := MulDiv(pred(aSrc.Width), $10000, aDst.Width);
  yP2 := MulDiv(pred(aSrc.Height), $10000, aDst.Height);
  yP := nCST_Zero;

  for Y := nCST_Zero to pred(aDst.Height) do
  begin
    xP := nCST_Zero;

    vSrcLine1 := aSrc.ScanLine[yP shr 16];

    if (yP shr 16 < pred(aSrc.Height)) then
      vSrcLine2 := aSrc.ScanLine[succ(yP shr 16)]
    else
      vSrcLine2 := aSrc.ScanLine[yP shr 16];

    z2 := succ(yP and $FFFF);
    iz2 := succ((not yP) and $FFFF);
    for X := nCST_Zero to pred(aDst.Width) do
    begin
      t3 := xP shr 16;
      z := xP and $FFFF;
      w2 := MulDiv(z, iz2, $10000);
      w1 := iz2 - w2;
      w4 := MulDiv(z, z2, $10000);
      w3 := z2 - w4;
      vDstLine[X].rgbtRed := (vSrcLine1[t3].rgbtRed * w1 + vSrcLine1[t3 + 1]
        .rgbtRed * w2 + vSrcLine2[t3].rgbtRed * w3 + vSrcLine2[t3 + 1].rgbtRed *
        w4) shr 16;
      vDstLine[X].rgbtGreen := (vSrcLine1[t3].rgbtGreen * w1 + vSrcLine1[t3 + 1]
        .rgbtGreen * w2 +

        vSrcLine2[t3].rgbtGreen * w3 + vSrcLine2[t3 + 1].rgbtGreen * w4) shr 16;
      vDstLine[X].rgbtBlue := (vSrcLine1[t3].rgbtBlue * w1 + vSrcLine1[t3 + 1]
        .rgbtBlue * w2 + vSrcLine2[t3].rgbtBlue * w3 + vSrcLine2[t3 + 1]
        .rgbtBlue * w4) shr 16;
      Inc(xP, xP2);
    end;
    Inc(yP, yP2);
    vDstLine := pRGBArray(Integer(vDstLine) + vDstGap);
  end;
end;

class procedure TDMUtilsImage.StreamToByteArray(const poStream: TStream;
  out poByteDynArray: TByteDynArray);
begin
  poStream.Position := nCST_Zero;
  SetLength(poByteDynArray, poStream.Size);
  poStream.Read(Pointer(poByteDynArray)^, poStream.Size);
end;

class procedure TDMUtilsImage.ByteArrayToStream(const poByteDynArray
  : TByteDynArray; const poStream: TStream);
begin
  poStream.Position := nCST_Zero;
  poStream.Size := Length(poByteDynArray);
  poStream.Write(Pointer(poByteDynArray)^, Length(poByteDynArray));
end;

end.
