object FrmConsultaPedido: TFrmConsultaPedido
  Left = 0
  Top = 0
  Caption = 'Consulta de pedidos'
  ClientHeight = 436
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 51
    Align = alTop
    TabOrder = 0
    object edtDocumentoCliente: TLabeledEdit
      Left = 10
      Top = 21
      Width = 193
      Height = 21
      EditLabel.Width = 98
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#250'mero Documento:'
      TabOrder = 0
    end
    object btnBuscar: TBitBtn
      Left = 216
      Top = 16
      Width = 145
      Height = 25
      Caption = 'Consultar &pedido'
      TabOrder = 1
      OnClick = btnBuscarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 51
    Width = 514
    Height = 344
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitHeight = 354
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 512
      Height = 342
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 48
      ExplicitTop = 48
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 395
    Width = 514
    Height = 41
    Align = alBottom
    TabOrder = 2
  end
end
