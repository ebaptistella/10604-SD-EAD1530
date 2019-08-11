object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 438
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
  object PanelFazerPedido: TPanel
    Left = 3
    Top = 7
    Width = 585
    Height = 229
    Caption = 'PanelFazerPedido'
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 113
      Width = 90
      Height = 13
      Caption = 'Tamanho da Pizza:'
    end
    object Label2: TLabel
      Left = 16
      Top = 156
      Width = 74
      Height = 13
      Caption = 'Sabor da Pizza:'
    end
    object Label3: TLabel
      Left = 299
      Top = 8
      Width = 118
      Height = 13
      Caption = 'Retorno do WebService:'
    end
    object edtEnderecoBackend: TLabeledEdit
      Left = 16
      Top = 44
      Width = 273
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
      TabOrder = 0
      Text = 'http://localhost:8080/soap/IPizzariaBackendController'
    end
    object edtDocumentoCliente: TLabeledEdit
      Left = 16
      Top = 84
      Width = 193
      Height = 21
      EditLabel.Width = 98
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#250'mero Documento:'
      TabOrder = 1
    end
    object cmbTamanhoPizza: TComboBox
      Left = 16
      Top = 129
      Width = 193
      Height = 21
      TabOrder = 2
      Items.Strings = (
        'enPequena'
        'enMedia'
        'enGrande')
    end
    object cmbSaborPizza: TComboBox
      Left = 16
      Top = 172
      Width = 193
      Height = 21
      TabOrder = 3
      Items.Strings = (
        'enCalabresa'
        'enMarguerita'
        'enPortuguesa')
    end
    object Button1: TButton
      Left = 16
      Top = 199
      Width = 105
      Height = 25
      Caption = '&1 - Fazer Pedido'
      TabOrder = 4
      OnClick = Button1Click
    end
    object mmRetornoWebService: TMemo
      Left = 299
      Top = 27
      Width = 265
      Height = 193
      TabOrder = 5
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelTituloConsultarPedido'
      Color = clRed
      ParentBackground = False
      ShowCaption = False
      TabOrder = 6
      ExplicitLeft = 2
      ExplicitTop = 9
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 583
        Height = 18
        Align = alClient
        Alignment = taCenter
        Caption = 'FAZER PEDIDO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial Narrow'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 81
        ExplicitHeight = 16
      end
    end
  end
  object Panel1: TPanel
    Left = 3
    Top = 244
    Width = 585
    Height = 186
    Caption = 'PanelConsultarPedido'
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label6: TLabel
      Left = 146
      Top = 32
      Width = 58
      Height = 13
      Caption = 'Documento:'
    end
    object btnGetPedido: TButton
      Left = 394
      Top = 24
      Width = 65
      Height = 25
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = btnGetPedidoClick
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelTituloConsultarPedido'
      Color = clRed
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 583
        Height = 18
        Align = alClient
        Alignment = taCenter
        Caption = 'CONSULTAR PEDIDO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial Narrow'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 25
      end
    end
    object MemoRetornoConsulta: TMemo
      Left = 128
      Top = 49
      Width = 369
      Height = 135
      TabOrder = 2
    end
    object EditDocumentoPesquisar: TEdit
      Left = 206
      Top = 26
      Width = 188
      Height = 21
      TabOrder = 3
      TextHint = 'Digite aqui o n'#250'mero do documento...'
    end
  end
end
