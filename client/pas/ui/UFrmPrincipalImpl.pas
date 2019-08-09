unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  UPedidoRetornoDTOImpl, typinfo, Vcl.ComCtrls;

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
    BtnConsultarPedido: TButton;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure BtnConsultarPedidoClick(Sender: TObject);


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
  UPizzaSaborEnum;

{$R *.dfm}

procedure TForm1.BtnConsultarPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  oPedidoRetornoDTO: TPedidoRetornoDTO;
begin
  if edtDocumentoCliente.Text = EmptyStr then
    exit;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);

  oPedidoRetornoDTO := oPizzariaBackendController.consultarPedido
    (edtDocumentoCliente.Text);
  mmRetornoWebService.Clear;

  mmRetornoWebService.Lines.Add('Tamanho da Pizza= ' +
    Copy(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
    (oPedidoRetornoDTO.PizzaTamanho), 3,
    length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
    (oPedidoRetornoDTO.PizzaTamanho))));
  mmRetornoWebService.Lines.Add('Sabor da Pizza  = ' +
    Copy(TRttiEnumerationType.GetName<TPizzaSaborEnum>
    (oPedidoRetornoDTO.PizzaSabor), 3,
    length(TRttiEnumerationType.GetName<TPizzaSaborEnum>
    (oPedidoRetornoDTO.PizzaSabor))));

  mmRetornoWebService.Lines.Add('Preço da Pizza  = ' + FormatCurr('R$ 0.00',
    oPedidoRetornoDTO.ValorTotalPedido));

  mmRetornoWebService.Lines.Add('Tempo de Preparo= ' +
    oPedidoRetornoDTO.TempoPreparo.ToString + ' Minutos');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString
    (oPizzariaBackendController.efetuarPedido
    (TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text),
    TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text),
    edtDocumentoCliente.Text));
end;



end.
