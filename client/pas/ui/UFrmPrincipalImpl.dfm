object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 305
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 596
    Height = 257
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Fazer Pedido'
      object Label1: TLabel
        Left = 16
        Top = 56
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 16
        Top = 104
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object Label3: TLabel
        Left = 232
        Top = 8
        Width = 118
        Height = 13
        Caption = 'Retorno do WebService:'
      end
      object Button1: TButton
        Left = 16
        Top = 160
        Width = 193
        Height = 57
        Caption = '&1 - Fazer Pedido'
        TabOrder = 0
        OnClick = Button1Click
      end
      object cmbSaborPizza: TComboBox
        Left = 16
        Top = 120
        Width = 193
        Height = 21
        TabOrder = 1
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object cmbTamanhoPizza: TComboBox
        Left = 16
        Top = 72
        Width = 193
        Height = 21
        TabOrder = 2
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrande')
      end
      object edtDocumentoCliente: TLabeledEdit
        Left = 16
        Top = 24
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 3
      end
      object mmRetornoWebService: TMemo
        Left = 232
        Top = 24
        Width = 345
        Height = 195
        Lines.Strings = (
          'mmRetornoWebService')
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consultar Pedido'
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 28
      object Label4: TLabel
        Left = 264
        Top = 4
        Width = 114
        Height = 13
        Caption = 'Informa'#231#245'es do Pedido:'
      end
      object Button2: TButton
        Left = 16
        Top = 58
        Width = 193
        Height = 57
        Caption = '&2 - Consultar Pedido'
        TabOrder = 0
        OnClick = Button2Click
      end
      object edtDocumentoClienteConsulta: TLabeledEdit
        Left = 16
        Top = 23
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 1
      end
      object mmRetornoConsultaPedido: TMemo
        Left = 16
        Top = 136
        Width = 193
        Height = 81
        Lines.Strings = (
          'mmRetornoConsultaPedido')
        TabOrder = 2
      end
      object mmResumoPedido: TMemo
        Left = 264
        Top = 23
        Width = 313
        Height = 194
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = [fsBold]
        Lines.Strings = (
          'mmResumoPedido')
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  object edtEnderecoBackend: TLabeledEdit
    Left = 20
    Top = 275
    Width = 561
    Height = 21
    EditLabel.Width = 131
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
    TabOrder = 1
    Text = 'http://localhost:8080/soap/IPizzariaBackendController'
  end
end
