// Sistema de Pedidos Pizzaria Master
// Programador: *****
// Data de Alteração: 16-08-2019
unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    mmRetornoWebService: TMemo;
    edtEnderecoBackend: TLabeledEdit;
    edtPortaBackend: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Rest.JSON, MVCFramework.RESTClient, UPedidoRealizaDTOImpl, System.Rtti,
  UPizzaSaborEnum, UPizzaTamanhoEnum;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Clt: TRestClient;
  oPedidoRealiza: TEfetuarPedidoDTO;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text,
    StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    oPedidoRealiza := ToPedidoRealiza.Create;
    try
      oPedidoRealiza.PizzaTamanho :=
        TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text);
      oPedidoRealiza.PizzaSabor :=
        TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text);
      oPedidoRealiza.DocumentoCliente := edtDocumentoCliente.Text;
      mmRetornoWebService.Text := Clt.doPOST('/efetuarPedido', [],
        TJson.ObjecttoJsonString(oPedidoRealiza)).BodyAsString;
    finally
      oPedidoRealiza.Free;
    end;
  finally
    Clt.Free;
  end;
end;

end.
