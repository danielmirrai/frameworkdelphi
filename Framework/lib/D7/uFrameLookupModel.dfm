object FrameLookupModel: TFrameLookupModel
  Left = 0
  Top = 0
  Width = 335
  Height = 31
  TabOrder = 0
  OnResize = FrameResize
  object lblTitle: TLabel
    Left = 4
    Top = 6
    Width = 3
    Height = 13
  end
  object edtID: TcxDBTextEdit
    Tag = 1
    Left = 34
    Top = 3
    Width = 33
    Height = 21
    TabOrder = 0
    OnExit = edtIDExit
  end
  object edtDC: TcxDBTextEdit
    Tag = 1
    Left = 73
    Top = 3
    Width = 226
    Height = 21
    TabOrder = 1
    OnExit = edtDCExit
  end
  object btnSearch: TcxButton
    Left = 305
    Top = 3
    Width = 26
    Height = 24
    Cursor = crHandPoint
    TabOrder = 2
    OnClick = btnSearchClick
  end
end
