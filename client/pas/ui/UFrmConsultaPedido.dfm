object FrmConsultaPedido: TFrmConsultaPedido
  Left = 0
  Top = 0
  Caption = 'Consulta Pedido'
  ClientHeight = 353
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmConsultaPedido: TMemo
    Left = 0
    Top = 0
    Width = 415
    Height = 291
    Align = alClient
    TabOrder = 0
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 291
    Width = 415
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      415
      62)
    object Button1: TButton
      AlignWithMargins = True
      Left = 328
      Top = 0
      Width = 75
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = '&Consultar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 328
      Top = 34
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 1
    end
    object edtDoc: TEdit
      Left = 2
      Top = 8
      Width = 207
      Height = 21
      TabOrder = 2
      TextHint = 'Documento do cliente'
    end
    object edtEndereco: TEdit
      Left = 2
      Top = 35
      Width = 311
      Height = 21
      TabOrder = 3
      TextHint = 'Endere'#231'o do servidor'
    end
  end
end
