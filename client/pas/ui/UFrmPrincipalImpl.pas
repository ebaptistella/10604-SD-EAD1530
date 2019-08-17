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
    BTPedido: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    BTConsulta: TButton;
    edtValor: TLabeledEdit;
    edtTempo: TLabeledEdit;
    procedure BTPedidoClick(Sender: TObject);
    procedure BTConsultaClick(Sender: TObject);
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
  UPizzaSaborEnum, UPedidoRetornoDTOImpl;

{$R *.dfm}

procedure TForm1.BTPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.BTConsultaClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  RetornoDTO: TPedidoRetornoDTO;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  RetornoDTO:= oPizzariaBackendController.consultarPedido(edtDocumentoCliente.Text);
  edtValor.Text := FormatCurr('R$0.00',RetornoDTO.ValorTotalPedido);
  edtTempo.Text := RetornoDTO.TempoPreparo.ToString;
  cmbTamanhoPizza.ItemIndex := Integer(RetornoDTO.PizzaTamanho);
  cmbSaborPizza.ItemIndex := Integer(RetornoDTO.PizzaSabor);
end;

end.
