object FrameLookupModel: TFrameLookupModel
  Left = 0
  Top = 0
  Width = 303
  Height = 22
  AutoScroll = False
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
    Left = 2
    Top = 1
    TabOrder = 0
    OnExit = edtIDExit
    Width = 33
  end
  object edtDC: TcxDBTextEdit
    Tag = 1
    Left = 41
    Top = 1
    TabOrder = 1
    OnExit = edtDCExit
    Width = 226
  end
  object btnSearch: TcxButton
    Left = 273
    Top = 0
    Width = 26
    Height = 22
    Cursor = crHandPoint
    TabOrder = 2
    OnClick = btnSearchClick
  end
end
