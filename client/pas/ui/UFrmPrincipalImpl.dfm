object FrmClientPrinc: TFrmClientPrinc
  Left = 0
  Top = 0
  Caption = 'Pizzaria Unoesc'
  ClientHeight = 369
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgPrincipal: TPageControl
    Left = 0
    Top = 97
    Width = 596
    Height = 272
    ActivePage = tsFazerPedido
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 342
    object tsFazerPedido: TTabSheet
      Caption = '  Fazer Pedido  '
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Label1: TLabel
        Left = 12
        Top = 9
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 12
        Top = 52
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object Label3: TLabel
        Left = 224
        Top = 9
        Width = 114
        Height = 13
        Caption = 'Informa'#231#245'es do pedido:'
      end
      object btnFazerPedido: TButton
        Left = 12
        Top = 100
        Width = 193
        Height = 25
        Cursor = crHandPoint
        Caption = '&1 - Fazer Pedido'
        TabOrder = 2
        OnClick = btnFazerPedidoClick
      end
      object cmbTamanhoPizza: TComboBox
        Left = 12
        Top = 25
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Pequena'
        Items.Strings = (
          'Pequena'
          'Media'
          'Grande')
      end
      object cmbSaborPizza: TComboBox
        Left = 12
        Top = 68
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'Calabresa'
        Items.Strings = (
          'Calabresa'
          'Marguerita'
          'Portuguesa')
      end
      object mmRetornoWebService: TMemo
        Left = 224
        Top = 25
        Width = 345
        Height = 217
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object tsConsultarPedido: TTabSheet
      Caption = '  Consultar Pedido  '
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Label4: TLabel
        Left = 12
        Top = 36
        Width = 104
        Height = 13
        Caption = 'Pedidos encontrados:'
      end
      object btnConsultarpPedido: TButton
        Left = 12
        Top = 5
        Width = 193
        Height = 25
        Cursor = crHandPoint
        Caption = '&2 - Consultar Pedido'
        TabOrder = 0
        OnClick = btnConsultarpPedidoClick
      end
      object mmDadosPedido: TMemo
        Left = 12
        Top = 51
        Width = 565
        Height = 190
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object Label5: TLabel
      Left = 16
      Top = 49
      Width = 98
      Height = 13
      Caption = 'N'#250'mero Documento:'
    end
    object edtEnderecoBackend: TLabeledEdit
      Left = 16
      Top = 24
      Width = 273
      Height = 21
      TabStop = False
      Color = clBtnFace
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
      ReadOnly = True
      TabOrder = 0
      Text = 'http://localhost:8080/soap/IPizzariaBackendController'
    end
    object edtDocumentoCliente: TMaskEdit
      Left = 16
      Top = 65
      Width = 112
      Height = 21
      EditMask = '!999.999.999-99;0;_'
      MaxLength = 14
      TabOrder = 1
      Text = ''
    end
  end
end
