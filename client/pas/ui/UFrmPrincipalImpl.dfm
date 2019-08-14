object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 324
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 284
    Height = 324
    ActivePage = ts1
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 285
    object ts1: TTabSheet
      Caption = '1 - Fazer Pedido'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object lbl1: TLabel
        Left = 16
        Top = 50
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object lbl2: TLabel
        Left = 16
        Top = 93
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object EdtDocumentoCliente: TLabeledEdit
        Left = 16
        Top = 21
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 0
      end
      object CmbTamanhoPizza: TComboBox
        Left = 16
        Top = 66
        Width = 193
        Height = 21
        TabOrder = 1
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrange')
      end
      object CmbSaborPizza: TComboBox
        Left = 16
        Top = 109
        Width = 193
        Height = 21
        TabOrder = 2
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object btn1: TButton
        Left = 56
        Top = 152
        Width = 105
        Height = 25
        Caption = '&1 - Fazer Pedido'
        TabOrder = 3
        OnClick = btn1Click
      end
    end
    object ts2: TTabSheet
      Caption = '2 - Consultar Pedido'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Pnl1: TPanel
        Left = 233
        Top = 0
        Width = 43
        Height = 296
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 238
        ExplicitWidth = 271
        ExplicitHeight = 257
      end
      object Pnl2: TPanel
        Left = 0
        Top = 0
        Width = 233
        Height = 296
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitHeight = 257
        object grp1: TGroupBox
          Left = 0
          Top = 0
          Width = 233
          Height = 105
          Align = alTop
          Caption = 'Filtro'
          TabOrder = 0
          ExplicitLeft = -83
          ExplicitTop = 128
          ExplicitWidth = 241
          object EdtDocumentoConsulta: TLabeledEdit
            Left = 19
            Top = 29
            Width = 193
            Height = 21
            EditLabel.Width = 98
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero Documento:'
            TabOrder = 0
          end
          object btnConsultar: TButton
            Left = 57
            Top = 63
            Width = 105
            Height = 25
            Caption = '&2 - Consultar Pedido'
            TabOrder = 1
            OnClick = btnConsultarClick
          end
        end
        object grp2: TGroupBox
          Left = 0
          Top = 105
          Width = 233
          Height = 191
          Align = alClient
          Caption = ' Resultado '
          TabOrder = 1
          ExplicitLeft = 8
          ExplicitTop = 89
          ExplicitHeight = 152
          object lbl4: TLabel
            Left = 12
            Top = 142
            Width = 74
            Height = 13
            Caption = 'Sabor da Pizza:'
          end
          object lbl5: TLabel
            Left = 12
            Top = 99
            Width = 90
            Height = 13
            Caption = 'Tamanho da Pizza:'
          end
          object EdtValorConsulta: TLabeledEdit
            Left = 12
            Top = 31
            Width = 193
            Height = 21
            EditLabel.Width = 63
            EditLabel.Height = 13
            EditLabel.Caption = 'Valor Pedido:'
            TabOrder = 0
          end
          object EdtTempoConsulta: TLabeledEdit
            Left = 12
            Top = 72
            Width = 193
            Height = 21
            EditLabel.Width = 71
            EditLabel.Height = 13
            EditLabel.Caption = 'Tempo Pedido:'
            TabOrder = 1
          end
          object CmbSaborConsulta: TComboBox
            Left = 12
            Top = 158
            Width = 193
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 2
            Items.Strings = (
              'enCalabresa'
              'enMarguerita'
              'enPortuguesa')
          end
          object CmbTamanhoConsulta: TComboBox
            Left = 12
            Top = 115
            Width = 193
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 3
            Items.Strings = (
              'enPequena'
              'enMedia'
              'enGrange')
          end
        end
      end
    end
    object ts3: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 2
      ExplicitWidth = 711
      ExplicitHeight = 314
      object EdtEnderecoBackend: TLabeledEdit
        Left = 16
        Top = 24
        Width = 273
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
        TabOrder = 0
        Text = 'http://localhost:8080/soap/IPizzariaBackendController'
      end
    end
  end
  object Pnl3: TPanel
    Left = 284
    Top = 0
    Width = 306
    Height = 324
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 328
    ExplicitTop = 46
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lbl3: TLabel
      Left = 6
      Top = 26
      Width = 118
      Height = 13
      Caption = 'Retorno do WebService:'
    end
    object mmoRetornoWebService: TMemo
      Left = 6
      Top = 45
      Width = 265
      Height = 217
      Lines.Strings = (
        'mmRetornoWebService')
      TabOrder = 0
    end
  end
end
