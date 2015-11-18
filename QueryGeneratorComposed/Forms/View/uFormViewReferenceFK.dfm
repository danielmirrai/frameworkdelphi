inherited FormViewReferenceFK: TFormViewReferenceFK
  Caption = 'Listagem de ReferenceFK'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Navegate: TcxGroupBox
    object btnFields: TcxButton
      Left = 7
      Top = 4
      Width = 122
      Height = 29
      Cursor = crHandPoint
      Action = actCamposTabelaOrigem
      DragCursor = crHandPoint
      TabOrder = 5
    end
    object btnCampoTabelaReferencia: TcxButton
      Left = 135
      Top = 4
      Width = 146
      Height = 29
      Cursor = crHandPoint
      Action = actCamposTabelaReferencia
      DragCursor = crHandPoint
      TabOrder = 6
    end
  end
  inherited ActionList: TActionList
    Left = 406
    object actGeneretorSQL: TAction
      Caption = 'Generetor SQL'
    end
    object actFullScript: TAction
      Caption = 'Todos tipos SQL'
    end
    object actCamposTabelaOrigem: TAction
      Caption = 'Campos da tb. origem'
    end
    object actCamposTabelaReferencia: TAction
      Caption = 'Campos da tb. refer'#234'ncia'
    end
  end
end
