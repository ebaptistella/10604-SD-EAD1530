unit UFrmPrincipalImpl;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  UPizzaSaborEnum, UPedidoRetornoDTOImpl, Winapi.Windows;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl
                                  .GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text   := TJson.ObjectToJsonString(oPizzariaBackendController
                                       .efetuarPedido(
                                         TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text)
                                       , TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text)
                                       , edtDocumentoCliente.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  oPedidoDTO : TPedidoRetornoDTO;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);

  oPedidoDTO := oPizzariaBackendController.consultarPedido(edtDocumentoCliente.Text);

  mmRetornoWebService.Clear;
  mmRetornoWebService.Lines.Add('PEDIDO');
  mmRetornoWebService.Lines.Add('  Pizza: ');
  mmRetornoWebService.Lines.Add('      Tamanho: '+getNomePizzaTamanhoEnum(oPedidoDTO.PizzaTamanho)
                               +'; Sabor: '+getNomePizzaSaborEnum(oPedidoDTO.PizzaSabor)
                               +';');
  mmRetornoWebService.Lines.Add('  Valor Total: '+ FormatCurr('R$ 0.00',oPedidoDTO.ValorTotalPedido));
  mmRetornoWebService.Lines.Add('  Tempo de Preparo: '+ oPedidoDTO.TempoPreparo.ToString + ' minutos.');
end;

end.
