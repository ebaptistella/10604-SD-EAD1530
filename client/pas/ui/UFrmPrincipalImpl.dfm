object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 317
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 8
    Top = 139
    Width = 109
    Height = 17
    Caption = 'Tamanho da Pizza:'
  end
  object Label2: TLabel
    Left = 8
    Top = 187
    Width = 90
    Height = 17
    Caption = 'Sabor da Pizza:'
  end
  object Label3: TLabel
    Left = 488
    Top = 93
    Width = 142
    Height = 17
    Caption = 'Retorno do WebService:'
  end
  object Label4: TLabel
    Left = 16
    Top = 8
    Width = 51
    Height = 17
    Caption = 'Cliente: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCliente: TLabel
    Left = 68
    Top = 8
    Width = 501
    Height = 17
    AutoSize = False
    Caption = 'lblCliente'
  end
  object edtDocumentoCliente: TLabeledEdit
    Left = 8
    Top = 109
    Width = 193
    Height = 25
    EditLabel.Width = 122
    EditLabel.Height = 17
    EditLabel.Caption = 'N'#250'mero Documento:'
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 0
  end
  object cmbTamanhoPizza: TComboBox
    Left = 8
    Top = 159
    Width = 193
    Height = 25
    TabOrder = 1
    Items.Strings = (
      'enPequena'
      'enMedia'
      'enGrange')
  end
  object cmbSaborPizza: TComboBox
    Left = 8
    Top = 206
    Width = 193
    Height = 25
    TabOrder = 2
    Items.Strings = (
      'enCalabresa'
      'enMarguerita'
      'enPortuguesa')
  end
  object Button1: TButton
    Left = 68
    Top = 237
    Width = 133
    Height = 25
    Caption = 'Adicionar ao Pedido'
    TabOrder = 3
    OnClick = Button1Click
  end
  object mmRetornoWebService: TMemo
    Left = 505
    Top = 116
    Width = 177
    Height = 157
    Lines.Strings = (
      'mmRetornoWebService')
    TabOrder = 4
  end
  object edtEnderecoBackend: TLabeledEdit
    Left = 8
    Top = 58
    Width = 680
    Height = 25
    EditLabel.Width = 158
    EditLabel.Height = 17
    EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
    ReadOnly = True
    TabOrder = 5
    Text = 'http://localhost:8080/soap/IPizzariaBackendController'
  end
  object BitBtn1: TBitBtn
    Left = 584
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Trocar Cliente'
    TabOrder = 6
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 94
    Top = 268
    Width = 107
    Height = 25
    Caption = 'Consultar Total'
    TabOrder = 7
    OnClick = BitBtn2Click
  end
  object mTotais: TMemo
    Left = 207
    Top = 109
    Width = 292
    Height = 184
    Color = clBtnText
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'mTotais')
    ParentFont = False
    TabOrder = 8
  end
end
