inherited FormMainQuery: TFormMainQuery
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited mm: TMainMenu
    Left = 56
    object imFormViewFields: TMenuItem
      Caption = 'Campos'
      OnClick = imFormViewFieldsClick
    end
    object imFormViewReferenceFK: TMenuItem
      Caption = 'Tabelas'
      OnClick = imFormViewReferenceFKClick
    end
  end
end
