object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 532
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 93
    Width = 90
    Height = 13
    Caption = 'Tamanho da Pizza:'
  end
  object Label2: TLabel
    Left = 16
    Top = 136
    Width = 74
    Height = 13
    Caption = 'Sabor da Pizza:'
  end
  object Label3: TLabel
    Left = 312
    Top = 8
    Width = 118
    Height = 13
    Caption = 'Retorno do WebService:'
  end
  object edtDocumentoCliente: TLabeledEdit
    Left = 16
    Top = 64
    Width = 193
    Height = 21
    EditLabel.Width = 98
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#250'mero Documento:'
    TabOrder = 0
  end
  object cmbTamanhoPizza: TComboBox
    Left = 16
    Top = 109
    Width = 193
    Height = 21
    TabOrder = 1
    Items.Strings = (
      'enPequena'
      'enMedia'
      'enGrande')
  end
  object cmbSaborPizza: TComboBox
    Left = 16
    Top = 152
    Width = 193
    Height = 21
    TabOrder = 2
    Items.Strings = (
      'enCalabresa'
      'enMarguerita'
      'enPortuguesa')
  end
  object Button1: TButton
    Left = 104
    Top = 216
    Width = 105
    Height = 25
    Caption = '&1 - Fazer Pedido'
    TabOrder = 3
    OnClick = Button1Click
  end
  object mmRetornoWebService: TMemo
    Left = 312
    Top = 25
    Width = 265
    Height = 217
    Lines.Strings = (
      'mmRetornoWebService')
    TabOrder = 4
  end
  object edtEnderecoBackend: TLabeledEdit
    Left = 16
    Top = 24
    Width = 273
    Height = 21
    EditLabel.Width = 131
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
    TabOrder = 5
    Text = 'http://localhost:8080/soap/IPizzariaBackendController'
  end
  object Button2: TButton
    Left = 224
    Top = 300
    Width = 105
    Height = 25
    Caption = '2 - Consultar Pedido'
    TabOrder = 6
    OnClick = Button2Click
  end
  object edtConsulta: TLabeledEdit
    Left = 16
    Top = 302
    Width = 193
    Height = 21
    EditLabel.Width = 98
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#250'mero Documento:'
    TabOrder = 7
  end
  object Panel1: TPanel
    Left = 8
    Top = 329
    Width = 321
    Height = 168
    TabOrder = 8
    object Label4: TLabel
      Left = 24
      Top = 16
      Width = 44
      Height = 13
      Caption = 'Tamanho'
    end
    object Label5: TLabel
      Left = 24
      Top = 51
      Width = 28
      Height = 13
      Caption = 'Sabor'
    end
    object Label6: TLabel
      Left = 24
      Top = 86
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label7: TLabel
      Left = 24
      Top = 122
      Width = 91
      Height = 13
      Caption = 'Tempo de Preparo '
    end
    object edtTamanho: TEdit
      Left = 144
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtSabor: TEdit
      Left = 144
      Top = 50
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtTotal: TEdit
      Left = 144
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object edtTempo: TEdit
      Left = 144
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
end
