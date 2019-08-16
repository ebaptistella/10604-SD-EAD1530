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
    Button1: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    btn_consultapedido: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btn_consultapedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum,  UPedidoRetornoDTOImpl;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.btn_consultapedidoClick(Sender: TObject);
var
  tPizzariaController: IPizzariaBackendController;
  tPedidoRet : TPedidoRetornoDTO;
begin
  tPizzariaController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(tPizzariaController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));

  tPedidoRet := tPizzariaController.ConsultaPedido(edtDocumentoCliente.Text);

  mmRetornoWebService.Clear;
  mmRetornoWebService.Lines.Add('###########');
  mmRetornoWebService.Lines.Add('Pedido nrº: '+edtDocumentoCliente.Text + '  ');
  mmRetornoWebService.Lines.Add('| Pizza | - Tamanho: '+getPizzaTamanhoEnum(tPedidoRet.PizzaTamanho)+'. - Sabor: '+getPizzaSaborEnum(tPedidoRet.PizzaSabor)+'.');
  mmRetornoWebService.Lines.Add(' - Valor Total: '+ FormatCurr('R$ 0.00',tPedidoRet.ValorTotalPedido));
  mmRetornoWebService.Lines.Add(' - Tempo para preparar: '+ tPedidoRet.TempoPreparo.ToString + ' minutos.');
  mmRetornoWebService.Lines.Add('###########');
end;

end.
