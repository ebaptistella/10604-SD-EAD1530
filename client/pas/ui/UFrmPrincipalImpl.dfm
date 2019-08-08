object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 280
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
  object Label3: TLabel
    Left = 312
    Top = 8
    Width = 118
    Height = 13
    Caption = 'Retorno do WebService:'
  end
  object mmRetornoWebService: TMemo
    Left = 312
    Top = 25
    Width = 265
    Height = 243
    Lines.Strings = (
      'mmRetornoWebService')
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = -1
    Top = 0
    Width = 307
    Height = 273
    ActivePage = TabSheet1
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Fazer Pedido'
      ExplicitLeft = 44
      ExplicitTop = 88
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
        Left = 16
        Top = 217
        Width = 105
        Height = 25
        Caption = '&1 - Fazer Pedido'
        TabOrder = 3
        OnClick = Button1Click
      end
      object edtEnderecoBackend: TLabeledEdit
        Left = 16
        Top = 24
        Width = 273
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
        TabOrder = 4
        Text = 'http://localhost:8080/soap/IPizzariaBackendController'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consultar Pedido'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Button2: TButton
        Left = 127
        Top = 217
        Width = 105
        Height = 25
        Caption = '&2 - Consultar Pedido'
        TabOrder = 0
        OnClick = Button2Click
      end
      object edtDocumentoClienteConsulta: TLabeledEdit
        Left = 24
        Top = 72
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 1
      end
      object edtEnderecoBackendConsulta: TLabeledEdit
        Left = 24
        Top = 32
        Width = 273
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
        TabOrder = 2
        Text = 'http://localhost:8080/soap/IPizzariaBackendController'
      end
    end
  end
end
