unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    btnFazerPedido: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    btnResumoPedido: TButton;
    procedure btnFazerPedidoClick(Sender: TObject);
    procedure btnResumoPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl,
  Rtti, REST.JSON,
  UPizzaTamanhoEnum,
  UPizzaSaborEnum,
  System.JSON;

{$R *.dfm}

procedure TForm1.btnFazerPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.btnResumoPedidoClick(Sender: TObject);
var
  oPizzariaBackendController1: IPizzariaBackendController;
  obj : TJsonObject;
begin
  if edtDocumentoCliente.Text = EmptyStr then
    raise Exception.Create('Você deve informar o documento para consultar os pedidos');

  oPizzariaBackendController1 := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  Obj := TJson.ObjectToJsonObject(oPizzariaBackendController1.consultarPedido(edtDocumentoCliente.Text));
  mmRetornoWebService.Lines.Clear;
  mmRetornoWebService.Lines.Add('----------- Seu pedido ------------');
  mmRetornoWebService.Lines.Add('Tamanho........:'  + Obj.Get('pizzaTamanho').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Sabor..........:'  + Obj.Get('pizzaSabor').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Valor Total....:'  + Obj.Get('valorTotalPedido').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Tempo Prep.....:'  + Obj.Get('tempoPreparo').JsonValue.Value);
  mmRetornoWebService.Lines.Add('-----------------------------------');
end;

end.
