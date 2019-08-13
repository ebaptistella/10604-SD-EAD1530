object FrmTelaInicial: TFrmTelaInicial
  Left = 0
  Top = 0
  Caption = 'Sistema de Pizzaria'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnEfetuarPedido: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 94
      Height = 51
      Align = alLeft
      Caption = '&Efetuar Pedido'
      TabOrder = 0
      OnClick = btnEfetuarPedidoClick
    end
    object btnConsultarPedido: TButton
      AlignWithMargins = True
      Left = 103
      Top = 3
      Width = 94
      Height = 51
      Align = alLeft
      Caption = '&Consultar Pedido'
      TabOrder = 1
    end
  end
end
