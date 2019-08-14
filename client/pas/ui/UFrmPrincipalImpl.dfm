object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 279
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    1058
    279)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 572
    Top = 43
    Width = 118
    Height = 13
    Caption = 'Retorno do WebService:'
  end
  object mmRetornoWebService: TMemo
    Left = 572
    Top = 60
    Width = 461
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'mmRetornoWebService')
    TabOrder = 0
    ExplicitWidth = 515
  end
  object edtEnderecoBackend: TLabeledEdit
    Left = 16
    Top = 24
    Width = 324
    Height = 21
    EditLabel.Width = 131
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
    TabOrder = 1
    Text = 'http://localhost:8080/soap/IPizzariaBackendController'
  end
  object PageControl1: TPageControl
    Left = 16
    Top = 57
    Width = 550
    Height = 208
    ActivePage = TabSheet2
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Fazer um Pedido'
      object Label1: TLabel
        Left = 10
        Top = 52
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 10
        Top = 95
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object edtDocumentoCliente: TLabeledEdit
        Left = 10
        Top = 23
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 0
      end
      object cmbTamanhoPizza: TComboBox
        Left = 10
        Top = 68
        Width = 193
        Height = 21
        TabOrder = 1
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrande')
      end
      object cmbSaborPizza: TComboBox
        Left = 10
        Top = 111
        Width = 193
        Height = 21
        TabOrder = 2
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object Button1: TButton
        Left = 10
        Top = 138
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
      object LabeledEditConsultaPedido: TLabeledEdit
        Left = 13
        Top = 26
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 0
      end
      object Button2: TButton
        Left = 13
        Top = 57
        Width = 105
        Height = 25
        Caption = '&2 - Consultar'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
end
