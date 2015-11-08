object FormBlockPC: TFormBlockPC
  Left = 0
  Top = 0
  Caption = 'FormBlockPC'
  ClientHeight = 202
  ClientWidth = 447
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  DesignSize = (
    447
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTempo: TLabel
    Left = 0
    Top = 0
    Width = 447
    Height = 13
    Align = alTop
    ExplicitWidth = 3
  end
  object edtSenha: TEdit
    Left = 0
    Top = 13
    Width = 447
    Height = 21
    Align = alTop
    CharCase = ecLowerCase
    TabOrder = 0
    OnExit = edtSenhaExit
    OnKeyDown = edtSenhaKeyDown
  end
  object btnBloquear: TButton
    Left = 371
    Top = 11
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Bloquear/Desbloquear'
    TabOrder = 1
    TabStop = False
    OnClick = btnBloquearClick
  end
  object btn1: TButton
    Left = 192
    Top = 112
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object tmrExibeTela: TTimer
    Enabled = False
    OnTimer = tmrExibeTelaTimer
    Left = 216
    Top = 48
  end
  object CDS1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 88
  end
end
