object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 255
  ClientWidth = 583
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
    Top = 54
    Width = 118
    Height = 13
    Caption = 'Retorno do WebService:'
  end
  object mmRetornoWebService: TMemo
    Left = 312
    Top = 73
    Width = 265
    Height = 174
    Lines.Strings = (
      'mmRetornoWebService')
    TabOrder = 0
  end
  object edtEnderecoBackend: TLabeledEdit
    Left = 16
    Top = 24
    Width = 273
    Height = 21
    EditLabel.Width = 131
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
    TabOrder = 1
    Text = 'http://localhost:8080/soap/IPizzariaBackendController'
  end
  object PageControl1: TPageControl
    Left = 16
    Top = 51
    Width = 297
    Height = 198
    ActivePage = TabSheet2
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Realizar Pedido'
      ExplicitWidth = 365
      ExplicitHeight = 217
      object Label1: TLabel
        Left = 9
        Top = 47
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 9
        Top = 90
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object edtDocumentoCliente: TLabeledEdit
        Left = 9
        Top = 18
        Width = 273
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 0
      end
      object cmbTamanhoPizza: TComboBox
        Left = 9
        Top = 63
        Width = 273
        Height = 21
        TabOrder = 1
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrande')
      end
      object cmbSaborPizza: TComboBox
        Left = 9
        Top = 106
        Width = 273
        Height = 21
        TabOrder = 2
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object Button1: TButton
        Left = 177
        Top = 142
        Width = 105
        Height = 25
        Caption = '&1 - Fazer Pedido'
        TabOrder = 3
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consultar Pedido'
      ImageIndex = 1
      ExplicitLeft = 1
      ExplicitTop = 22
      object Button2: TButton
        Left = 177
        Top = 45
        Width = 105
        Height = 25
        Caption = '&2 - Fazer Consulta'
        TabOrder = 0
        OnClick = Button2Click
      end
      object edtDocumentoClienteConsulta: TLabeledEdit
        Left = 9
        Top = 18
        Width = 273
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 1
      end
    end
  end
end
