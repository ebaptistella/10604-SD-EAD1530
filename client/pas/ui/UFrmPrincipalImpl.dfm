object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 443
  ClientWidth = 687
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
    Top = 57
    Width = 687
    Height = 386
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 401
    object TabSheet1: TTabSheet
      Caption = 'Registrar Pedido'
      ExplicitHeight = 373
      object Label3: TLabel
        Left = 312
        Top = 8
        Width = 118
        Height = 13
        Caption = 'Retorno do WebService:'
      end
      object Label1: TLabel
        Left = 16
        Top = 57
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 16
        Top = 100
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object mmRetornoWebService: TMemo
        Left = 312
        Top = 25
        Width = 364
        Height = 328
        TabOrder = 0
      end
      object edtDocumentoCliente: TLabeledEdit
        Left = 16
        Top = 28
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 1
      end
      object cmbTamanhoPizza: TComboBox
        Left = 16
        Top = 73
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
        Top = 116
        Width = 193
        Height = 21
        TabOrder = 3
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object Button1: TButton
        Left = 104
        Top = 160
        Width = 105
        Height = 25
        Caption = '&1 - Fazer Pedido'
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consultar Pedido'
      ImageIndex = 1
      ExplicitHeight = 373
      object Label8: TLabel
        Left = 315
        Top = 8
        Width = 92
        Height = 13
        Caption = 'Resumo do Pedido:'
      end
      object edtNumeroDocumento: TLabeledEdit
        Left = 3
        Top = 22
        Width = 150
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 0
      end
      object Button2: TButton
        Left = 159
        Top = 22
        Width = 105
        Height = 25
        Caption = '2 - Consultar Pedido'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Panel1: TPanel
        Left = 312
        Top = 22
        Width = 364
        Height = 331
        Color = clInactiveCaption
        ParentBackground = False
        TabOrder = 2
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
          Width = 215
          Height = 21
          TabOrder = 0
        end
        object edtSabor: TEdit
          Left = 144
          Top = 50
          Width = 215
          Height = 21
          TabOrder = 1
        end
        object edtTotal: TEdit
          Left = 144
          Top = 85
          Width = 215
          Height = 21
          TabOrder = 2
        end
        object edtTempo: TEdit
          Left = 144
          Top = 120
          Width = 215
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 687
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object edtEnderecoBackend: TLabeledEdit
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
